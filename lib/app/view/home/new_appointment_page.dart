import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import '../../controller/booking_controller.dart';

class NewAppointmentPage extends StatelessWidget {
  final controller = Get.put(BookingController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController problemController = TextEditingController();

  NewAppointmentPage({super.key});

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
          'New Appointment',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF6C4AB6),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calendar Section
            _buildCalendarSection(),
            const SizedBox(height: 30),
            
            // Available Time Section
            _buildTimeSection(),
            const SizedBox(height: 30),
            
            // Patient Details Section
            _buildPatientDetailsSection(),
            const SizedBox(height: 40),
            
            // Set Appointment Button
            _buildAppointmentButton(),
          ],
        ),
      ),
    );
  }

    Widget _buildCalendarSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => Text(
          controller.getCurrentMonthName(),
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF6C4AB6),
          ),
        )),
        const SizedBox(height: 20),
        
        // Calendar Carousel
        Obx(() => Container(
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
          child: CalendarCarousel<Event>(
            onDayPressed: (DateTime date, List<Event> events) {
              controller.selectDate(date);
            },
            weekendTextStyle: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.red,
            ),
            thisMonthDayBorderColor: Colors.grey[300]!,
            weekFormat: false,
            firstDayOfWeek: DateTime.monday,
            isScrollable: true,
            height: 420.0,
            width: MediaQuery.of(context).size.width,
            customGridViewPhysics: const NeverScrollableScrollPhysics(),
            markedDateCustomShapeBorder: CircleBorder(),
            markedDateCustomTextStyle: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.white,
            ),
            showHeader: false,
            todayButtonColor: const Color(0xFF6C4AB6),
            selectedDateTime: controller.selectedDate.value,
            targetDateTime: DateTime.now(),
            prevDaysTextStyle: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey[400],
            ),
            nextDaysTextStyle: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey[400],
            ),
            thisMonthTextStyle: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            weekDayTextStyle: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
            daysHaveCircularBorder: true,
            todayTextStyle: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            selectedDayTextStyle: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            selectedDayButtonColor: const Color(0xFF6C4AB6),
            todayBorderColor: const Color(0xFF6C4AB6),
            todayIconColor: const Color(0xFF6C4AB6),
            nextMonthDayBorderColor: Colors.grey[300]!,
            nextMonthDayTextStyle: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey[400],
            ),
            prevMonthDayBorderColor: Colors.grey[300]!,
            prevMonthDayTextStyle: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey[400],
            ),
            enableSwipeGesture: true,
            onCalendarChanged: (DateTime date) {
              // Handle month change if needed
            },
            onDayLongPressed: (DateTime date) {
              // Handle long press if needed
            },
          ),
        )),
      ],
    );
  }

  Widget _buildTimeSection() {
    final timeSlots = controller.availableTimeSlots;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Available Time',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF6C4AB6),
          ),
        ),
        const SizedBox(height: 15),
        
        Obx(() {
          if (controller.isLoadingSchedule.value) {
            return Center(
              child: Column(
                children: [
                  const CircularProgressIndicator(
                    color: Color(0xFF6C4AB6),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Loading available times...',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }
          
          if (controller.availableTimeSlots.isEmpty) {
            return Center(
              child: Text(
                'No available times for selected date',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            );
          }
          
          return Wrap(
            spacing: 12,
            runSpacing: 12,
            children: controller.availableTimeSlots.map((time) {
              final isSelected = controller.selectedTimes.contains(time);
              return GestureDetector(
                onTap: () => controller.toggleTime(time),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? const Color(0xFF6C4AB6) 
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                    border: isSelected 
                        ? null 
                        : Border.all(color: Colors.grey[300]!, width: 1),
                  ),
                  child: Text(
                    time,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : Colors.grey[700],
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        }),
      ],
    );
  }

  Widget _buildPatientDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Patient Details',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 20),
        
        // Full Name Field
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F2F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: nameController,
            style: GoogleFonts.poppins(fontSize: 16),
            onChanged: (value) => controller.updatePatientName(value),
            decoration: InputDecoration(
              hintText: 'Tolu Arowoselu',
              hintStyle: GoogleFonts.poppins(
                fontSize: 16,
                color: const Color(0xFF6C4AB6).withOpacity(0.6),
              ),
              border: InputBorder.none,
              labelText: 'Full name',
              labelStyle: GoogleFonts.poppins(
                color: const Color(0xFF6C4AB6),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 20),
        
        // Problem Description Field
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F2F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: problemController,
            maxLines: 4,
            style: GoogleFonts.poppins(fontSize: 16),
            onChanged: (value) => controller.updatePatientProblem(value),
            decoration: InputDecoration(
              hintText: 'write your problem',
              hintStyle: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[500],
              ),
              border: InputBorder.none,
              suffixIcon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey[600],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppointmentButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6C4AB6), Color(0xFF8B6CD9)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C4AB6).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: controller.isLoading.value ? null : () async {
            await controller.bookAppointment();
          },
          child: Center(
            child: Obx(() => Text(
              controller.isLoading.value ? 'Booking...' : 'Set Appointment',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            )),
          ),
        ),
      ),
    );
  }
}
