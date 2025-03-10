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
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController zipController = TextEditingController();
  bool passwordMatch = true;
  bool nameEmpty = false;
  bool emailEmpty = false;
  bool passwordEmpty = false;
  bool password2Empty = false;
  bool zipEmpty = false;

  void signup() {
    SecureStorage.writeMany({"email": emailController.text, "zip": zipController.text});
    Navigator.popAndPushNamed(context, "/home");
  }

  Widget inputField(String name, TextEditingController controller, bool error, String errorText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Text(
            name,
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
              errorText: (error) ? errorText : null
            ),
          controller: controller,
        )
      ],
    );
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
              SizedBox(
                height: 100,
              ),
              inputField("Name", nameController, nameEmpty, "Name is required"),
              SizedBox(
                height: 20,
              ),
              inputField("Email", emailController, emailEmpty, "Email is required"),
              SizedBox(
                height: 20,
              ),
              inputField("Password", passwordController, passwordEmpty, "Password is required"),
              SizedBox(
                height: 20,
              ),
              inputField("Re-enter Password", password2Controller, password2Empty, "Re-entered password is required"),
              SizedBox(
                height: 20,
              ),
              inputField("Zip code", zipController, zipEmpty, "Zip code is required"),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      passwordMatch = (passwordController.text == password2Controller.text);
                      nameEmpty = nameController.text.isEmpty;
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
