import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:src/pages/home_page.dart';
import 'package:src/pages/qr_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      routes: {
        "/": (context) => HomePage(),
        "/qr": (context) => QrPage()
      },
      theme: ThemeData(fontFamily: GoogleFonts.dmSans().fontFamily, scaffoldBackgroundColor: Colors.white),
    )
  );
}
