// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  int? selected;
  Navigation({super.key, required this.selected});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  Widget navButton(int index, String label, Icon icon, String route, bool enable) {
    return TextButton(
      onPressed: () {
        if (enable) {
          setState(() {
            widget.selected = index;
          });
          Navigator.popAndPushNamed(context, route);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          Text(
            label,
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
      style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(
              (widget.selected == index) ? Color(0xFF23B65E) : Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Card(
        color: Color(0xFF333333),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 2.5, 0, 2.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              navButton(0, "Home", Icon(Icons.home), "/home", true),
              navButton(1, "Your code", Icon(Icons.qr_code), "/qr", true),
              navButton(2, "Redeem", Icon(Icons.redeem), "/redeem", false),
              navButton(3, "Profile", Icon(Icons.account_circle), "/profile", true),
            ],
          ),
        ),
      ),
    );
  }
}
