import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/screens/cancelled_task_screen.dart';
import 'package:task_manager/ui/screens/completed_task_screen.dart';
import 'package:task_manager/ui/screens/in_progress_task_screen.dart';
import 'package:task_manager/ui/screens/new_task_screen.dart';
import 'package:task_manager/ui/state_managers/bottom_nav_controller.dart';

class BottomNavBaseScreen extends StatelessWidget {
  BottomNavBaseScreen({super.key});

  final RxInt _selectedScreenIndex = 0.obs;
  final List<Widget> _screens = const [
    NewTaskScreen(),
    InProgressTaskScreen(),
    CancelledTaskScreen(),
    CompletedTaskScreen()
  ];

  @override
  Widget build(BuildContext context) {
    print(_selectedScreenIndex.value);
    return Scaffold(
      body: Obx(() => _screens[_selectedScreenIndex.value]),
      bottomNavigationBar:
          GetBuilder<BottomNavController>(builder: (bottomNavController) {
        return BottomNavigationBar(
          currentIndex: _selectedScreenIndex.value,
          unselectedItemColor: Colors.grey,
          unselectedLabelStyle: const TextStyle(color: Colors.grey),
          showUnselectedLabels: true,
          selectedItemColor: Colors.green,
          onTap: (int index) {
            _selectedScreenIndex.value = index;
            bottomNavController.getUpdateState();
            print(_selectedScreenIndex.value);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: 'New'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_tree), label: 'In Progress'),
            BottomNavigationBarItem(
                icon: Icon(Icons.cancel_outlined), label: 'Cancel'),
            BottomNavigationBarItem(
                icon: Icon(Icons.done_all), label: 'Completed'),
          ],
        );
      }),
    );
  }
}
