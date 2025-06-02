import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streaming_app/main.dart';
import 'package:streaming_app/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String title = "Bienvenue sur MiniFlix";
  bool isLoading = false;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                color: MyApp.primaryRed,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Ne ratez plus aucune de vos séries préférées !",
              style: TextStyle(fontSize: 20, color: MyApp.primaryRed),
            ),
            Image.asset('images/App_logo.png', height: 200, width: 200),
            TextButton(
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(
                  MyApp.primaryRed,
                ),
                minimumSize: WidgetStateProperty.all(Size(100, 70)),
              ),
              onPressed: () {
                setState(() {
                  isLoading = true;
                });
                Future.delayed(Duration(seconds: 10), () {
                  Get.off(() => LoginPage());
                });
              },
              child: Text(
                'Start',
                style: TextStyle(
                  fontSize: 20,
                  color: MyApp.primaryRed,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (isLoading)
              const CircularProgressIndicator(color: MyApp.primaryRed),
          ],
        ),
      ),
    );
  }
}
