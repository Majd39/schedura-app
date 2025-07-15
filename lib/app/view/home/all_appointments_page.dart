import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/appointment.dart';
import '../../controller/booking_controller.dart';

class AllAppointmentsPage extends StatelessWidget {
  final controller = Get.put(BookingController());
  final selectedTab = 0.obs;
    Appointment(
      doctorName = 'Dr. Sophia Martinez, Ph.D.',
      specialty = 'Cosmetic Bioengineering',
      dateTime = DateTime.now().add(const Duration(days: 2)),
      status = 'Upcoming',
      rating = 5,
    ),
    Appointment(
      doctorName = 'Dr. Sophia Martinez, Ph.D.',
      specialty = 'Cosmetic Bioengineering',
      dateTime = DateTime.now().subtract(const Duration(days: 1)),
      status = 'Completed',
      rating = 5,
    ),
    Appointment(
      doctorName = 'Dr. Sophia Martinez, Ph.D.',
      specialty = 'Cosmetic Bioengineering',
      dateTime = DateTime.now().subtract(const Duration(days: 3)),
      status = 'Cancelled',
      rating = 0,
    ),
  ];

  AllAppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF6C4AB6)),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'All Appointment',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF6C4AB6),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Color(0xFF6C4AB6)),
            onPressed: () {
              // TODO: Navigate to profile
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Bar
          _buildTabBar(),
          
          // Appointments List
      Expanded(
            child: Obx(() => _buildAppointmentsList()),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    final tabs = ['Complete', 'Upcoming', 'Cancelled'];
    
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isSelected = selectedTab.value == index;
          
          return Expanded(
            child: GestureDetector(
              onTap: () => selectedTab.value = index,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF6C4AB6) : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    tab,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : Colors.grey[700],
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAppointmentsList() {
    final filteredAppointments = controller.appointments.where((appointment) {
      switch (selectedTab.value) {
      case 0:
          return appointment.status == 'Completed';
      case 1:
          return appointment.status == 'Upcoming';
      case 2:
          return appointment.status == 'Cancelled';
        default:
          return false;
      }
    }).toList();

    if (filteredAppointments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No appointments found',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: filteredAppointments.length,
      itemBuilder: (context, index) {
        final appointment = filteredAppointments[index];
        return _buildAppointmentCard(appointment);
      },
    );
  }

  Widget _buildAppointmentCard(Appointment appointment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Doctor Info Row
          Row(
            children: [
              // Doctor Avatar
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF6C4AB6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  Icons.person,
                  size: 30,
                  color: Color(0xFF6C4AB6),
                ),
              ),
              const SizedBox(width: 16),
              
              // Doctor Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.doctorName,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      appointment.specialty,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Rating (for completed appointments)
          if (appointment.status == 'Completed' && appointment.rating > 0)
            Row(
              children: [
                const Icon(
                  Icons.star,
                  size: 16,
                  color: Colors.amber,
                ),
                const SizedBox(width: 4),
                Text(
                  '${appointment.rating}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(
                  Icons.favorite,
                  size: 16,
                  color: Colors.red,
                ),
              ],
            ),
          
          // Appointment Details (for upcoming appointments)
          if (appointment.status == 'Upcoming') ...[
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: Color(0xFF6C4AB6),
                ),
                const SizedBox(width: 8),
                Text(
                  '${_getDayName(appointment.dateTime.weekday)}, ${appointment.dateTime.day} ${_getMonthName(appointment.dateTime.month)}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  size: 16,
                  color: Color(0xFF6C4AB6),
                ),
                const SizedBox(width: 8),
                Text(
                  '${appointment.dateTime.hour}:${appointment.dateTime.minute.toString().padLeft(2, '0')} AM - ${(appointment.dateTime.hour + 1)}:${appointment.dateTime.minute.toString().padLeft(2, '0')} AM',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ],
          
          const SizedBox(height: 16),
          
          // Action Buttons
          _buildActionButtons(appointment),
        ],
      ),
    );
  }

  Widget _buildActionButtons(Appointment appointment) {
    switch (appointment.status) {
      case 'Completed':
        return Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => controller.rebookAppointment(appointment),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'Re-Book',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () => controller.addReview(appointment),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C4AB6),
                    borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    'Add Review',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
        
      case 'Upcoming':
        return Row(
          children: [
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF6C4AB6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    'Details',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => controller.cancelAppointment(appointment),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        );
        
      case 'Cancelled':
        return GestureDetector(
          onTap: () => controller.addReview(appointment),
          child: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF6C4AB6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                'Add Review',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
        
      default:
        return const SizedBox.shrink();
    }
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1: return 'Monday';
      case 2: return 'Tuesday';
      case 3: return 'Wednesday';
      case 4: return 'Thursday';
      case 5: return 'Friday';
      case 6: return 'Saturday';
      case 7: return 'Sunday';
      default: return '';
    }
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1: return 'January';
      case 2: return 'February';
      case 3: return 'March';
      case 4: return 'April';
      case 5: return 'May';
      case 6: return 'June';
      case 7: return 'July';
      case 8: return 'August';
      case 9: return 'September';
      case 10: return 'October';
      case 11: return 'November';
      case 12: return 'December';
      default: return '';
    }
  }
}
