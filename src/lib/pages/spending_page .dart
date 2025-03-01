// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class SpendingPage extends StatelessWidget {
  SpendingPage({super.key});

  Color defaultColor = Color(0xFF333333);
  Color defaultGreen = Color(0xFF23B65E);

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Map;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_outline_outlined, color: defaultGreen, size: 150,),
              Text("You're all set! You spent", style: TextStyle(color: defaultColor, fontSize: 18),),
              Text("${args["coins"]} coins", style: TextStyle(color: defaultColor, fontSize: 24, fontWeight: FontWeight.bold),),
              Text("in ${args["location"]}", style: TextStyle(color: defaultColor, fontSize: 18),),
            ],
          ),
        ),
      )
    );
  }
}