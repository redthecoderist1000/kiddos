import 'package:flutter/material.dart';
import 'package:kiddos/components/Button.dart';
import 'component/taskPageLeadP.dart';
import 'component/tabTaskP.dart';
import 'component/taskTileP.dart';
import '../home/addTaskModal.dart';

class TaskP extends StatefulWidget {
  const TaskP({super.key});

  @override
  State<TaskP> createState() => _TaskPState();
}

class _TaskPState extends State<TaskP> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TaskPageLeadP(),
          TaskTabsP(
            selectedIndex: selectedTab,
            onTabSelected: (index) {
              setState(() {
                selectedTab = index;
              });
            },
          ),
          
          // Add Task Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: 'Add Task',
                icon: Icons.add,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                iconColor: Colors.white,
                onPressed: () {
                  _showAddTaskModal();
                },
              ),
            ),
          ),
          
          // Example: show different tiles based on selectedTab
          if (selectedTab == 0 || selectedTab == 2)
            TaskTileP(
              status: selectedTab == 2 ? "completed" : "needs_confirmation",
              category: selectedTab == 2 ? "Cleaning" : "Learning",
              categoryIcon: selectedTab == 2 ? Icons.cleaning_services : Icons.menu_book,
              title: selectedTab == 2 ? "Clean bedroom" : "Read for 30 minutes",
              description: selectedTab == 2
                  ? "Organize toys, make bed, and vacuum floor"
                  : "Choose any book and read quietly",
              userName: selectedTab == 2 ? "Lily" : "Max",
              userAvatarUrl: "",
              points: selectedTab == 2 ? 25 : 20,
              date: "Today",
              onConfirm: () {},
              onEdit: () {},
              onDelete: () {},
            ),
          if (selectedTab == 1)
            TaskTileP(
              status: "needs_confirmation",
              category: "Learning",
              categoryIcon: Icons.menu_book,
              title: "Read for 30 minutes",
              description: "Choose any book and read quietly",
              userName: "Max",
              userAvatarUrl: "",
              points: 20,
              date: "Today",
              onConfirm: () {},
              onEdit: () {},
              onDelete: () {},
            ),
        ],
      ),
    );
  }

  void _showAddTaskModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddTaskModal(
          onTaskAdded: (newTask) {
            // Handle the new task here
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Task created successfully!')),
            );
            print('New task created: $newTask');
            // You can add the task to your task list here
          },
        );
      },
    );
  }
}