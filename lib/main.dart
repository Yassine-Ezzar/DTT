import 'package:dtt/Splash%20Screen.dart';
import 'package:dtt/styles/styles.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DTTRealEstateApp());
}

class DTTRealEstateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DTT Real Estate',
      theme: ThemeData(
        primaryColor: Styles.defaultRedColor,  
        scaffoldBackgroundColor: Styles.scaffoldBackgroundColor,  
        appBarTheme: AppBarTheme(
          backgroundColor: Styles.defaultWhiteColor,
          titleTextStyle: Styles.title01.copyWith(color: Styles.defaultStrongColor), 
        ),
        textTheme: TextTheme(
          displayLarge: Styles.title01,  
          displayMedium: Styles.title02,  
          displaySmall: Styles.title03,  
          bodyLarge: Styles.bodyBook,  
          bodyMedium: Styles.bodyBook, 
          bodySmall: Styles.bodyBook,  
          titleMedium: Styles.subtitleBook,  
          labelSmall: Styles.hintBook,  
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: Styles.hintBook,  
          labelStyle: Styles.bodyBook,  
        ),
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
