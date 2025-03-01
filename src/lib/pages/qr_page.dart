import 'package:flutter/material.dart';
import 'package:src/widgets/navigation.dart';

class QrPage extends StatefulWidget {
  const QrPage({super.key});

  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  Color defaultColor = Color(0xFF333333);
  Color defaultGreen = Color(0xFF23B65E);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
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
              ],
            ),
            Text("Carl Evans", style: TextStyle(fontSize: 18),),
            SizedBox(height: 50,),
            Image(image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/7/7b/Qr-code-ver-10.svg/220px-Qr-code-ver-10.svg.png"), width: 170, height: 170,),
            Text(DateTime.now().toString(), style: TextStyle(fontSize: 16),)
          ],
        ),
      ),
      bottomNavigationBar: Navigation(
        selected: 1,
      ),
    ));
  }
}
