import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewAppointmentPage extends StatelessWidget {
  final selectedDate = DateTime.now().obs;
  final selectedTime = ''.obs;
  final TextEditingController nameC = TextEditingController();
  final TextEditingController descC = TextEditingController();

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(title: Text('New Appointment')),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('January', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            SizedBox(
              height: 80,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 30,
                separatorBuilder: (_, __) => SizedBox(width: 8),
                itemBuilder: (_, idx) {
                  final date = DateTime(DateTime.now().year, DateTime.now().month, idx + 1);
                  final selected = idx + 1 == DateTime.now().day;
                  return GestureDetector(
                    onTap: () => selectedDate.value = date,
                    child: Obx(() {
                      return Container(
                        width: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: selectedDate.value.day == date.day ? Color(0xFF6C4AB6) : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text('${date.day}', style: TextStyle(fontSize: 16, color: selectedDate.value.day == date.day ? Colors.white : Colors.black)),
                          Text(['Sun','Mon','Tue','Wed','Thu','Fri','Sat'][date.weekday % 7], style: TextStyle(color: selectedDate.value.day == date.day ? Colors.white70 : Colors.grey)),
                        ]),
                      );
                    }),
                  );
                },
              ),
            ),
            SizedBox(height: 24),

            Text('Available Time', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ['09:00 AM','10:00 AM','12:00 PM','02:00 PM','04:00 PM']
                  .map((t) => Obx(() {
                final sel = selectedTime.value == t;
                return ChoiceChip(
                  label: Text(t),
                  selectedColor: Color(0xFF6C4AB6),
                  labelStyle: TextStyle(color: sel ? Colors.white : Colors.black),
                  selected: sel,
                  onSelected: (_) => selectedTime.value = t,
                );
              }))
                  .toList(),
            ),

            SizedBox(height: 24),
            TextField(controller: nameC, decoration: InputDecoration(label: Text('Full name'))),
            SizedBox(height: 12),
            TextField(controller: descC, maxLines: 3, decoration: InputDecoration(label: Text('Write your problem'))),

            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(onPressed: () => Get.toNamed('/all-appointments'), child: Text('Set Appointment')),
            ),
          ]),
        ),
      ),
    );
  }
}
