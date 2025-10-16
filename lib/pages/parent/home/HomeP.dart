import 'package:flutter/material.dart';
import 'package:kiddos/components/Button.dart';
import 'package:kiddos/components/Header.dart';
import 'package:kiddos/pages/parent/home/component/homeTop.dart';
import 'package:kiddos/pages/parent/home/component/kidsAct/kidsAct.dart';
import 'package:kiddos/pages/parent/home/component/recentAct/recentAct.dart';
import 'package:kiddos/pages/parent/home/component/triBox.dart';
import 'addTaskModal.dart';

class HomeP extends StatelessWidget {
  const HomeP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Header(
              title: 'Hello, Parent!',
              subtitle: 'Here\'s how your kids are doing today.',
              imagePath: 'assets/wave.png',
            ),
            const HomeTop(),
            const TriBox(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: CustomButton(
                  icon: Icons.add,
                  text: 'Add Task',
                  onPressed: () {
                    _showAddTaskModal(context);
                  },
                ),
              ),
            ),
            const KidsAct(),
            const RecentAct(),
          ],
        ),
      ),
    );
  }

  void _showAddTaskModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddTaskModal(
          onTaskAdded: (newTask) {
            // Handle the new task here
            // You can add it to a state management solution or pass it up to parent
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Task created successfully!')),
            );
            print('New task created: $newTask');
          },
        );
      },
    );
  }
}