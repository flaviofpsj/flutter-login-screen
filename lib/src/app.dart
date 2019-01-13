import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login/login_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    //controls screen orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Log In Screen',
      home: new Scaffold(
        body: new LoginScreen(),
      ),
    );
  }
}
