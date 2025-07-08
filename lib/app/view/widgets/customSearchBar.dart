import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String) onChanged;

  const CustomSearchBar({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF6B779A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        style: GoogleFonts.inter(color: const Color(0xFF5A67D8)),
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: const Icon(Icons.search, color: Color(0xFF5A67D8)),
          hintText: 'Search for Admin',
          hintStyle: GoogleFonts.inter(color: const Color(0xFF5A67D8)),
        ),
      ),
    );
  }
}
