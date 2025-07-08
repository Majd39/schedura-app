import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/auth_controller.dart';
import '../../routes/app_pages.dart';
import '../widgets/authTextField.dart';
import '../widgets/customButton.dart';
import 'package:sign_button/sign_button.dart';
class SignupPage extends StatelessWidget {
  final controller = Get.put(AuthController());
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confirmPassCtrl = TextEditingController();

  final RxString selectedGender = ''.obs;

  SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "New Account",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel("First Name"),
                AuthTextField(hintText: 'Majd', controller: firstNameCtrl),

                _buildLabel("Last Name"),
                AuthTextField(hintText: 'Almansour', controller: lastNameCtrl),

                _buildLabel("Email"),
                AuthTextField(hintText: 'example@example.com', controller: emailCtrl),

                _buildLabel("Password"),
                Obx(() => AuthTextField(
                  hintText: '************',
                  controller: passCtrl,
                  obscure: controller.obscurePassword.value,
                  toggleObscure: controller.togglePassword,
                )),

                _buildLabel("Confirm Password"),
                Obx(() => AuthTextField(
                  hintText: '************',
                  controller: confirmPassCtrl,
                  obscure: controller.obscurePassword.value,
                  toggleObscure: controller.togglePassword,
                )),

                _buildLabel("Gender"),
                Obx(
                      () => DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    hint: const Text("Select your gender"),
                    value: selectedGender.value.isEmpty ? null : selectedGender.value,
                    items: const [
                      DropdownMenuItem(value: 'Male', child: Text('Male')),
                      DropdownMenuItem(value: 'Female', child: Text('Female')),
                      DropdownMenuItem(value: 'Prefer not to say', child: Text('Prefer not to say')),
                    ],
                    onChanged: (value) {
                      selectedGender.value = value!;
                    },
                  ),
                ),

                const SizedBox(height: 16),
                Text.rich(
                  TextSpan(
                    text: 'By confirming, you agree to ',
                    style: TextStyle(color: Colors.grey[700], fontSize: 12),
                    children: const [
                      TextSpan(
                        text: 'Terms of Use ',
                        style: TextStyle(color: Colors.blue),
                      ),
                      TextSpan(text: 'and '),
                      TextSpan(
                        text: 'Privacy Policy.',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                Center(
                  child: CustomButton(
                    width: size.width * 0.7,
                    height: 60,
                    text: "Sign Up",
                    onTap: () {
controller.signup();
                    },
                  ),
                ),

                const SizedBox(height: 20),
                Center(child: Text("or sign up with")),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SignInButton.mini(
                      buttonType: ButtonType.facebook,
                      onPressed: () {},
                    ),
                    const SizedBox(width: 20),
                    SignInButton.mini(
                      buttonType: ButtonType.google,
                      onPressed: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.LOGIN);
                      },
                      child: const Text(
                        "Log In",
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

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        text,
        style: GoogleFonts.tajawal(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
