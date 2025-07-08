import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManagerDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        CircleAvatar(radius: 60, backgroundImage: AssetImage('assets/icons/calendar_icon.png')),
        SizedBox(height: 12),
        Text('Prof. Alex Wellson', style: ctx.textTheme.titleLarge),
        Text('Quantum Physics', style: ctx.textTheme.bodyMedium),
        SizedBox(height: 24),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          _infoTile('1000+', Icons.people, 'Patients'),
          _infoTile('10 yrs', Icons.calendar_today, 'Experience'),
          _infoTile('4.5', Icons.star, 'Rating'),
        ]),
        SizedBox(height: 24),
        Text(
          'Dr. Belamy Nicholas is a top specialist at London Bridge Hospital at London....',
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 24),
        Column(children: [
          ListTile(leading: Icon(Icons.message), title: Text('Messaging')),
          ListTile(leading: Icon(Icons.call), title: Text('Audio Call')),
          ListTile(leading: Icon(Icons.video_call), title: Text('Video Call')),
        ]),
        SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () => Get.toNamed('/new-appointment'),
            child: Text('Book Appointment'),
          ),
        ),
      ]),
    );
  }

  Widget _infoTile(String value, IconData icon, String label) {
    return Column(children: [CircleAvatar(child: Icon(icon)), SizedBox(height: 4), Text(value), Text(label)]);
  }
}
