import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:src/services/secure_storage.dart';
import 'package:src/widgets/logout_button.dart';
import 'package:src/widgets/navigation.dart';

class RedeemPage extends StatefulWidget {
  const RedeemPage({super.key});

  @override
  State<RedeemPage> createState() => _RedeemPageState();
}

class _RedeemPageState extends State<RedeemPage> {
  Color defaultColor = Color(0xFF333333);
  Color defaultGreen = Color(0xFF23B65E);
  String? email;
  String? zip;
  String? wallet;
  String? name;
  int? coins;
  bool loaded = false;

  String baseUrl = "https://8eac-130-126-255-124.ngrok-free.app";

  void loadCoins() async {
    var response = await post(Uri.parse(baseUrl + "/home"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"wallet": wallet}));
    var info = jsonDecode(response.body);
    setState(() {
      coins = (int.parse(info["balance"]) / (10e8)).toInt();
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
  }

  Widget redeemCard(String image, String name, int limit) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      constraints: BoxConstraints(
          minWidth: 380, maxWidth: 380, minHeight: 250, maxHeight: 250),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image(
                  image: NetworkImage(image),
                  width: 380,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                  ),
                  width: 360,
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              color: defaultColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Text(
                          "Accepting upto ${limit} TRC",
                          style: TextStyle(color: defaultColor, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
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
      body: Stack(
        children: [
          Container(
            color: defaultGreen,
            width: MediaQuery.of(context).size.width,
            height: 0.3 * MediaQuery.of(context).size.height,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 20),
            child: RefreshIndicator(
              onRefresh: () async {loadCoins();},
              color: defaultGreen,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text("${coins!} TRC", style: TextStyle(color: Colors.white, fontSize: 18),),
                      ),
                      LogoutButton(white: true,)
                    ],
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: redeemCard(
                        "https://cdn-ds.com/blogs-media/sites/641/2022/04/28225732/a_o_fancy_restaurant.jpg",
                        "Olive Garden",
                        30),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: redeemCard(
                        "https://assets.architecturaldigest.in/photos/6385cf3311f0276636badfb6/16:9/w_2560%2Cc_limit/DSC_8367-Edit-W.png",
                        "Naya Indian Cuisine",
                        25),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: redeemCard(
                        "https://staybluemaple.com/wp-content/themes/yootheme/cache/97/7-Best-Restaurants-in-Winchester-VA-9741ccb9.jpeg",
                        "Black Dog",
                        50),
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Navigation(selected: 2),
    ));
  }
}
