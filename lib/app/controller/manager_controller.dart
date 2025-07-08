import 'package:get/get.dart';

import '../models/admin-models.dart';

class AdminController extends GetxController {
  var searchText = ''.obs;

  final List<AdminModel> _allAdmins = [
    AdminModel(
      name: 'Prof. Alex Wellson',
      department: 'Quantum Physics',
      imageUrl: 'https://i.pravatar.cc/100',
      rating: 4.5,
      reviews: 135,
    ),
    // Add more AdminModel instances if needed
  ];

  RxList<AdminModel> filteredAdmins = <AdminModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredAdmins.value = _allAdmins;
    ever(searchText, (_) => _filterAdmins());
  }

  void _filterAdmins() {
    filteredAdmins.value = _allAdmins.where((admin) {
      return admin.name.toLowerCase().contains(searchText.value.toLowerCase());
    }).toList();
  }
}
