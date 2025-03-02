import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:src/pages/earning_page.dart';
import 'package:src/pages/home_page.dart';
import 'package:src/pages/login_page.dart';
import 'package:src/pages/profile_page.dart';
import 'package:src/pages/qr_page.dart';
import 'package:src/pages/signup_page.dart';
import 'package:src/pages/spending_page%20.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    routes: {
      "/": (context) => LoginPage(),
      "/signup": (context) => SignupPage(),
      "/home": (context) => HomePage(),
      "/qr": (context) => QrPage(),
      "/earned": (context) => EarningPage(),
      "/spent": (context) => SpendingPage(),
      "/profile": (context) => ProfilePage()
    },
    theme: ThemeData(
        primaryColor: Color(0xFF333333),
        fontFamily: GoogleFonts.dmSans().fontFamily,
        scaffoldBackgroundColor: Colors.white),
  ));
}
