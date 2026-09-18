import 'package:flutter/material.dart';

import 'pages/profile_page.dart';
import 'pages/projects_page.dart';
import 'pages/products_page.dart';
import 'pages/contact_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    ProfilePage(),
    ProjectsPage(),
    ProductsPage(),
    ContactPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: _buildNavBar(),
    );
  }

  Widget _buildNavBar() {
    return Container(
      height: 60,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _navIcon(Icons.person, 0),
          _navIcon(Icons.work, 1),
          _navIcon(Icons.shopping_bag, 2),
          _navIcon(Icons.email, 3),
        ],
      ),
    );
  }

  Widget _navIcon(IconData icon, int index) {
    final bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Icon(
        icon,
        color: isSelected ? Colors.white : Colors.grey,
        size: isSelected ? 28 : 24,
      ),
    );
  }

  IconData _iconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.person;
      case 1:
        return Icons.work;
      case 2:
        return Icons.shopping_bag;
      case 3:
        return Icons.mail;
      default:
        return Icons.error;
    }
  }
}

void main() {
  runApp(const MaterialApp(home: Home(), debugShowCheckedModeBanner: false));
}
