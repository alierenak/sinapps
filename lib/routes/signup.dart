import 'package:sinapps/routes/setProfile.dart';
import 'package:sinapps/utils/colors.dart';
import 'package:sinapps/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'TR';
  PhoneNumber number = PhoneNumber(isoCode: 'TR');

  String pass;
  String pass2;

  final _formKey = GlobalKey<FormState>();

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

      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        title: Text(
          '',
          style: kAppBarTitleTextStyle,
        ),
        //backgroundColor: AppColors.secondary,
        backgroundColor: Colors.grey[700],
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
                            radius: 80.0,
                          ),
                        ],
                    ),
                    SizedBox(height: 28.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InternationalPhoneNumberInput(onInputChanged: (PhoneNumber number) {
                              print(number.phoneNumber);
                              },
                              onInputValidated: (bool value) {
                              print(value);
                              },
                              selectorConfig: SelectorConfig(
                                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                              ),
                              ignoreBlank: false,
                              autoFocus: true,
                              autoValidateMode: AutovalidateMode.disabled,
                              selectorTextStyle: TextStyle(color: AppColors.textColor),
                              initialValue: number,
                              textFieldController: controller,
                              formatInput: false,
                              inputDecoration: InputDecoration(
                                contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                fillColor: AppColors.captionColor,
                                filled: true,
                                hintText: 'Phone Number',
                                labelStyle: kLabelLightTextStyle,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                ),
                              ),
                            searchBoxDecoration: InputDecoration(
                              contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                              fillColor: AppColors.captionColor,
                              filled: true,
                              hintText: 'Search by country name or dial code',
                              labelStyle: kLabelLightTextStyle,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                              onSaved: (PhoneNumber number) {
                                print('On Saved: $number');
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
                          width: 150.0,
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
                            onPressed: () async {

                              if(_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                if (pass != pass2) {
                                  showAlertDialog("Action", 'Passwords are different');
                                }
                                else {
                                  // Future<bool> isRegistered = register(fullname, mail, username, pass);
                                }

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(content: Text('Signing in')));
                                  var credentials = await Navigator.push(context, MaterialPageRoute(builder: (context) => Setprofile()));
                                  print(credentials);
                                  //create acc from firebase
                                  Navigator.pop(context);
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
