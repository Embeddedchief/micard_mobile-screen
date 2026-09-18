import 'package:flutter/material.dart';

class ProjectsPage extends StatefulWidget {
  const new({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "This is my Projects Page",
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}
