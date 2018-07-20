import 'package:flutter/material.dart';
import '../mixins/validation_with_reusable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> with ValidationWithReusable {
  //const variables
  final formKey = GlobalKey<FormState>();
  FocusNode textSecondFocusNode = new FocusNode();
  String email = '';
  String password = '';
  //build function
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizes the items on the screen when the keyboard appears
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/back.jpeg'),
            //fits the image to the screen
            fit: BoxFit.cover,
            //mask over the image
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
          )
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 60.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: imageLogo(),
                ),
                Expanded(
                  flex: 2,
                  child: inputContainer(),
                ),
                Expanded(
                  flex: 1,
                  child: mediaContainer(),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }

  Widget imageLogo() {
    return Container(
      margin: EdgeInsets.only(top: 50.0, bottom: 10.0),
      child: Image.asset('images/logo.png'),
    );
  }

  Widget inputContainer() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          emailForm(),
          passwordForm(),
          Column(
            children: <Widget>[
              loginButton(),
              forgotPassword(),
            ],
          ),
        ],
      ),
    );
  }

  Widget mediaContainer() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          socialMedia(),
          signUp(),
        ],
      ),
    );
  }

  Widget emailForm() {
    return Container(
      //form background
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.1),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: TextFormField(
        //ux support button
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(textSecondFocusNode);
        },
        //keyboard style
        keyboardType: TextInputType.emailAddress,
        //typed text color
        style: TextStyle(
          color: Colors.white
        ),
        decoration: InputDecoration(
          //icon style
          prefixIcon: Padding(
            padding: EdgeInsetsDirectional.only(end: 10.0),
            child: Icon(
              Icons.mail,
              color: Colors.white
            ),
          ),
          //general text and style
          labelText: 'Email',
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          //help text and style
          hintText: 'Type your Email',
          hintStyle: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.4),
            fontSize: 13.0
          ),
          //sub line
          border: InputBorder.none,
          //interior padding
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 35.0, 10.0),
        ),
        //error message
        validator: validateEmail,
        //catch text
        onSaved: (String value) {
            email = value;
        },
      ),
    );
  }

  Widget passwordForm() {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.1),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: TextFormField(
        focusNode: textSecondFocusNode,
        //hide text
        obscureText: true,
        keyboardType: TextInputType.text,
        style: TextStyle(
          color: Colors.white
        ),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsetsDirectional.only(end: 10.0),
            child: Icon(Icons.lock, color: Colors.white),
          ),
          labelText: 'Password',
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          hintText: 'Type your Password',
          hintStyle: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.4),
            fontSize: 13.0
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 35.0, 10.0),
        ),
        validator: validatePassword,
        onSaved: (String value) {
          password = value;
        },
      ),
    );
  }

  Widget loginButton() {
    return Container(
      height: 48.0,
      //sets the width size to "infinity"
      width: double.infinity,
      //gradient background
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(255, 7, 105, 1.0),
            Color.fromRGBO(182, 2, 74, 1.0),
          ],
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter
        ),
        borderRadius: BorderRadius.circular(25.0)
      ),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Text(
          'Sign In',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        onPressed: () {
          //check via button if all forms are validated
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            //snackbar
            final submittedAction = SnackBar(
              content: Text('Email: $email | Pass: $password'),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  print('Undo Has Pressed');
                },
              ),
            );
            //shows the above function
            Scaffold.of(context).showSnackBar(submittedAction);
          }  
        },
      ),
    );
  }

  Widget forgotPassword() {
    return Container(
      child: FlatButton(
        //sets all presses to be transparent
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            fontSize: 11.0,
          ),
        ),
        textColor: Color.fromRGBO(255, 255, 255, 0.5),
        onPressed: () {
          print('Forgot Has Pressed');
        },
      ),
    );
  }

  Widget socialMedia() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildIconButton(FontAwesomeIcons.facebookF, 'Facebook'),
          buildIconButton(FontAwesomeIcons.google, 'Google'),
          buildIconButton(FontAwesomeIcons.twitter, 'Twitter'),
        ],
      ),
    );
  }
  
  Widget signUp() {
    return Container(
      child: FlatButton(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Text(
          'Not a member yet? Register Here.',
          style: TextStyle(
            fontSize: 11.0,
          ),
        ),
        textColor: Color.fromRGBO(255, 255, 255, 0.5),
        onPressed: () {
          print('Sign Up Has Pressed');
        },
      ),
    );
  }
}