import 'dart:async';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:sinapps/routes/setProfile.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sinapps/utils/colors.dart';
import 'package:sinapps/utils/helpers.dart';
import 'package:sinapps/utils/styles.dart';
import 'package:sinapps/routes/bottomNavBar.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';


class Login extends StatefulWidget {
  const Login({Key key, this.analytics, this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _LoginState createState() => _LoginState();
}

enum MobileVerificationState { PHONE_VIEW_STATE, CODE_VIEW_STATE }

class _LoginState extends State<Login> {
  PhoneNumber number = PhoneNumber(isoCode: 'TR');
  MobileVerificationState currentState =
      MobileVerificationState.PHONE_VIEW_STATE;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldGlobalKey = GlobalKey<ScaffoldState>();
  String userPhone;
  String authCode;
  String verificationID;

  bool isLoading = false;
  bool hasError = false;
  String errorMessage = "";
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  final phoneViewController = TextEditingController();
  final codeViewController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  void signIn(PhoneAuthCredential authCredential) async {
    try {
      final credential = await _auth.signInWithCredential(authCredential);
      if (credential?.user != null) {

        FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;
        crashlytics.log(userPhone);
        FirebaseAnalytics().logEvent(name: 'LoginSuccessful', parameters: null);

        var result = await FirebaseFirestore.instance
            .collection('users')
            .where('phoneNumber', isEqualTo: userPhone)
            .get();
        if (result.size == 0) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Setprofile()));
        } else if (result.docs[0]['activation'] == "deactivated"){
          FirebaseFirestore.instance
              .collection('users')
              .doc(result.docs[0]['uid'])
              .update({
            "activation": "active",
          });

          var postAct = await FirebaseFirestore.instance
              .collection('posts')
              .where('userid', isEqualTo: result.docs[0]['uid'])
              .get();

          postAct.docs.forEach((doc) => {
            FirebaseFirestore.instance
                .collection('posts')
                .doc(doc['pid'])
                .update({
                  "activation": "active",
            })
          });


          Navigator.push(
              context, MaterialPageRoute(builder: (context) => BottomBar()));


          SnackBar successSnackBar =
          SnackBar(content: Text("Profile has been activated."));
          _scaffoldGlobalKey.currentState.showSnackBar(successSnackBar);

        }

        else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => BottomBar()));
        }

        //Navigator.push(context, MaterialPageRoute(builder: (context) => BottomBar()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        FirebaseAnalytics().logEvent(name: 'LoginFailed', parameters: null);
        hasError = true;
        errorMessage = "Something went wrong!";
        FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;
        crashlytics.setUserIdentifier(userPhone);
        crashlytics.setCustomKey("error message:", e);
      });
    }
  }

  phoneNumberView(context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        title: Text(
          '',
          style: kAppBarTitleTextStyle,
        ),
        backgroundColor: Colors.grey[700],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(40.0),
          padding: EdgeInsets.all(25.0),
          decoration: BoxDecoration(
            color: Colors.white,
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
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: AssetImage('lib/images/logo.png'),
                        radius: 100.0,
                      ),
                      SizedBox(height: 12.0),
                      InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {},
                        onInputValidated: (bool value) {},
                        selectorConfig: SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        ),
                        ignoreBlank: false,
                        autoFocus: true,
                        autoValidateMode: AutovalidateMode.disabled,
                        selectorTextStyle:
                            TextStyle(color: AppColors.textColor),
                        initialValue: number,
                        textFieldController: phoneViewController,
                        formatInput: false,
                        inputDecoration: InputDecoration(
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          fillColor: AppColors.captionColor,
                          filled: true,
                          hintText: 'Phone Number',
                          labelStyle: kLabelLightTextStyle,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                        ),
                        searchBoxDecoration: InputDecoration(
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          fillColor: AppColors.captionColor,
                          filled: true,
                          hintText: 'Search by country name or dial code',
                          labelStyle: kLabelLightTextStyle,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        onSaved: (PhoneNumber number) {
                          userPhone = number.phoneNumber;
                        },
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 50.0,
                            width: 150.0,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.grey[800],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                side: BorderSide(
                                    width: 2, color: Colors.grey[800]),
                              ),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();

                                  _auth.verifyPhoneNumber(
                                    phoneNumber: userPhone,
                                    verificationCompleted:
                                        (PhoneAuthCredential credential) async {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    },
                                    verificationFailed: (FirebaseAuthException
                                        verificationFailed) async {
                                      _scaffoldKey.currentState.showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  verificationFailed.message)));
                                      setState(() {
                                        isLoading = false;
                                      });
                                    },
                                    codeSent:
                                        (verificationID, resendingToken) async {
                                      setState(() {
                                        isLoading = false;
                                        currentState = MobileVerificationState
                                            .CODE_VIEW_STATE;
                                        this.verificationID = verificationID;
                                      });
                                    },
                                    codeAutoRetrievalTimeout:
                                        (verificationID) async {},
                                  );
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => BottomBar()));
                                }
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  'Log-In',
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
                  )),
            ],
          ),
        ),
      ),
    );
  }

  // snackBar Widget
  snackBar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  authCodeView(context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {},
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: RichText(
                  text: TextSpan(
                      text: "We have sent code to ",
                      children: [
                        TextSpan(
                            text: "${this.userPhone}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ],
                      style: TextStyle(color: Colors.black54, fontSize: 15)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 40),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      pinTheme: PinTheme(
                          activeColor: AppColors.primary,
                          selectedColor: Colors.grey[800],
                          inactiveColor: Colors.grey[800]),
                      length: 6,
                      //blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      cursorColor: Colors.black,
                      animationDuration: Duration(milliseconds: 100),
                      errorAnimationController: errorController,
                      controller: codeViewController,
                      keyboardType: TextInputType.number,
                      onCompleted: (v) {
                        print("Completed");
                      },
                      onTap: () {
                        print("Pressed");
                      },
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          authCode = value;
                        });
                      },
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        hasError ? errorMessage : "",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Flexible(
                        child: TextButton(
                      child: Text("Clear"),
                      onPressed: () {
                        codeViewController.clear();
                      },
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                child: ButtonTheme(
                  height: 50,
                  child: TextButton(
                    onPressed: () {
                      _formKey.currentState.validate();
                      // conditions for validating
                      if (authCode.length != 6) {
                        errorController.add(ErrorAnimationType
                            .shake); // Triggering error shake animation
                        setState(() {
                          hasError = true;
                          errorMessage = "*There should be 6 digit.";
                        });
                      } else if (!isNumeric(authCode)) {
                        errorController.add(ErrorAnimationType
                            .shake); // Triggering error shake animation
                        setState(() {
                          hasError = true;
                          errorMessage = "*Only numeric values are accepted!";
                        });
                      } else {
                        setState(
                          () {
                            hasError = false;
                            PhoneAuthCredential phoneAuthCredential =
                                PhoneAuthProvider.credential(
                                    verificationId: verificationID,
                                    smsCode: authCode);
                            signIn(phoneAuthCredential);
                          },
                        );
                      }
                    },
                    child: Center(
                        child: Text(
                      "VERIFY".toUpperCase(),
                      style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                decoration: BoxDecoration(
                  color: AppColors.textColor,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Enter wrong number? ",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 14),
                            ),
                            TextButton(
                                onPressed: () => {
                                      setState(() {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Login()));
                                      })
                                    },
                                child: Text(
                                  "CHANGE",
                                  style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Didn't receive the code? ",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 14),
                            ),
                            TextButton(
                                onPressed: () => {
                                      _auth.verifyPhoneNumber(
                                        phoneNumber: userPhone,
                                        verificationCompleted:
                                            (authCredential) async {
                                          setState(() {
                                            isLoading = false;
                                          });
                                        },
                                        verificationFailed:
                                            (verificationFailed) async {
                                          _scaffoldKey.currentState
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      verificationFailed
                                                          .message)));
                                          setState(() {
                                            isLoading = false;
                                          });
                                        },
                                        codeSent: (verificationID,
                                            resendingToken) async {
                                          setState(() {
                                            isLoading = false;
                                            currentState =
                                                MobileVerificationState
                                                    .CODE_VIEW_STATE;
                                            this.verificationID =
                                                verificationID;
                                          });
                                        },
                                        codeAutoRetrievalTimeout:
                                            (verificationID) async {},
                                      )
                                    },
                                child: Text(
                                  "RESEND",
                                  style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ))
                          ],
                        ),
                      ])),
            ],
          ),
        ),
      ),
    );

    /*
    return Column(
      children: <Widget> [

                TextFormField(
              decoration: InputDecoration(
                fillColor: AppColors.captionColor,
                filled: true,
                hintText: 'Verication Code',
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
              controller: codeViewController,
              onSaved: (String value) {
                authCode = value;
           },
        ),

        SizedBox(height: 30.0,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              //padding: const EdgeInsets.symmetric(vertical: 2.0),
              //margin: const EdgeInsets.symmetric(horizontal: 0.0),
              height: 50.0,
              width: 150.0,
              child: OutlinedButton(
                //margin: const EdgeInsets.symmetric(horizontal: 0.0),
                //width:0.8,
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  side: BorderSide(width: 2, color: Colors.grey[800]),
                ),
                onPressed: () {
                  PhoneAuthCredential authCredential = PhoneAuthProvider.credential(verificationId: verificationID, smsCode: codeViewController.text);
                  signIn(authCredential);

                  Navigator.push(context, MaterialPageRoute(builder: (context) => BottomBar()));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'VERIFY',
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
    );
     */
  }

  loadingView(context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        title: Text(
          '',
          style: kAppBarTitleTextStyle,
        ),
        backgroundColor: Colors.grey[700],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(40.0),
          padding: EdgeInsets.all(25.0),
          decoration: BoxDecoration(
            color: Colors.white,
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
                  child: Center(
                      heightFactor: 10, child: CircularProgressIndicator())),
            ],
          ),
        ),
      ),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? loadingView(context)
        : currentState == MobileVerificationState.PHONE_VIEW_STATE
            ? phoneNumberView(context)
            : authCodeView(context);
  }
}
