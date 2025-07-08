import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/admin-models.dart';

class AdminCard extends StatelessWidget {
  final AdminModel admin;

  const AdminCard({super.key, required this.admin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF7D6FB3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(admin.imageUrl),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(admin.name,
                    style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                Text(admin.department,
                    style: GoogleFonts.inter(fontSize: 14, color: Colors.white70)),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text('${admin.rating} (${admin.reviews} reviews)',
                        style: GoogleFonts.inter(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.more_horiz, color: Colors.white),
        ],
      ),
    );
  }
}
