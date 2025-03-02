// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:src/services/secure_storage.dart';

class LogoutButton extends StatelessWidget {
  bool white;
  LogoutButton({super.key, this.white = false});
  Color defaultColor = Color(0xFF333333);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () async {
        await SecureStorage.delete();
        Navigator.popAndPushNamed(context, "/");
      }, 
      icon: Icon(Icons.logout, color: (!white) ? defaultColor : Colors.white,),
      label: Text("Logout", style: TextStyle(color: (!white) ? defaultColor : Colors.white, fontSize: 16),),
      iconAlignment: IconAlignment.end,
    );
  }
}