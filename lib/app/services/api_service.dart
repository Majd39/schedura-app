import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'storage_service.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000/api';
  
  // Endpoints
  static const String register = '/register';
  static const String verifyOtp = '/verifyCode'; // Will be appended with user_id
  static const String login = '/login';
  static const String logout = '/logout';
  static const String managerSchedule = '/managerschedule';
  
  // Headers
  static Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Headers with auth token
  static Future<Map<String, String>> get authHeaders async {
    final token = await StorageService.getAuthToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // Get manager schedule
  static Future<Map<String, dynamic>> getManagerSchedule() async {
    try {
      final headers = await authHeaders;
      var request = http.MultipartRequest('GET', Uri.parse('$baseUrl$managerSchedule'));
      request.headers.addAll(headers);
      
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': json.decode(responseBody),
          'message': 'Schedule fetched successfully'
        };
      } else {
        return {
          'success': false,
          'error': response.reasonPhrase,
          'data': json.decode(responseBody),
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Network error: $e',
      };
    }
  }
  
  // Registration
  static Future<Map<String, dynamic>> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String phoneNumber,
    required String dateOfBirth,
    required String jobId,
    required String managerId,
    required String address,
    required String role,
    File? image,
  }) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl$register'));
      
      // Add text fields
      request.fields.addAll({
        'first_name': firstName,
        'last_name': lastName,
        'role': role,
        'email': email,
        'password': password,
        'phone_number': phoneNumber,
        'date_of_birth': dateOfBirth,
        'job_id': jobId,
        'password_confirmation': passwordConfirmation,
        'manager_id': managerId,
        'address': address,
      });
      
      // Add image file if provided
      if (image != null) {
        request.files.add(await http.MultipartFile.fromPath('image', image.path));
      }
      
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'data': json.decode(responseBody),
          'message': 'Registration successful'
        };
      } else {
        return {
          'success': false,
          'error': response.reasonPhrase,
          'data': json.decode(responseBody),
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Network error: $e',
      };
    }
  }
  
  // Verify OTP
  static Future<Map<String, dynamic>> verifyOtpCode({
    required String userId,
    required String code,
  }) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl$verifyOtp/13'));
      request.fields.addAll({
        'code': code,
      });
      
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': json.decode(responseBody),
          'message': 'OTP verified successfully'
        };
      } else {
        return {
          'success': false,
          'error': response.reasonPhrase,
          'data': json.decode(responseBody),
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Network error: $e',
      };
    }
  }
  
  // Login
  static Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl$login'));
      request.fields.addAll({
        'email': email,
        'password': password,
      });
      
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': json.decode(responseBody),
          'message': 'Login successful'
        };
      } else {
        return {
          'success': false,
          'error': response.reasonPhrase,
          'data': json.decode(responseBody),
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Network error: $e',
      };
    }
  }
} 