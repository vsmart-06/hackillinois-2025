import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:src/pages/earning_page.dart';
import 'package:src/pages/home_page.dart';
import 'package:src/pages/qr_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    routes: {
      "/": (context) => HomePage(),
      "/qr": (context) => QrPage(),
      "/earned": (context) => EarningPage()
    },
    theme: ThemeData(
        primaryColor: Color(0xFF333333),
        fontFamily: GoogleFonts.dmSans().fontFamily,
        scaffoldBackgroundColor: Colors.white),
  ));
}
