import 'package:dtt/MainScreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    });

    return Scaffold(
      backgroundColor: Color(0xFFE65541),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
              Image.asset(
                'assets/Images/launcher_icon.png', 
                width: 333,  
                height: 333, 
              ),
              SizedBox(height: 20),
             
            ],
          ),
        ),
      ),
    );
  }
}
