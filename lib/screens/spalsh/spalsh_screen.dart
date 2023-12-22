import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:staff_flutter_app/screens/home/home_screen.dart';
import 'package:staff_flutter_app/screens/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  LocalStorage storage = LocalStorage('usertoken');

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      navigate();
    });
  }

  void navigate() async {
    await storage.ready;

    if (storage.getItem('token') == null ||
        storage.getItem('token').toString().isEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/cadandcart.png',
          width: 250,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
