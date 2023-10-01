import 'package:eventhub/auth.dart';
import 'package:eventhub/colors/colors.dart';
import 'package:eventhub/views/homepage.dart';
import 'package:eventhub/views/login.dart';
import 'package:flutter/material.dart';

class CheckSession extends StatefulWidget {
  const CheckSession({super.key});

  @override
  State<CheckSession> createState() => _CheckSessionState();
}

class _CheckSessionState extends State<CheckSession> {
  @override
  void initState() {
    super.initState();
    checkSession().then((value) {
      if (value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          height: 70,
          width: 70,
          child: CircularProgressIndicator(
            color: kPrimary,
            strokeWidth: 8,
          ),
        ),
      ),
    );
  }
}
