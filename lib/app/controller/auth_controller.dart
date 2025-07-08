import 'package:get/get.dart';
import 'package:shedura/app/routes/app_pages.dart';

class AuthController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var otpCode = ''.obs;

  var obscurePassword = true.obs;
  var obscureConfirmPassword = true.obs;

  void login() {
    Get.toNamed(Routes.OTP); }

  void signup() {
    Get.toNamed(Routes.LOGIN); }

  void verifyOTP() {
    Get.toNamed(Routes.HOME);
  }

  void togglePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleConfirmPassword() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }
}
