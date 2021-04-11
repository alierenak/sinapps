import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_project/utils/colors.dart';
import 'package:flutter_app_project/utils/styles.dart';
import 'package:flutter_app_project/main.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String mail;
  String pass;
  String pass2;
  String username;
  int attemptCount;
  final _formKey = GlobalKey<FormState>();
  Future<void> signUpUser() async {
    final url = Uri.parse('http://altop.co/cs310/api.php');
    var body = {
      'call': 'signup',
      'mail': mail,
      'pass': pass,
      'username': username
    };
    final response = await http.post(
      Uri.http(url.authority, url.path),
      headers: <String, String> {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
      },
      body: body,
      encoding: Encoding.getByName("utf-8"),
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      //Successful transmission
      Map<String, dynamic> jsonMap = json.decode(response.body);

      for (var entry in jsonMap.entries) {
        print('Key: ' +entry.key);
        print('Value: ' +entry.value);
      }
    }
    else {
      print(response.statusCode);
    }
  }
  Future<void> showAlertDialog(String title, String message) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, //User must tap button
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(message),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        title: Text(
          'hackim',
          style: kAppBarTitleTextStyle,
        ),
        backgroundColor: AppColors.secondary,
        centerTitle: true,
        elevation: 0.0,
      ),
      body:SingleChildScrollView(
        child: Container(
          //flex: 1,
          margin: EdgeInsets.all(25.0),
          padding: EdgeInsets.all(15.0),

          decoration: BoxDecoration(
            color: Colors.white,
            //border: Border.all(width: 6),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Form(
                key: _formKey,
                child: Column(
                  children: <Widget> [
                    CircleAvatar(
                      backgroundImage: AssetImage('lib/assets/PHOTO-2021-04-10-22-54-09.jpg'),
                      radius: 80.0,
                    ),
                    SizedBox(height: 16.0),

                    RichText(
                        text: TextSpan(
                            text: "Log In",
                            style: TextStyle(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w900,
                              fontSize: 30.0,
                              letterSpacing: -0.7,
                            )
                        )
                    ),
                    SizedBox(height: 28.0),

                    TextFormField(
                      decoration: InputDecoration(
                        fillColor: AppColors.captionColor,
                        filled: true,
                        hintText: 'Email or Username',
                        //labelText: 'Username',
                        labelStyle: kButtonLightTextStyle,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                      ),

                      keyboardType: TextInputType.emailAddress,

                      validator: (value) {
                        if(value.isEmpty) { //if empty
                          return 'Please enter your e-mail/username';
                        }

                        if (value.contains('@')) { //email
                          if (!EmailValidator.validate(value)) {
                            return 'The e-mail address is not valid';
                          }
                        }
                        else { //username
                          if(value.length < 4) {
                            return 'Username is too short';
                          }
                        }
                        return null;
                      },


                      onSaved: (String value) {
                        username = value;
                      },
                    ),

                    SizedBox(height: 16.0),

                    TextFormField(
                      decoration: InputDecoration(
                        fillColor: AppColors.captionColor,
                        filled: true,
                        hintText: 'Password',
                        //labelText: 'Username',
                        labelStyle: kButtonLightTextStyle,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,

                      validator: (value) {
                        if(value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if(value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        pass = value;
                      },
                    ),
                    SizedBox(width: 8.0,),

                    SizedBox(height: 8,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: <Widget>[
                        Container(
                          //padding: const EdgeInsets.symmetric(vertical: 2.0),
                          //margin: const EdgeInsets.symmetric(horizontal: 0.0),
                          height: 50.0,
                          width: 200.0,
                          child: OutlinedButton(
                            //margin: const EdgeInsets.symmetric(horizontal: 0.0),
                            //width:0.8,
                            style: OutlinedButton.styleFrom(
                              backgroundColor: AppColors.secondary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              side: BorderSide(width: 2, color: AppColors.secondary),
                            ),
                            onPressed: () {

                              if(_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                if (pass != pass2) {
                                  showAlertDialog("Action", 'Passwords are different');
                                }
                                else {
                                  signUpUser();
                                }
                                //showAlertDialog("Action", 'Button clicked');
                                setState(() {
                                  attemptCount += 1;
                                });

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(content: Text('Logging in')));
                              }

                            },

                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0),

                              child: Text(
                                'Log-In',
                                style: kButtonLightTextStyle,
                              ),
                            ),
                            //style: OutlinedButton.styleFrom(
                            //backgroundColor: AppColors.secondary,
                            //),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
