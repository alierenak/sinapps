import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_app_project/utils/colors.dart';
import 'package:flutter_app_project/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_project/main.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {
  String mail;
  String pass;
  String pass2;
  String username;
  String fullname;
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
      //resizeToAvoidBottomInset: false,
      //backgroundColor: AppColors.secondary,

      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text(
          'sinapps',
          style: kAppBarTitleTextStyle,
        ),
        //backgroundColor: AppColors.secondary,
        backgroundColor: Colors.grey[800],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child:Container(
          //flex: 1,
          margin: EdgeInsets.all(40.0),
          padding: EdgeInsets.all(25.0),

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
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: AssetImage('lib/images/logo.png'),
                            radius: 60.0,
                          ),
                        ],
                    ),
                    SizedBox(height: 12.0),

                    Row (
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                              text: TextSpan(
                                  text: "Sign Up",
                                  style: TextStyle(
                                    //color: AppColors.secondary,
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w900,
                                    fontSize: 24.0,
                                    letterSpacing: -0.7,
                                  )
                              )
                          )
                        ]
                    ),
                    SizedBox(height: 28.0),

                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            decoration: InputDecoration(
                              contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                              fillColor: AppColors.captionColor,
                              filled: true,
                              hintText: 'Fullname',
                              //labelText: 'Username',
                              labelStyle: kLabelLightTextStyle,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if(value.isEmpty) {
                                return 'Please enter your fullname';
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              fullname = value;
                            },
                          ),
                        ),

                      ],
                    ),

                    SizedBox(height: 12.0),

                    Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextFormField(

                              decoration: InputDecoration(
                                contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                fillColor: AppColors.captionColor,
                                filled: true,
                                hintText: 'E-mail',
                                //labelText: 'Username',
                                labelStyle: kLabelLightTextStyle,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  //borderSide: BorderSide(color: AppColors.captionColor, width:0.0),
                                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,

                              validator: (value) {
                                if(value.isEmpty) {
                                  return 'Please enter your e-mail';
                                }
                                if(!EmailValidator.validate(value)) {
                                  return 'The e-mail address is not valid';
                                }
                                return null;
                              },
                              onSaved: (String value) {
                                mail = value;
                              },
                            ),
                          ),
                        ]
                    ),
                    SizedBox(height: 12.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            decoration: InputDecoration(
                              contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                              fillColor: AppColors.captionColor,
                              filled: true,
                              hintText: 'Username',
                              //labelText: 'Username',
                              labelStyle: kLabelLightTextStyle,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if(value.isEmpty) {
                                return 'Please enter your username';
                              }
                              if(value.length < 4) {
                                return 'Username is too short';
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              username = value;
                            },
                          ),
                        ),

                      ],
                    ),

                    SizedBox(height: 12.0),

                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            decoration: InputDecoration(
                              contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                              fillColor: AppColors.captionColor,
                              filled: true,
                              hintText: 'Password',
                              //labelText: 'Username',
                              labelStyle: kLabelLightTextStyle,
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
                        ),
                        SizedBox(width: 8.0,),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            decoration: InputDecoration(
                              contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                              fillColor: AppColors.captionColor,
                              filled: true,
                              hintText: 'Password (Repeat)',
                              //labelText: 'Username',
                              labelStyle: kLabelLightTextStyle,
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
                              pass2 = value;
                            },
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 30,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: <Widget>[
                        Container(
                          //padding: const EdgeInsets.symmetric(vertical: 2.0),
                          //margin: const EdgeInsets.symmetric(horizontal: 0.0),
                          height: 40.0,
                          width: 200.0,
                          child: OutlinedButton(
                            //margin: const EdgeInsets.symmetric(horizontal: 0.0),
                            //width:0.8,
                            style: OutlinedButton.styleFrom(
                              //backgroundColor: AppColors.secondary,
                              backgroundColor: Colors.grey[800],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              side: BorderSide(width: 2, color: Colors.grey[800]),
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
                              padding: const EdgeInsets.symmetric(vertical: 5.0),

                              child: Text(
                                'Sign-Up',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 20.0,
                                  letterSpacing: 0,
                                ),
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
