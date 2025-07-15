import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
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
  final phoneCtrl = TextEditingController();
  final dateOfBirthCtrl = TextEditingController();
  final jobIdCtrl = TextEditingController();
  final managerIdCtrl = TextEditingController();
  final addressCtrl = TextEditingController();

  final RxString selectedGender = ''.obs;
  final ImagePicker _picker = ImagePicker();

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
                // Profile Image Selection
                _buildLabel("Profile Image"),
                Center(
                  child: Obx(() => GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: const Color(0xFF6C4AB6), width: 2),
                      ),
                      child: controller.selectedImage.value != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.file(
                                controller.selectedImage.value!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Icon(
                              Icons.add_a_photo,
                              size: 40,
                              color: Color(0xFF6C4AB6),
                            ),
                    ),
                  )),
                ),

                _buildLabel("First Name"),
                AuthTextField(
                  hintText: 'Majd',
                  controller: firstNameCtrl,
                  onChanged: (value) => controller.firstName.value = value,
                ),

                _buildLabel("Last Name"),
                AuthTextField(
                  hintText: 'Almansour',
                  controller: lastNameCtrl,
                  onChanged: (value) => controller.lastName.value = value,
                ),

                _buildLabel("Email"),
                AuthTextField(
                  hintText: 'example@example.com',
                  controller: emailCtrl,
                  onChanged: (value) => controller.email.value = value,
                ),

                _buildLabel("Phone Number"),
                AuthTextField(
                  hintText: '+963923577159',
                  controller: phoneCtrl,
                  onChanged: (value) => controller.phoneNumber.value = value,
                ),

                _buildLabel("Date of Birth"),
                AuthTextField(
                  hintText: '1990-01-01',
                  controller: dateOfBirthCtrl,
                  onChanged: (value) => controller.dateOfBirth.value = value,
                ),

                _buildLabel("Job ID"),
                AuthTextField(
                  hintText: '2',
                  controller: jobIdCtrl,
                  onChanged: (value) => controller.jobId.value = value,
                ),

                _buildLabel("Manager ID"),
                AuthTextField(
                  hintText: '1',
                  controller: managerIdCtrl,
                  onChanged: (value) => controller.managerId.value = value,
                ),

                _buildLabel("Address"),
                AuthTextField(
                  hintText: 'Masyaf',
                  controller: addressCtrl,
                  onChanged: (value) => controller.address.value = value,
                ),

                _buildLabel("Password"),
                Obx(() => AuthTextField(
                  hintText: '************',
                  controller: passCtrl,
                  obscure: controller.obscurePassword.value,
                  toggleObscure: controller.togglePassword,
                  onChanged: (value) => controller.password.value = value,
                )),

                _buildLabel("Confirm Password"),
                Obx(() => AuthTextField(
                  hintText: '************',
                  controller: confirmPassCtrl,
                  obscure: controller.obscureConfirmPassword.value,
                  toggleObscure: controller.toggleConfirmPassword,
                  onChanged: (value) => controller.confirmPassword.value = value,
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
                  child: Obx(() => CustomButton(
                    width: size.width * 0.7,
                    height: 60,
                    text: controller.isLoading.value ? "Signing Up..." : "Sign Up",
                    onTap: controller.isLoading.value ? null : () async {
                      await controller.register();
                    },
                  )),
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

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        controller.selectedImage.value = File(image.path);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
