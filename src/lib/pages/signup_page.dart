import 'package:flutter/material.dart';
import 'package:src/services/secure_storage.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  Color defaultColor = Color(0xFF333333);
  Color defaultGreen = Color(0xFF23B65E);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController zipController = TextEditingController();
  bool passwordMatch = true;
  bool emailEmpty = false;
  bool passwordEmpty = false;
  bool password2Empty = false;
  bool zipEmpty = false;

  void signup() {
    SecureStorage.writeMany({"email": emailController.text, "zip": zipController.text});
    Navigator.popAndPushNamed(context, "/home");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: defaultGreen,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
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
                        errorText: (emailEmpty) ? "Email is required" : null
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
                        errorText: (passwordEmpty) ? "Password is required" : null
                      ),
                    controller: passwordController,
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
                      "Re-enter Password",
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
                        errorText: (!passwordMatch) ? "The passwords must match" : (password2Empty) ? "Re-entered password is required" : null
                      ),
                    controller: password2Controller,
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
                      "Zip Code",
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
                        errorText: (zipEmpty) ? "Zip code is required" : null
                      ),
                    controller: zipController,
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      passwordMatch = (passwordController.text == password2Controller.text);
                      emailEmpty = emailController.text.isEmpty;
                      passwordEmpty = passwordController.text.isEmpty;
                      password2Empty = password2Controller.text.isEmpty;
                      zipEmpty = zipController.text.isEmpty;
                    });
                    if (!passwordMatch || emailEmpty || passwordEmpty || password2Empty || zipEmpty) return;
                    signup();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Text(
                      "Sign Up",
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
                    Navigator.popAndPushNamed(context, "/");
                  }, 
                  child: Text("If you already have an account, login here!", style: TextStyle(fontSize: 16, decoration: TextDecoration.underline, decorationColor: Colors.white),),
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
