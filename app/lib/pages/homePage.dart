// ignore_for_file: file_names
import 'package:app/components/letsTalkButton.dart';
import 'package:app/components/loginButton.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF7C76BB),
        // leading: const Padding(
        //   padding: EdgeInsets.all(12.0),
        //   child: Icon(
        //     Icons.menu,
        //     color: Colors.white,
        //     size: 32,
        //   ),
        // ),
        title: Center(
          child: Image.asset(
            'images/logo.png',
            height: 42,
          ),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Column(
                children: [
                  Text(
                    'Hello!',
                    style: TextStyle(
                        color: Color(0xFF7C76BB),
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Welcome to UpBusiness',
                    style: TextStyle(
                        color: Color(0xFF7C76BB),
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  LoginButton(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Image.asset('images/build.png'),
              const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'How to ',
                        style: TextStyle(
                          color: Color(0xFF7C76BB),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'level up',
                        style: TextStyle(
                          color: Color(0xFFFF87B0),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' your',
                        style: TextStyle(
                          color: Color(0xFF7C76BB),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'business?',
                    style: TextStyle(
                      color: Color(0xFF7C76BB),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const LetsTalkButton(),
            ],
          ),
        ),
      ),
    );
  }
}
