import 'package:flutter/material.dart';
import 'package:src/services/secure_storage.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    Color defaultColor = Color(0xFF333333);

    return TextButton.icon(
      onPressed: () async {
        await SecureStorage.delete();
        Navigator.popAndPushNamed(context, "/");
      }, 
      icon: Icon(Icons.logout, color: defaultColor,),
      label: Text("Logout", style: TextStyle(color: defaultColor, fontSize: 16),),
      iconAlignment: IconAlignment.end,
    );
  }
}