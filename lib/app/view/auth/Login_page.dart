import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/auth_controller.dart';
import '../../routes/app_pages.dart';
import '../widgets/authTextField.dart';
import '../widgets/customButton.dart';

class LoginPage extends StatelessWidget {
  final controller = Get.put(AuthController());
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 70.0),
          child: const Text(
            "Log In",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 30.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  textAlign: TextAlign.start,
                  "Welcome",
                  style: GoogleFonts.tajawal(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Welcome to Schedura – your all-in-one solution to book, manage, and organize meetings with ease, clarity, and speed.",
                    style: GoogleFonts.leagueSpartan(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  "Email",
                  style: GoogleFonts.tajawal(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: AuthTextField(
                    hintText: 'example@example.com',
                    controller: emailCtrl,
                    onChanged: (value) => controller.email.value = value,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Password",
                  style: GoogleFonts.tajawal(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10,),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: AuthTextField(
                      hintText: 'Password',
                      controller: passCtrl,
                      obscure: controller.obscurePassword.value,
                      toggleObscure: controller.togglePassword,
                      onChanged: (value) => controller.password.value = value,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Implement forgot password functionality
                      Get.snackbar(
                        'Info',
                        'Forgot password feature coming soon',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: const Color(0xFF6C4AB6),
                        colorText: Colors.white,
                      );
                    },
                    child: const Text(
                      "Forgot Password",
                      style: TextStyle(color: Color(0xFF6D95A4)),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Obx(() => CustomButton(
                    width: 250,
                    height: 65,
                    text: controller.isLoading.value ? "Logging In..." : "Log In",
                    onTap: controller.isLoading.value ? null : () async {
                      await controller.loginUser();
                    },
                  )),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: const Text("or sign up with"),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SignInButton.mini(
                      buttonType: ButtonType.facebook,
                      onPressed: () {
                        // TODO: Implement Facebook login
                        Get.snackbar(
                          'Info',
                          'Facebook login coming soon',
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: const Color(0xFF6C4AB6),
                          colorText: Colors.white,
                        );
                      },
                    ),
                    const SizedBox(width: 20),
                    SignInButton.mini(
                      buttonType: ButtonType.google,
                      onPressed: () {
                        // TODO: Implement Google login
                        Get.snackbar(
                          'Info',
                          'Google login coming soon',
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: const Color(0xFF6C4AB6),
                          colorText: Colors.white,
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don`t have an account?"),
                    TextButton(
                      onPressed: () {
                        controller.signup();
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Color(0xFF6D95A4)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
