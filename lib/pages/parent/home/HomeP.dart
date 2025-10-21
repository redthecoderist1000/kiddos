import 'package:flutter/material.dart';
import 'package:kiddos/components/Button.dart';
import 'package:kiddos/components/Header.dart';
import 'package:kiddos/components/provider/KiddosProvider.dart';
import 'package:kiddos/pages/parent/home/component/homeTop.dart';
import 'package:kiddos/pages/parent/home/component/kidsAct/kidsAct.dart';
import 'package:kiddos/pages/parent/home/component/recentAct/recentAct.dart';
import 'package:kiddos/pages/parent/home/component/triBox.dart';
import 'package:provider/provider.dart';
import 'addTaskModal.dart';

class HomeP extends StatefulWidget {
  const HomeP({Key? key}) : super(key: key);

  @override
  State<HomeP> createState() => _HomePState();
}

class _HomePState extends State<HomeP> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<KiddosProvider>(context);

    showAddTaskModal() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddTaskModal();
        },
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Header(
              title: 'Hello, ${provider.userDetails!['user_name'] ?? ''}!',
              subtitle: 'Here\'s how your kids are doing today.',
              imagePath: 'assets/wave.png',
            ),
            // const HomeTop(),
            const TriBox(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: CustomButton(
                  icon: Icons.add,
                  text: 'Add Task',
                  onPressed: showAddTaskModal,
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
}
