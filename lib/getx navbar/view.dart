// import 'package:flutter/material.dart';
// import 'package:for_test/getx%20navbar/controller.dart';
// import 'package:get/get.dart';

// class ProfessionalNavigationBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetX<NavigationController>(
//       builder: (controller) {
//         return Scaffold(
//           body: controller.screens[controller.selectedIndex.value],
//           bottomNavigationBar: _buildCustomNavigationBar(controller),
//           floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         );
//       },
//     );
//   }
//   Widget _buildNavItem(NavigationController controller, IconData icon, IconData activeIcon, int index, String label) {
//     return IconButton(
//       icon: Icon(
//         controller.selectedIndex.value == index ? activeIcon : icon,
//         color: controller.selectedIndex.value == index ? Colors.blue : Colors.grey,
//         size: 28,
//       ),
//       onPressed: () => controller.changeIndex(index),
//     );
//   }
// }

// // Example Screens
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text('Home Screen', style: TextStyle(fontSize: 24)));
//   }
// }

// class SearchScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text('Search Screen', style: TextStyle(fontSize: 24)));
//   }
// }

// class AddScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text('Add Screen', style: TextStyle(fontSize: 24)));
//   }
// }

// class NotificationsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text('Notifications Screen', style: TextStyle(fontSize: 24)));
//   }
// }

// class ProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text('Profile Screen', style: TextStyle(fontSize: 24)));
//   }
// }
