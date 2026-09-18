import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'my_background.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // backgroundColor: const Color.fromARGB(255, 247, 249, 249),
        body: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  child: const MyBackground(),
                ),
                Positioned(
                  top: 350,
                  left: 30,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 5.0),
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: Transform.flip(
                        flipX: true,
                        child: Image.asset(
                          'assets/images/profile.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 60),

            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Samuel Abondejo',
                        style: TextStyle(
                          fontFamily: 'Pacifico',
                          fontSize: 20.0,
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(width: 4),

                      SvgPicture.asset(
                        'assets/icons/tick.svg',
                        width: 18,
                        height: 18,
                      ),
                    ],
                  ),

                  Text(
                    "Mobile App Developer | Techpreneur",
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      color: const Color.fromARGB(255, 240, 19, 19),
                      fontSize: 12.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "A software engineer grounded in the fundamentals [OOP, encapsulation, inheritance, state management, widget lifecycle, and clean architecture]. I don't just write code, I debug my way to understanding it. My focus is on logic that actually works: solid state management, layouts that hold up on any screen, and UI details that matter. Check out my projects below",
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
