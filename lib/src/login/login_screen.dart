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
    return new Scaffold(
      //resizes the items on the screen when the keyboard appears
      resizeToAvoidBottomPadding: false,
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage('images/back.jpeg'),
            //fits the image to the screen
            fit: BoxFit.cover,
            //mask over the image
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
          )
        ),
        child: new Container(
          margin: new EdgeInsets.symmetric(horizontal: 60.0),
          child: new Form(
            key: formKey,
            child: new Column(
              children: <Widget>[
                new Expanded(
                  flex: 1,
                  child: imageLogo(),
                ),
                new Expanded(
                  flex: 2,
                  child: inputContainer(),
                ),
                new Expanded(
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
    return new Container(
      margin: new EdgeInsets.only(top: 50.0, bottom: 10.0),
      child: new Image.asset('images/logo.png'),
    );
  }

  Widget inputContainer() {
    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          emailForm(),
          passwordForm(),
          new Column(
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
    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          socialMedia(),
          signUp(),
        ],
      ),
    );
  }

  Widget emailForm() {
    return new Container(
      //form background
      decoration: new BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.1),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: new TextFormField(
        //ux support button
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(textSecondFocusNode);
        },
        //keyboard style
        keyboardType: TextInputType.emailAddress,
        //typed text color
        style: new TextStyle(
          color: Colors.white
        ),
        decoration: new InputDecoration(
          //icon style
          prefixIcon: new Padding(
            padding: new EdgeInsetsDirectional.only(end: 10.0),
            child: new Icon(
              Icons.mail,
              color: Colors.white
            ),
          ),
          //general text and style
          labelText: 'Email',
          labelStyle: new TextStyle(
            color: Colors.white,
          ),
          //help text and style
          hintText: 'Type your Email',
          hintStyle: new TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.4),
            fontSize: 13.0
          ),
          //sub line
          border: InputBorder.none,
          //interior padding
          contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 35.0, 10.0),
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
    return new Container(
      decoration: new BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.1),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: new TextFormField(
        focusNode: textSecondFocusNode,
        //hide text
        obscureText: true,
        keyboardType: TextInputType.text,
        style: new TextStyle(
          color: Colors.white
        ),
        decoration: new InputDecoration(
          prefixIcon: new Padding(
            padding: new EdgeInsetsDirectional.only(end: 10.0),
            child: new Icon(Icons.lock, color: Colors.white),
          ),
          labelText: 'Password',
          labelStyle: new TextStyle(
            color: Colors.white,
          ),
          hintText: 'Type your Password',
          hintStyle: new TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.4),
            fontSize: 13.0
          ),
          border: InputBorder.none,
          contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 35.0, 10.0),
        ),
        validator: validatePassword,
        onSaved: (String value) {
          password = value;
        },
      ),
    );
  }

  Widget loginButton() {
    return new Container(
      height: 48.0,
      //sets the width size to "infinity"
      width: double.infinity,
      //gradient background
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [
            Color.fromRGBO(255, 7, 105, 1.0),
            Color.fromRGBO(182, 2, 74, 1.0),
          ],
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter
        ),
        borderRadius: BorderRadius.circular(25.0)
      ),
      child: new FlatButton(
        shape: new RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: new Text(
          'Sign In',
          style: new TextStyle(
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
              content: new Text('Email: $email | Pass: $password'),
              action: new SnackBarAction(
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
    return new Container(
      child: new FlatButton(
        //sets all presses to be transparent
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: new Text(
          'Forgot Password?',
          style: new TextStyle(
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
    return new Container(
      child: new Row(
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
    return new Container(
      child: new FlatButton(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: new Text(
          'Not a member yet? Register Here.',
          style: new TextStyle(
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