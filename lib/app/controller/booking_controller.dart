import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../models/appointment.dart';

class BookingController extends GetxController {
  // Date and time selection
  var selectedDate = DateTime.now().obs;
  var selectedTimes = <String>[].obs;
  
  // Form fields
  var patientName = ''.obs;
  var patientProblem = ''.obs;
  
  // UI states
  var isLoading = false.obs;
  var isFormValid = false.obs;
  
  // Available time slots (will be populated from API)
  var availableTimeSlots = <String>[].obs;
  var isLoadingSchedule = false.obs;
  
  // Sample appointments for demonstration
  final appointments = <Appointment>[
    Appointment(
      doctorName: 'Dr. Sophia Martinez, Ph.D.',
      specialty: 'Cosmetic Bioengineering',
      dateTime: DateTime.now().add(const Duration(days: 2)),
      status: 'Upcoming',
      rating: 5,
    ),
    Appointment(
      doctorName: 'Dr. Sophia Martinez, Ph.D.',
      specialty: 'Cosmetic Bioengineering',
      dateTime: DateTime.now().subtract(const Duration(days: 1)),
      status: 'Completed',
      rating: 5,
    ),
    Appointment(
      doctorName: 'Dr. Sophia Martinez, Ph.D.',
      specialty: 'Cosmetic Bioengineering',
      dateTime: DateTime.now().subtract(const Duration(days: 3)),
      status: 'Cancelled',
      rating: 0,
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    // Listen to form changes to update validation
    ever(patientName, (_) => _validateForm());
    ever(patientProblem, (_) => _validateForm());
    ever(selectedTimes, (_) => _validateForm());
    ever(selectedDate, (_) => _fetchScheduleForDate());
  }

  // Select date
  void selectDate(DateTime date) {
    selectedDate.value = date;
    print('Selected date: ${date.toString()}');
  }

  // Fetch schedule for selected date
  Future<void> _fetchScheduleForDate() async {
    isLoadingSchedule.value = true;
    
    try {
      final result = await ApiService.getManagerSchedule();
      
      if (result['success']) {
        // Parse the schedule data and filter for selected date
        final scheduleData = result['data'];
        if (scheduleData != null) {
          // TODO: Parse schedule data based on your API response structure
          // For now, using sample data
          _parseScheduleData(scheduleData);
        }
      } else {
        Get.snackbar(
          'Error',
          result['error'] ?? 'Failed to fetch schedule',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Network error: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoadingSchedule.value = false;
    }
  }

  // Parse schedule data (adjust based on your API response)
  void _parseScheduleData(Map<String, dynamic> data) {
    // Clear existing time slots
    availableTimeSlots.clear();
    
    // TODO: Parse the actual API response structure
    // For now, using sample time slots based on selected date
    final dayOfWeek = selectedDate.value.weekday;
    
    // Sample logic - adjust based on your API response
    if (dayOfWeek >= 1 && dayOfWeek <= 5) { // Monday to Friday
      availableTimeSlots.addAll([
        '09:00 AM', '09:30 AM', '10:00 AM', '10:30 AM',
        '12:00 PM', '12:30 PM', '01:30 PM', '02:00 PM',
        '03:00 PM', '04:30 PM', '05:00 PM', '05:30 PM'
      ]);
    } else { // Weekend
      availableTimeSlots.addAll([
        '10:00 AM', '11:00 AM', '12:00 PM',
        '02:00 PM', '03:00 PM', '04:00 PM'
      ]);
    }
  }

  // Toggle time selection
  void toggleTime(String time) {
    if (selectedTimes.contains(time)) {
      selectedTimes.remove(time);
    } else {
      selectedTimes.add(time);
    }
  }

  // Update patient name
  void updatePatientName(String name) {
    patientName.value = name;
  }

  // Update patient problem
  void updatePatientProblem(String problem) {
    patientProblem.value = problem;
  }

  // Validate form
  void _validateForm() {
    isFormValid.value = patientName.value.isNotEmpty && 
                       patientProblem.value.isNotEmpty && 
                       selectedTimes.isNotEmpty;
  }

  // Book appointment
  Future<void> bookAppointment() async {
    if (!isFormValid.value) {
      Get.snackbar(
        'Error',
        'Please fill all required fields and select at least one time slot',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      // TODO: Implement API call to book appointment
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      
      // Create new appointment
      final newAppointment = Appointment(
        doctorName: 'Dr. Sophia Martinez, Ph.D.',
        specialty: 'Cosmetic Bioengineering',
        dateTime: selectedDate.value,
        status: 'Upcoming',
        rating: 0,
      );
      
      appointments.add(newAppointment);
      
      Get.snackbar(
        'Success',
        'Appointment booked successfully!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF6C4AB6),
        colorText: Colors.white,
      );
      
      // Clear form
      clearForm();
      
      // Navigate to appointments list
      Get.toNamed('/all-appointments');
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to book appointment: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Clear form
  void clearForm() {
    selectedTimes.clear();
    patientName.value = '';
    patientProblem.value = '';
  }

  // Get appointments by status
  List<Appointment> getAppointmentsByStatus(String status) {
    return appointments.where((appointment) => appointment.status == status).toList();
  }

  // Cancel appointment
  void cancelAppointment(Appointment appointment) {
    final index = appointments.indexWhere((a) => a == appointment);
    if (index != -1) {
      appointments[index] = Appointment(
        doctorName: appointment.doctorName,
        specialty: appointment.specialty,
        dateTime: appointment.dateTime,
        status: 'Cancelled',
        rating: appointment.rating,
      );
      
      Get.snackbar(
        'Success',
        'Appointment cancelled successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF6C4AB6),
        colorText: Colors.white,
      );
    }
  }

  // Add review
  void addReview(Appointment appointment) {
    // TODO: Navigate to review page
    Get.toNamed('/review');
  }

  // Re-book appointment
  void rebookAppointment(Appointment appointment) {
    // TODO: Navigate to booking page with pre-filled data
    Get.toNamed('/new-appointment');
  }

  // Get current month name
  String getCurrentMonthName() {
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[selectedDate.value.month - 1];
  }
} 