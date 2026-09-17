import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 247, 249, 249),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 3, 1, 1),
                ),
              ),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color.fromARGB(255, 250, 249, 248),
                    width: 4.0,
                  ),
                ),
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('assets/images/profile.png'),
                ),
              ),

              SizedBox(height: 10),

              Text(
                'Samuel Abondejo',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 20.0,
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'MOBILE APP DEVELOPER',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  color: const Color.fromARGB(255, 194, 51, 18),
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 30),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: SizedBox(
                  child: Container(
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 15),
                        Icon(Icons.phone, color: Colors.black),
                        SizedBox(width: 10),
                        Text(
                          '08061517690',
                          style: TextStyle(
                            fontFamily: 'Pacifico',
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 15),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 15),
                      Icon(Icons.email, color: Colors.black),
                      SizedBox(width: 10),
                      Text(
                        'samuelsetemijp@gmail.com',
                        style: TextStyle(
                          fontFamily: 'Pacifico',
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
