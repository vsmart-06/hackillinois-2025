import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:src/services/secure_storage.dart';
import 'package:src/widgets/logout_button.dart';
import 'package:src/widgets/navigation.dart';

class QrPage extends StatefulWidget {
  const QrPage({super.key});

  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  Color defaultColor = Color(0xFF333333);
  Color defaultGreen = Color(0xFF23B65E);
  String? email;
  String? zip;
  String? wallet;
  String? name;
  int? coins;
  int? cash;
  bool loaded = false;
  int selected = 0;

  String baseUrl = "https://8eac-130-126-255-124.ngrok-free.app";

  void loadCoins() async {
    var response = await post(Uri.parse(baseUrl + "/home"), headers: {"Content-Type": "application/json"}, body: jsonEncode({"wallet": wallet}));
    var info = jsonDecode(response.body);
    setState(() {
      coins = (int.parse(info["balance"]) / (10e8)).toInt();
      cash = info["user"]["cash"];
      loaded = true;
    });
  }

  void loadDetails() async {
    String? e = await SecureStorage.read("email");
    String? z = await SecureStorage.read("zip");
    String? w = await SecureStorage.read("wallet");
    String? n = await SecureStorage.read("name");
    setState(() {
      email = e;
      zip = z;
      wallet = w;
      name = n;
    });
    loadCoins();
    Timer.periodic(Duration(seconds: 30), (timer) {loadCoins();});
  }

  Widget qrButton(String name, int index) {
    return TextButton(
      onPressed: () {
        setState(() {
          selected = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Text(
          name,
          style: TextStyle(fontSize: 16),
        ),
      ),
      style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(
              (selected == index) ? Colors.white : defaultColor),
          backgroundColor: WidgetStatePropertyAll(
              (selected == index) ? defaultGreen : Colors.white),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(
                  color: (selected == index)
                      ? Colors.transparent
                      : defaultColor)))),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDetails();
  }

  @override
  Widget build(BuildContext context) {
    if (!loaded) return Scaffold(body: Center(child: LoadingAnimationWidget.fourRotatingDots(color: defaultGreen, size: 50),),);
    return SafeArea(
        child: Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {loadCoins();},
        color: defaultGreen,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height - kBottomNavigationBarHeight),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.25,
                          color: defaultGreen,
                        ),
                        SizedBox(
                          height: 90,
                        )
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(300),
                        color: Colors.white,
                      ),
                      width: 180,
                      height: 180,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(300),
                          child: Image(
                            image: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRs10cupyp3Wf-pZvdPjGQuKne14ngVZbYdDQ&s"),
                            width: 150,
                            height: 150,
                          )),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 10, 0),
                          child: LogoutButton(
                            white: true,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Text(
                  name!,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    qrButton("Wallet", 0),
                    SizedBox(
                      width: 20,
                    ),
                    qrButton("TRC", 1),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                QrImageView(
                  data: baseUrl + "/transit-pay?wallet=${wallet!}&cash=${cash!}&time=${DateTime.now().toString()}",
                  size: 170,
                ),
                SizedBox(height: 20,),
                Text(
                  "Your wallet",
                  style: TextStyle(fontSize: 14, color: defaultColor),
                ),
                Text(
                  ((selected == 0) ? "\$${cash}.00" : "${coins} coins"),
                  style: TextStyle(
                      fontSize: 30,
                      color: defaultColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Navigation(
        selected: 1,
      ),
    ));
  }
}
