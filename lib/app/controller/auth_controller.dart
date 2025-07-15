var headers = {
  'email': 'massaraghad@gmail.com',
  'password': '123456'
};
var request = http.Request('POST', Uri.parse('http://192.168.1.6:8000/api/resendCode/13'));

request.headers.addAll(headers);

http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
  print(await response.stream.bytesToString());
}
else {
  print(response.reasonPhrase);
}import 'package:get/get.dart';
import 'package:shedura/app/routes/app_pages.dart';
import 'package:shedura/app/services/api_service.dart';
import 'package:shedura/app/services/storage_service.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  // Login fields
  var email = ''.obs;
  var password = ''.obs;
  var otpCode = ''.obs;

  // Registration fields
  var firstName = ''.obs;
  var lastName = ''.obs;
  var phoneNumber = ''.obs;
  var dateOfBirth = ''.obs;
  var jobId = ''.obs;
  var managerId = ''.obs;
  var address = ''.obs;
  var confirmPassword = ''.obs;
  var selectedImage = Rx<File?>(null);

  // UI states
  var obscurePassword = true.obs;
  var obscureConfirmPassword = true.obs;
  var isLoading = false.obs;
  var registrationEmail = ''.obs; // Store email for OTP verification
  var userId = ''.obs; // Store user ID from registration response

  void login() {
    Get.toNamed(Routes.OTP);
  }

  void signup() {
    Get.toNamed(Routes.LOGIN);
  }

  // Registration method
  Future<void> register() async {
    if (!_validateRegistrationFields()) {
      return;
    }

    isLoading.value = true;
    
    try {
      final result = await ApiService.registerUser(
        firstName: firstName.value,
        lastName: lastName.value,
        email: email.value,
        password: password.value,
        passwordConfirmation: confirmPassword.value,
        phoneNumber: phoneNumber.value,
        dateOfBirth: dateOfBirth.value,
        jobId: jobId.value,
        managerId: managerId.value,
        address: address.value,
        role: 'user',
        image: selectedImage.value,
      );

      if (result['success']) {
        registrationEmail.value = email.value; // Store email for OTP
        
        // Extract user ID from response data
        if (result['data'] != null && result['data']['user'] != null) {
          userId.value = result['data']['user']['id'].toString();
        } else if (result['data'] != null && result['data']['id'] != null) {
          userId.value = result['data']['id'].toString();
        }
        
        // Debug: Print the response data to see the structure
        print('Registration response: ${result['data']}');
        print('User ID extracted: ${userId.value}');
        
        Get.snackbar(
          'Success',
          'Registration successful! Please verify your email.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFF6C4AB6),
          colorText: Colors.white,
        );
        Get.toNamed(Routes.OTP);
      } else {
        Get.snackbar(
          'Error',
          result['error'] ?? 'Registration failed',
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
      isLoading.value = false;
    }
  }

  // OTP verification method
  Future<void> verifyOTP() async {
    if (otpCode.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter OTP code',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      if (userId.value.isEmpty) {
        Get.snackbar(
          'Error',
          'User ID not found. Please try registering again.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
      
      final result = await ApiService.verifyOtpCode(
        userId: userId.value,
        code: otpCode.value,
      );

      if (result['success']) {
        Get.snackbar(
          'Success',
          'Email verified successfully!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFF6C4AB6),
          colorText: Colors.white,
        );
        Get.offAllNamed(Routes.HOME); // Navigate to home and clear stack
      } else {
        Get.snackbar(
          'Error',
          result['error'] ?? 'OTP verification failed',
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
      isLoading.value = false;
    }
  }

  // Login method
  Future<void> loginUser() async {
    if (email.value.isEmpty || password.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all fields',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      final result = await ApiService.loginUser(
        email: email.value,
        password: password.value,
      );

      if (result['success']) {
        // Extract and save auth data
        final data = result['data'];
        if (data != null) {
          String? token = data['token'] ?? data['auth_token'];
          String? userId = data['user_id']?.toString() ?? data['user']['id']?.toString();
          
          if (token != null && userId != null) {
            await StorageService.saveAuthData(
              token: token,
              userId: userId,
              email: email.value,
            );
            
            Get.snackbar(
              'Success',
              'Login successful!',
              snackPosition: SnackPosition.TOP,
              backgroundColor: const Color(0xFF6C4AB6),
              colorText: Colors.white,
            );
            Get.offAllNamed(Routes.HOME);
          } else {
            Get.snackbar(
              'Error',
              'Invalid response from server',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        }
      } else {
        // Handle specific error cases
        final data = result['data'];
        if (data != null && data['message'] == 'You must verify your email.') {
          // User needs to verify email - navigate to OTP
          userId.value = data['user_id']?.toString() ?? '';
          registrationEmail.value = email.value;
          
          Get.snackbar(
            'Verification Required',
            'Please verify your email first.',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.orange,
            colorText: Colors.white,
          );
          Get.toNamed(Routes.OTP);
        } else {
          Get.snackbar(
            'Error',
            result['error'] ?? 'Login failed',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
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
      isLoading.value = false;
    }
  }

  // Validation method
  bool _validateRegistrationFields() {
    if (firstName.value.isEmpty ||
        lastName.value.isEmpty ||
        email.value.isEmpty ||
        password.value.isEmpty ||
        confirmPassword.value.isEmpty ||
        phoneNumber.value.isEmpty ||
        dateOfBirth.value.isEmpty ||
        jobId.value.isEmpty ||
        managerId.value.isEmpty ||
        address.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all required fields',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (password.value != confirmPassword.value) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (password.value.length < 6) {
      Get.snackbar(
        'Error',
        'Password must be at least 6 characters',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    return true;
  }

  void togglePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleConfirmPassword() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  // Logout method
  Future<void> logout() async {
    await StorageService.clearAuthData();
    clearFields();
    Get.offAllNamed(Routes.WELCOME);
  }

  // Clear all fields
  void clearFields() {
    email.value = '';
    password.value = '';
    otpCode.value = '';
    firstName.value = '';
    lastName.value = '';
    phoneNumber.value = '';
    dateOfBirth.value = '';
    jobId.value = '';
    managerId.value = '';
    address.value = '';
    confirmPassword.value = '';
    selectedImage.value = null;
    registrationEmail.value = '';
    userId.value = '';
  }
}
