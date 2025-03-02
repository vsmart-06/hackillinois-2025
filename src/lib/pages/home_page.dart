import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:src/services/secure_storage.dart';
import 'package:src/widgets/logout_button.dart';
import 'package:src/widgets/navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color defaultColor = Color(0xFF333333);
  Color defaultGreen = Color(0xFF23B65E);
  String? email;
  String? zip;
  String? wallet;
  String? name;
  bool loaded = false;

  int? coins;

  String baseUrl = "https://8eac-130-126-255-124.ngrok-free.app";

  void loadCoins() async {
    var response = await post(Uri.parse(baseUrl + "/home"), headers: {"Content-Type": "application/json"}, body: jsonEncode({"ata_acc_add": wallet}));
    var info = jsonDecode(response.body);
    setState(() {
      coins = int.parse(info["balance"]);
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
      loaded = true;
    });
    loadCoins();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDetails();
  }

  @override
  Widget build(BuildContext context) {
    if (!loaded) return Scaffold(body: Center(child: LoadingAnimationWidget.fourRotatingDots(color: defaultGreen, size: 50)));
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      label: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Urbana, IL",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            zip!,
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                      icon: Icon(
                        Icons.location_on,
                        size: 40,
                      ),
                      style: ButtonStyle(
                          foregroundColor:
                              WidgetStatePropertyAll(defaultColor)),
                    ),
                    LogoutButton()
                  ],
                ),
                SizedBox(height: 50),
                Text(
                  "Your wallet",
                  style: TextStyle(fontSize: 14, color: defaultColor),
                ),
                Text(
                  "${coins} coins",
                  style: TextStyle(
                      fontSize: 30,
                      color: defaultColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: defaultColor),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  children: [
                                    Text(
                                      "Urbana, IL",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: defaultColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "\$1 = 12 coins",
                                      style: TextStyle(
                                          fontSize: 14, color: defaultColor),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Text(
                                  "+4.2%",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: defaultGreen,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Image(
                            image: NetworkImage(
                                "https://static.vecteezy.com/system/resources/previews/011/115/550/non_2x/financial-business-statistics-with-bar-graph-and-candlestick-chart-show-stock-market-price-and-effective-earning-on-white-background-vector.jpg"),
                            width: 340,
                            height: 170,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: defaultColor),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Chicago, IL",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: defaultColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "\$1 = 12 coins",
                                    style: TextStyle(
                                        fontSize: 14, color: defaultColor),
                                  ),
                                  Text(
                                    "+2.1%",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: defaultGreen,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Image(
                                image: NetworkImage(
                                    "https://static.vecteezy.com/system/resources/previews/011/115/550/non_2x/financial-business-statistics-with-bar-graph-and-candlestick-chart-show-stock-market-price-and-effective-earning-on-white-background-vector.jpg"),
                                width: 150,
                                height: 135,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: defaultColor),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Atlanta, GA",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: defaultColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "\$1 = 12 coins",
                                    style: TextStyle(
                                        fontSize: 14, color: defaultColor),
                                  ),
                                  Text(
                                    "-3.5%",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFFFD4E64),
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Image(
                                image: NetworkImage(
                                    "https://static.vecteezy.com/system/resources/previews/011/115/550/non_2x/financial-business-statistics-with-bar-graph-and-candlestick-chart-show-stock-market-price-and-effective-earning-on-white-background-vector.jpg"),
                                width: 150,
                                height: 135,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "See more",
                      style: TextStyle(
                          fontSize: 12),
                    ),
                    style: ButtonStyle(
                      padding: WidgetStatePropertyAll(EdgeInsets.all(3)),
                      foregroundColor: WidgetStatePropertyAll(defaultColor),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: WidgetStatePropertyAll(Size.zero),
                      shape: WidgetStatePropertyAll(LinearBorder.bottom(side: BorderSide(), size: 0.7))
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Align(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text("Redeem your coins",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: defaultColor)),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        style: ButtonStyle(
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(side: BorderSide.none, borderRadius: BorderRadius.circular(10))),
                        ),
                        onPressed: () {}, 
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                image: NetworkImage(
                                    "https://cdn1.matadornetwork.com/blogs/1/2021/10/jones-k-original-american-diner-themed-restaurant.jpeg"),
                                width: 160,
                                height: 160,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                      colors: [Color(0x99000000), Colors.transparent],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter)),
                              width: 160,
                              height: 160,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                              child: Text(
                                "Restaurants",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(side: BorderSide.none, borderRadius: BorderRadius.circular(10))),
                        ),
                        onPressed: () {}, 
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                image: NetworkImage(
                                    "https://www.veoride.com/wp-content/uploads/2023/09/IMG_3115-scaled.jpg"),
                                width: 160,
                                height: 160,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                      colors: [Color(0x99000000), Colors.transparent],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter)),
                              width: 160,
                              height: 160,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                              child: Text(
                                "E-bikes",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Navigation(selected: 0,),
      ),
    );
  }
}
