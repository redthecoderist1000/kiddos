import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ParentScaffold extends StatefulWidget {
  final StatefulNavigationShell child;
  const ParentScaffold({super.key, required this.child});

  @override
  State<ParentScaffold> createState() => _ParentScaffoldState();
}

class _ParentScaffoldState extends State<ParentScaffold> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: widget.child.currentIndex == 0
            ? Color.fromARGB(255, 239, 207, 245)
            : Colors.grey[50],
        body: widget.child,
        bottomNavigationBar: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: const Offset(5.0, 5.0),
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ),
              BoxShadow(
                color: Colors.white,
                offset: const Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ),
            ],
            borderRadius: BorderRadiusDirectional.vertical(
              top: Radius.circular(25),
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: widget.child.currentIndex,
            onTap: widget.child.goBranch,
            type: BottomNavigationBarType.shifting,
            unselectedItemColor: Colors.grey.shade400,
            selectedItemColor: Colors.deepPurpleAccent,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.checklist_rounded),
                label: 'Task',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.insights_rounded),
                label: 'Progess',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.emoji_events_rounded),
                label: 'Reward',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.family_restroom_rounded),
                label: 'Profiles',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.face),
                label: 'Me',
              ),
            ],
          ),
        ),
      ),
    );
  }
}