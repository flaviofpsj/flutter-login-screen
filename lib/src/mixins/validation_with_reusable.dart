import 'package:flutter/material.dart';

class ValidationWithReusable {
  //email validator function
  String validateEmail (String value) {
    if(!value.contains('@')) { 
      return 'Invalid Email';
    }
    return null;
  }
  //password validator function
  String validatePassword (String value) {
    if(value.length < 6) {
      return 'Password too short';
    }
    return null;
  }
  //reusable build icon button
  Container buildIconButton(IconData icon, String label) {
    //const variables
    Color colorIcon = Color.fromRGBO(255, 7, 105, 1.0);
    Color colorBack = Colors.white;
    //function return
    return Container(
      decoration: BoxDecoration(
        color: colorBack,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: colorIcon,
        ),
        onPressed: () {
          print(label);
        },
      ),
    );
  }
}