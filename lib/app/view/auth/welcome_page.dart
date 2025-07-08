import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routes/app_pages.dart';
import '../widgets/customButton.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: height, // Fill height so buttons stay centered
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.1),
                Image.asset(
                  "assets/appIcon/Logo.png",
                  scale: 5,
                ),
                SizedBox(height: 15),
                Text(
                  "Schedura",
                  style: GoogleFonts.tajawal(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: height * 0.1),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Stay ahead. Stay organized. With Schedura.",
                    style: GoogleFonts.leagueSpartan(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 50),
                CustomButton(
                  width: 250,
                  height: 65,
                  text: "Log In",
                  onTap: () {
                    Get.toNamed(Routes.LOGIN);
                  },
                ),
                SizedBox(height: 20),
                CustomButton(
                  width: 250,
                  height: 65,
                  text: "Sign Up",
                  onTap: () {
                    Get.toNamed(Routes.SIGNUP);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
