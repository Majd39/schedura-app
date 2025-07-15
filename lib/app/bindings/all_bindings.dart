import 'package:get/get.dart';
import '../controller/auth_controller.dart';
import '../controller/manager_controller.dart';
import '../controller/MainPageController.dart';
import '../controller/booking_controller.dart';

class AllBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => AdminController());
    Get.lazyPut(() => MainController());
    Get.lazyPut(() => BookingController());
  }
}
