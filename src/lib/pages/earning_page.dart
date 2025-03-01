// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class Earned extends StatelessWidget {
  Earned({super.key});

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
              Text("You're all set! You earned", style: TextStyle(color: defaultColor, fontSize: 18),),
              Text("${args["coins"]} coins", style: TextStyle(color: defaultColor, fontSize: 24, fontWeight: FontWeight.bold),),
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: Column(
                  children: [
                    Text(args["route"], style: TextStyle(color: defaultColor, fontSize: 14),),
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: defaultColor,
                                    borderRadius: BorderRadius.circular(300)
                                  ),
                                  width: 20,
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: defaultGreen,
                                      borderRadius: BorderRadius.circular(300)
                                    ),
                                    width: 10,
                                    height: 10,
                                  ),
                                ),
                              ],
                            ),
                            Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: defaultColor,
                                    borderRadius: BorderRadius.circular(300)
                                  ),
                                  width: 20,
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: defaultGreen,
                                      borderRadius: BorderRadius.circular(300)
                                    ),
                                    width: 10,
                                    height: 10,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
                          child: Container(
                            height: 6,
                            color: defaultGreen,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 3,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(args["start"], style: TextStyle(color: defaultColor, fontSize: 14),),
                        Text(args["end"], style: TextStyle(color: defaultColor, fontSize: 14),),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}