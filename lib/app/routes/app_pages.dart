import 'package:get/get.dart';

import '../view/auth/Login_page.dart';
import '../view/auth/otp_page.dart';
import '../view/auth/signup_page.dart';
import '../view/auth/welcome_page.dart';
import '../view/home/MainPage.dart';
import '../view/home/all_appointments_page.dart';
import '../view/home/cancel_appointment_page.dart';
import '../view/home/home_page.dart';
import '../view/home/manger_details_page.dart';
import '../view/home/new_appointment_page.dart';
import '../view/home/review_page.dart';

class AppPages {
  static const initial = Routes.WELCOME;

  static final routes = [
    GetPage(name: Routes.WELCOME, page: () => WelcomePage()),
    GetPage(name: Routes.LOGIN, page: () => LoginPage()),
    GetPage(name: Routes.SIGNUP, page: () => SignupPage()),
    GetPage(name: Routes.OTP, page: () => OTPPage()),
    GetPage(name: Routes.HOME, page: () => HomePage()),
    GetPage(name: Routes.Main, page: ()=>MainPage()),
    GetPage(name: Routes.DOCTOR_DETAILS, page: () => ManagerDetailsPage()),
    GetPage(name: Routes.NEW_APPOINTMENT, page: () => NewAppointmentPage()),
    GetPage(name: Routes.ALL_APPOINTMENTS, page: () => AllAppointmentsPage()),
    GetPage(name: Routes.CANCEL_APPOINTMENT, page: () => CancelAppointmentPage()),
    GetPage(name: Routes.REVIEW, page: () => ReviewPage()),
  ];
}

class Routes {
  static const WELCOME = '/welcome';
  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
  static const OTP = '/otp';
  static const HOME = '/home';
  static const DOCTOR_DETAILS = '/doctor-details';
  static const NEW_APPOINTMENT = '/new-appointment';
  static const ALL_APPOINTMENTS = '/all-appointments';
  static const CANCEL_APPOINTMENT = '/cancel-appointment';
  static const REVIEW = '/review';
  static const Main='/MainPage';
}
