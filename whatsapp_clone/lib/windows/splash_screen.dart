import 'dart:async';
import 'dart:math' as math;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../phone Auth/phone_auth.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 3,
      ),
    );
    _controller.forward();
    Timer(
      const Duration(seconds: 5),
      () {
        if (_auth.currentUser != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const MyHomePage(),
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const PhoneAuth(),
            ),
          );
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: _controller,
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      Transform.rotate(
                        angle: _controller.value * 2.0 * math.pi,
                        // child: const Text(
                        //   'Q',
                        //   style: TextStyle(
                        //     fontSize: 50,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        child: const Icon(
                          Icons.call,
                          size: 40,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Transform.scale(
                        scale: _controller.value * 1.0 * math.pi,
                        child: const Text('Whats app clone'),
                      ),
                    ],
                  );
                }),
            // const Text(
            //   'Covid App',
            // ),
          ],
        ),
      )),
    );
  }
}
