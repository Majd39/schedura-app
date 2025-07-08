import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/appointment.dart';

class AllAppointmentsPage extends StatelessWidget {
  final tab = 0.obs;
  final appointments = <Appointment>[
    Appointment(doctorName: 'Dr. Sophia Martinez, Ph.D.', specialty: 'Cosmetic Bioengineering', dateTime: DateTime.now(), status: 'Upcoming'),
    Appointment(doctorName: 'Dr. Sophia Martinez, Ph.D.', specialty: 'Cosmetic Bioengineering', dateTime: DateTime.now().subtract(Duration(days: 1)), status: 'Completed'),
  ];

  @override
  Widget build(BuildContext ctx) {
    return Column(children: [
      SizedBox(height: 16),
      ToggleButtons(
        isSelected: List.generate(3, (i) => i == tab.value),
        children: [Text('Complete'), Text('Upcoming'), Text('Cancelled')],
        onPressed: (i) => tab.value = i,
      ),
      Expanded(
        child: Obx(() {
          final filtered = appointments.where((a) => a.status == tabName(tab.value)).toList();
          return ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (_, i) {
              final a = filtered[i];
              return Card(
                child: ListTile(
                  title: Text(a.doctorName),
                  subtitle: Text('${a.specialty} · ${a.dateTime.hour}:${a.dateTime.minute.toString().padLeft(2,'0')}'),
                  trailing: Wrap(spacing: 8, children: [
                    if (a.status == 'Upcoming')
                      ElevatedButton(onPressed: () => Get.toNamed('/cancel-appointment'), child: Text('Cancel')),
                    if (a.status == 'Completed')
                      ElevatedButton(onPressed: () => Get.toNamed('/review'), child: Text('Add Review')),
                  ]),
                ),
              );
            },
          );
        }),
      ),
    ]);
  }

  String tabName(int i) {
    switch (i) {
      case 0:
        return 'Completed';
      case 1:
        return 'Upcoming';
      case 2:
        return 'Cancelled';
    }
    return '';
  }
}
