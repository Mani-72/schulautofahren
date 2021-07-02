import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectcars/Utils/Buttons.dart';
import 'package:projectcars/Utils/TextFields.dart';

import 'Utils/Loading.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _codeRecieved = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = true;
  bool _isCodeSent = false;

  String dropDownValue = "+49";
  String code, verificationId, phoneNumber;
  String errorMessage = "";
  Widget loading = Loading().createLoading();
  Widget mainScreen(Widget result) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WIR KAUFEN DEIN FAHRSCHULAUTO"),
        centerTitle: true,
        toolbarOpacity: 0.8,
        toolbarHeight: 40,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Image(
                image: AssetImage("lib/Assets/CarsLogo.png"),
                color: Colors.orange,
                colorBlendMode: BlendMode.saturation,
              ),
            ),
            Expanded(
              flex: 2,
              child: isLoading ? loading : result,
            ),
          ],
        ),
        alignment: Alignment.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_codeRecieved) {
      if (!_isCodeSent) {
        setState(() {
          isLoading = false;
        });
      }
      return mainScreen(ListView(
        children: <Widget>[
          Center(
            child: Text(
              errorMessage,
              textScaleFactor: 1,
              style: TextStyle(
                color: Colors.red,
                height: 2,
                fontSize: 15,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: DropdownButton<String>(
                  value: dropDownValue,
                  style: const TextStyle(color: Colors.orange),
                  onChanged: (String newValue) {
                    setState(() {
                      dropDownValue = newValue;
                    });
                  },
                  items: <String>['+49', '+92']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Expanded(
                flex: 6,
                child: CreateTextField("Geben Sie ihre Nummer ein", "numbers",
                    updateVariables, ""),
              )
            ],
          ),
          SizedBox(height: 50),
          CreateButton(authenticateAndSigninUser, "Code senden", context),
        ],
      ));
    } else {
      setState(() {
        print("false");
        isLoading = false;
      });
      return mainScreen(ListView(
        children: <Widget>[
          Center(
            child: Text(
              errorMessage,
              textScaleFactor: 1,
              style: TextStyle(
                color: Colors.red,
                height: 2,
                fontSize: 15,
              ),
            ),
          ),
          CreateTextField("Code eingeben", "numbers", updateVariables, ""),
          SizedBox(height: 50),
          CreateButton(authorize, "Bestätigen", context),
        ],
      ));
    }
  }

  updateVariables(String labelText, String value) {
    if (labelText == "Geben Sie ihre Nummer ein") phoneNumber = value;
    if (labelText == "Code eingeben") code = value;
  }

  void authorize(BuildContext cont) {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: code);
    auth.signInWithCredential(phoneAuthCredential).then((value) {
      //save value.user.uid
    }).onError((error, stackTrace) {
      setState(() {
        errorMessage = "INVALID CODE";
      });
    });
  }

//Buttons MEthods

  void authenticateAndSigninUser(BuildContext cont) {
    phoneNumber = dropDownValue + phoneNumber;
    print("Sending message to " + phoneNumber);
    _isCodeSent = true;
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        print("Verified");
        auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        setState(() {
          _isCodeSent = false;
          errorMessage = "INVALID NUMBER";
        });
      },
      codeSent: (String verificationId, int resendToken) {
        print("CodeSent!");
        setState(() {
          _codeRecieved = true;
        });
        this.verificationId = verificationId;
        setState(() {
          errorMessage = "";
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    setState(() {
      print("True");
      isLoading = true;
    });
  }

//Sign In On Start

}
