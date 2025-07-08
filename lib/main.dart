import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/bindings/all_bindings.dart';

void main() {
  runApp(ShedUraApp());
}

class ShedUraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ShedUra',
      debugShowCheckedModeBanner: false,
      initialBinding: AllBindings(),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0x016C4AB6),

        ),
        primaryColor: Color(0xFF6C4AB6),
        scaffoldBackgroundColor: Color(0xFFC4B5FD),
        fontFamily: 'Poppins',
        textTheme: TextTheme(
          titleLarge: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(color: Colors.black87),
          labelLarge: TextStyle(color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF6C4AB6),
            shape: StadiumBorder(),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Color(0xFF6C4AB6), shape: StadiumBorder(),
            side: BorderSide(color: Color(0xFF6C4AB6)),
          ),
        ),
      ),
    );
  }
}
