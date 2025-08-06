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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: widget.child),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: BottomNavigationBar(
          currentIndex: widget.child.currentIndex,
          onTap: widget.child.goBranch,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey.shade600,
          selectedItemColor: Colors.deepPurple,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pending_actions_rounded),
              label: 'Task',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star_rounded),
              label: 'Progess',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_outlined),
              label: 'Profiles',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Me'),
          ],
        ),
      ),
    );
  }
}
