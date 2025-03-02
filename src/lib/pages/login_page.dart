import 'package:flutter/material.dart';
import 'package:src/services/secure_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color defaultColor = Color(0xFF333333);
  Color defaultGreen = Color(0xFF23B65E);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? email;
  String? zip;
  String? wallet;
  String? name;

  bool emailError = false;
  bool passwordError = false;

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
    if (!(e == null || z == null || w == null || n == null)) {
      await Navigator.popAndPushNamed(context, "/home");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDetails();
  }

  void login() {
    SecureStorage.writeMany({"email": emailController.text});
    Navigator.popAndPushNamed(context, "/home");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: defaultGreen,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 100, 30, 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
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
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      "Email",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  TextField(
                    cursorColor: defaultColor,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: defaultColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: defaultColor)),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: defaultColor)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: defaultColor)),
                        focusColor: Colors.white,
                        errorText: (emailError) ? "Email is required" : null
                      ),
                    controller: emailController,
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      "Password",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  TextField(
                    cursorColor: defaultColor,
                    obscureText: true,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: defaultColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: defaultColor)),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: defaultColor)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: defaultColor)),
                        focusColor: Colors.white,
                        errorText: (passwordError) ? "Password is required" : null
                      ),
                    controller: passwordController,
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    emailError = emailController.text.isEmpty;
                    passwordError = passwordController.text.isEmpty;
                  });
                  if (!emailError && !passwordError) login();
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                style: ButtonStyle(
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                  backgroundColor: WidgetStatePropertyAll(defaultColor),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                  elevation: WidgetStatePropertyAll(5)
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, "/signup");
                }, 
                child: Text("If you do not have an account, sign up here!", style: TextStyle(fontSize: 16, decoration: TextDecoration.underline, decorationColor: Colors.white),),
                style: ButtonStyle(
                  foregroundColor: WidgetStatePropertyAll(Colors.white)
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
