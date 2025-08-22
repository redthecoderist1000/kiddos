import 'package:flutter/material.dart';

class TaskC extends StatefulWidget {
  const TaskC({super.key});

  @override
  State<TaskC> createState() => TtaskCState();
}

class TtaskCState extends State<TaskC> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // no need for scaffold

          // start coding here...
          // Header
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'My Task',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF9810FA),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('📝', style: TextStyle(fontSize: 28)),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                "Let's get things done and earn points!",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 24),

          //Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: TabBar(
              indicator: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(20),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.redAccent,
              tabs: [
                Tab(child: Row(children: [Text('Need Attention'), SizedBox(width: 4), CircleAvatar(radius: 10, backgroundColor: Colors.white, child: Text('5', style: TextStyle(color: Colors.redAccent, fontSize: 12)))])),
                Tab(child: Row(children: [Text('Approval'), SizedBox(width: 4), CircleAvatar(radius: 10, backgroundColor: Colors.white, child: Text('4', style: TextStyle(color: Colors.orange, fontSize: 12)))])),
                Tab(child: Row(children: [Text('Done'), SizedBox(width: 4), CircleAvatar(radius: 10, backgroundColor: Colors.white, child: Text('2', style: TextStyle(color: Colors.green, fontSize: 12)))])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
