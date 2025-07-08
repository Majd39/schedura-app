import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/manager_controller.dart';
import '../widgets/AdminCard.dart';
import '../widgets/customSearchBar.dart';

class HomePage extends StatelessWidget {
  final AdminController controller = Get.put(AdminController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
          Text("ShedUra",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF5A67D8))),
          CustomSearchBar(
            onChanged: (val) => controller.searchText.value = val,
          ),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.filteredAdmins.length,
                itemBuilder: (context, index) {
                  return AdminCard(admin: controller.filteredAdmins[index]);
                },
              );
            }),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: const Color(0xFF7D6FB3),
      //   selectedItemColor: Colors.white,
      //   unselectedItemColor: Colors.white60,
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
      //     BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ''),
      //     BottomNavigationBarItem(icon: Icon(Icons.people), label: ''),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
      //   ],
      // ),
    );
  }
}
