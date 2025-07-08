import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shedura/app/view/widgets/authTextField.dart';
import '../../controller/auth_controller.dart';
import '../../routes/app_pages.dart';
import '../widgets/customButton.dart';

class OTPPage extends StatelessWidget {
  final controller = Get.put(AuthController());
  // Create 6 separate TextEditingControllers
  final List<TextEditingController> otpControllers = List.generate(
    6,
        (index) => TextEditingController(),
  );
  OTPPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.05),
                  Image.asset(
                    "assets/images/rafiki.png",
                    width: size.width * 0.7,
                  ),
                  SizedBox(height: size.height * 0.05),
                  Text(
                    "OTP",
                    style: GoogleFonts.montserrat(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Enter the 6-digit code we sent to john@doe.com",
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    children: List.generate(
                      6,
                          (index) => AuthTextField(
                        controller: otpControllers[index],
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Resend Code"),
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    width: 250,
                    height: 65,
                    text: "Confirm",
                    onTap: () {
                      // You should validate OTP here
                     // controller.verifyOTP;
                      Get.toNamed(Routes.Main);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
