import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MeP extends StatefulWidget {
  const MeP({super.key});

  @override
  State<MeP> createState() => _MePState();
}

class _MePState extends State<MeP> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // no need for scaffold

          // start coding here...
          Text('Me Page (parent)'),
          MaterialButton(
            onPressed: () {
              context.push('/settings-parent');
            },
            elevation: 0,
            textColor: Colors.white,
            color: Colors.deepPurpleAccent,
            child: Text('go to settings (parent)'),
          ),
        ],
      ),
    );
  }
}
