import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String hintText;
  final bool obscure;
  final TextEditingController controller;
  final VoidCallback? toggleObscure;
  final double width;
  final double height;
  final void Function(String)? onChanged;
  const AuthTextField({
    super.key,
    this.hintText = "",
    required this.controller,
    this.obscure = false,
    this.toggleObscure,
    this.width = 399,
    this.height = 55,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0x225A67D8),
        borderRadius: BorderRadius.circular(13),
      ),
      child: TextFormField(
        onChanged: onChanged,

        controller: controller,
        obscureText: obscure,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0x336D95A4)),
          border: InputBorder.none,
          suffixIcon:
              toggleObscure != null
                  ? IconButton(
                    icon: Icon(
                      obscure ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white,
                    ),
                    onPressed: toggleObscure,
                  )
                  : null,
        ),
      ),
    );
  }
}
