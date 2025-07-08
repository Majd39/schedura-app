import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  double height;
  double width;
  String text;
  void Function()? onTap;
  CustomButton({
    required this.height,
    required this.width,
    required this.text,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Color(0xFF9579FF),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.tajawal(
              color: Colors.white,
              fontSize: 29,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
