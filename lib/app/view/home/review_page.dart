import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewPage extends StatelessWidget {
  final comment = ''.obs;

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(title: Text('Review')),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CircleAvatar(radius: 40, backgroundImage: AssetImage('assets/icons/calendar_icon.png')),
          SizedBox(height: 12),
          Text('Dr. Olivia Turner, M.D.', style: ctx.textTheme.titleLarge),
          SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(label: Text('Enter your comment')),
            maxLines: 4,
            onChanged: (v) => comment.value = v,
          ),
          Spacer(),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () => Get.back(),
              child: Text('Add Review'),
            ),
          ),
        ]),
      ),
    );
  }
}
