import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:src/services/secure_storage.dart';
import 'package:src/widgets/logout_button.dart';
import 'package:src/widgets/navigation.dart';
import "package:http/http.dart";

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Color defaultColor = Color(0xFF333333);
  Color defaultGreen = Color(0xFF23B65E);
  String? email;
  String? zip;
  String? wallet;
  String? name;
  List? history;

  bool loaded = false;

  String baseUrl = "https://8eac-130-126-255-124.ngrok-free.app";

  void loadHistory() async {
    var response = await get(Uri.parse(baseUrl + "/history?wallet=" + wallet!),
        headers: {"Content-Type": "application/json"});
    List info = jsonDecode(response.body)["data"];
    print(info);

    DateTime date = DateTime.parse(info[0]["created_at"]);

    setState(() {
      history = info
          .map((e) => {
                "image":
                    "https://pbs.twimg.com/profile_images/1567987942576078854/pANzzewx_400x400.jpg",
                "route": "Yellow 1S",
                "journey": e["start"] + " - " + e["stop"],
                "date": "${date.day}/${date.month}/${date.year}",
                "coins": int.parse(e["coins"])
              })
          .toList();
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
    loadHistory();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDetails();
  }

  Widget badgeWidget(String text, Color primaryColor, Color secondaryColor,
      {Icon? icon, String? value}) {
    return Card(
      elevation: 10,
      shadowColor: Color(0x77000000),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: 100,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (icon != null)
                  ? icon
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          value!,
                          style: TextStyle(
                              fontSize: 20,
                              color: defaultGreen,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "TRC",
                          style: TextStyle(
                              fontSize: 20,
                              color: defaultGreen,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
              Text(
                text,
                style: TextStyle(fontSize: 14, color: secondaryColor),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget historyItem(String image, String heading, String date, int price,
      [String? subHeading]) {
    return Container(
      constraints: BoxConstraints(minHeight: 90),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: defaultColor)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image(
                  image: NetworkImage(image, scale: 1),
                  width: 56,
                  height: 56,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  width: 30,
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        heading,
                        style: TextStyle(
                            color: defaultColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      (subHeading != null)
                          ? Text(
                              subHeading,
                              style:
                                  TextStyle(color: defaultColor, fontSize: 12),
                            )
                          : Container(),
                      Text(
                        date,
                        style: TextStyle(color: defaultColor, fontSize: 10),
                      ),
                    ]),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ((price > 0) ? "+" : "") + price.toString(),
                  style: TextStyle(
                      color: (price > 0) ? defaultGreen : Color(0xFFFD4E64),
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "TRC",
                  style: TextStyle(
                      color: (price > 0) ? defaultGreen : Color(0xFFFD4E64),
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!loaded)
      return Scaffold(
        body: Center(
          child: LoadingAnimationWidget.fourRotatingDots(
              color: defaultGreen, size: 50),
        ),
      );
    return SafeArea(
        child: Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          loadHistory();
        },
        color: defaultGreen,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  badgeWidget("97 bus rides", defaultColor, Colors.white,
                      icon: Icon(
                        Icons.directions_bus_filled,
                        size: 40,
                        color: Colors.white,
                      )),
                  badgeWidget("earned", Colors.white, defaultColor,
                      value: "350+"),
                  badgeWidget("30 train rides", defaultColor, Colors.white,
                      icon: Icon(
                        Icons.train,
                        size: 40,
                        color: Colors.white,
                      )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "History",
                style: TextStyle(
                    fontSize: 20,
                    color: defaultColor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  children: history!
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: historyItem(e["image"], e["route"],
                                  e["date"], e["coins"], e["journey"]),
                            ),
                          )
                          .toList() +
                      [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: historyItem(
                              "https://pbs.twimg.com/profile_images/1567987942576078854/pANzzewx_400x400.jpg",
                              "Route 50E",
                              "02/03/2025",
                              32,
                              "Lincoln Square - Illini Union"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: historyItem(
                              "https://img.vendingmarketwatch.com/files/base/cygnus/vmw/image/2014/06/caffe-bene-logo_11514716.png",
                              "Caffe Bene Green",
                              "01/03/2025",
                              -50),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: historyItem(
                              "https://1000logos.net/wp-content/uploads/2020/09/Amtrak-Logo.png",
                              "New Orleans Line",
                              "21/01/2025",
                              -50,
                              "Chicago Union - Illinois Terminal"),
                        ),
                      ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Navigation(
        selected: 3,
      ),
    ));
  }
}
