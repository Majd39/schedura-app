import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CancelAppointmentPage extends StatelessWidget {
  final reason = ''.obs;

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(title: Text('Cancel Appointment')),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Please let us know why you’re canceling:',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 12),
          RadioListTile<String>(
            title: Text('Rescheduling'),
            value: 'Rescheduling',
            groupValue: reason.value,
            onChanged: (v) => reason.value = v!,
          ),
          RadioListTile<String>(
            title: Text('Weather Conditions'),
            value: 'Weather',
            groupValue: reason.value,
            onChanged: (v) => reason.value = v!,
          ),
          RadioListTile<String>(
            title: Text('Unexpected Work'),
            value: 'Work',
            groupValue: reason.value,
            onChanged: (v) => reason.value = v!,
          ),
          RadioListTile<String>(
            title: Text('Others'),
            value: 'Other',
            groupValue: reason.value,
            onChanged: (v) => reason.value = v!,
          ),
          SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(label: Text('Enter your reason')),
            maxLines: 3,
          ),
          Spacer(),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () => Get.back(),
              child: Text('Cancel Appointment'),
            ),
          ),
        ]),
      ),
    );
  }
}
