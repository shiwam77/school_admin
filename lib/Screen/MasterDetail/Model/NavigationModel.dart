import 'package:flutter/material.dart';

class NavigationModel {
  String title;
  IconData icon;

  NavigationModel({this.title, this.icon});
}

List<NavigationModel> navigationItems = [
  NavigationModel(title: "Home", icon: Icons.home),
  NavigationModel(title: "Class Setup", icon: Icons.developer_board),
  NavigationModel(title: "Add Student", icon: Icons.people_outline),
  NavigationModel(title: "Create Homework", icon: Icons.library_books),
  NavigationModel(title: "Add Attendance", icon: Icons.present_to_all),
  NavigationModel(title: "Tutor", icon: Icons.picture_as_pdf),
  NavigationModel(title: "Notifications", icon: Icons.notifications),
  NavigationModel(title: "Settings", icon: Icons.settings),
];
