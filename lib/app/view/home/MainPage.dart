import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/MainPageController.dart';
import 'home_page.dart';
// Add other screens here when ready

class MainPage extends StatelessWidget {
  final MainController controller = Get.put(MainController());

  MainPage({super.key});

  final List<Widget> pages = [
    HomePage(), // Home Page
    Center(child: Text("Calendar")),
    Center(child: Text("Admins")),
    Center(child: Text("Profile")),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: pages[controller.currentIndex.value],
      bottomNavigationBar:
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // يمنح مساحة حول الشريط
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100), // الحواف الدائرية
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color(0xFF7D6FB3),
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white60,
              currentIndex: controller.currentIndex.value,
              onTap: controller.changeTab,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: [
                BottomNavigationBarItem(
                  icon: _navIcon(Icons.home, controller.currentIndex.value == 0),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: _navIcon(Icons.calendar_today, controller.currentIndex.value == 1),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: _navIcon(Icons.people, controller.currentIndex.value == 2),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: _navIcon(Icons.person, controller.currentIndex.value == 3),
                  label: '',
                ),
              ],
            ),
          ),
        ),
      ),


    ));
  }
}
Widget _navIcon(IconData icon, bool isSelected) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Icon(icon, size: 24),
  );
}
