import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectcars/Routes/HomeScreen.dart';
import 'package:projectcars/Server/Server.dart';
import 'package:projectcars/Utils/Buttons.dart';
import 'package:projectcars/Utils/TextFields.dart';

class aaaaaa extends StatelessWidget {
  final List<String> aaaaaaa;
  final bool aaaaaaaa;
  final Map<String, dynamic> aaaaaaaaa;
  final BuildContext aaaaaaaaaa;
  final User aaaaaaaaaaa;

  z server = new z();
  aaaaaa(this.aaaaaaaaaa, this.aaaaaaaaaaa, this.aaaaaaaa, this.aaaaaaaaa,
      this.aaaaaaa);
  @override
  Widget build(BuildContext aaaaaaaaaa) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Kontodetails"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 10,
              child: ListView(
                children: <Widget>[
                  CreateTextField("Fahrschule/Firma Name", "alphaNumeric",
                      aaaaaaaaaaaab, aaaaaaaaa['Fahrschule/Firma Name']),
                  SizedBox(height: 10),
                  CreateTextField("Adresse Str Hr", "alphaNumeric",
                      aaaaaaaaaaaab, aaaaaaaaa['Adresse Str Hr']),
                  SizedBox(height: 10),
                  Row(children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: CreateTextField("PLZ", "alphaNumeric",
                          aaaaaaaaaaaab, aaaaaaaaa['PLZ']),
                    ),
                    Flexible(
                      flex: 1,
                      child: CreateTextField("Ort", "alphaNumeric",
                          aaaaaaaaaaaab, aaaaaaaaa['Ort']),
                    ),
                  ]),
                  SizedBox(height: 10),
                  CreateTextField("Telefon / Handynummer", "alphaNumeric",
                      aaaaaaaaaaaab, aaaaaaaaa['Telefon / Handynummer']),
                  SizedBox(height: 10),
                  CreateTextField("Email", "alphaNumeric", aaaaaaaaaaaab,
                      aaaaaaaaa['Email']),
                  SizedBox(height: 10),
                  CreateTextField("Ansprechpartner", "alphaNumeric",
                      aaaaaaaaaaaab, aaaaaaaaa['Ansprechpartner']),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 10),
                Expanded(child: CreateButton(goToHome, "zurück", aaaaaaaaaa)),
                SizedBox(width: 10),
                Expanded(
                    child:
                        CreateButton(onSubmitPressed, "speichern", aaaaaaaaaa)),
                SizedBox(width: 10),
              ],
            )
          ],
        ),
      ),
    );
  }

  void goToHome(BuildContext cont) {
    Navigator.pushAndRemoveUntil(
        aaaaaaaaaa,
        MaterialPageRoute(
            builder: (aaaaaaaaaa) => aaaaaaaaaaaa(aaaaaaaaaaa, aaaaaaa)),
        (route) => false);
  }

  Future<void> onSubmitPressed(BuildContext cont) async {
    if (allFieldsFilled()) {
      await server.zz(aaaaaaaaaaa.uid, aaaaaaaaa);
      Navigator.pushAndRemoveUntil(
          aaaaaaaaaa,
          MaterialPageRoute(
              builder: (aaaaaaaaaa) => aaaaaaaaaaaa(aaaaaaaaaaa, aaaaaaa)),
          (route) => false);
    } else {
      Scaffold.of(cont).showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: Text(
          "Alle Felder sind erforderlich!",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ));
    }
  }

  bool allFieldsFilled() {
    if ((aaaaaaaaa['Fahrschule/Firma Name'] == null) ||
        (aaaaaaaaa['Adresse Str Hr'] == null) ||
        (aaaaaaaaa['PLZ'] == null) ||
        (aaaaaaaaa['Ort'] == null) ||
        (aaaaaaaaa['Telefon / Handynummer'] == null) ||
        (aaaaaaaaa['Email'] == null) ||
        (aaaaaaaaa['Ansprechpartner'] == null) ||
        (aaaaaaaaa['Fahrschule/Firma Name'] == "") ||
        (aaaaaaaaa['Adresse Str Hr'] == "") ||
        (aaaaaaaaa['PLZ'] == "") ||
        (aaaaaaaaa['Ort'] == "") ||
        (aaaaaaaaa['Telefon / Handynummer'] == "") ||
        (aaaaaaaaa['Email'] == "") ||
        (aaaaaaaaa['Ansprechpartner'] == "")) {
      return false;
    } else
      return true;
  }

  aaaaaaaaaaaab(String labelText, String value) {
    if (labelText == "Fahrschule/Firma Name")
      aaaaaaaaa['Fahrschule/Firma Name'] = value;
    if (labelText == "Adresse Str Hr") aaaaaaaaa['Adresse Str Hr'] = value;
    if (labelText == "PLZ") aaaaaaaaa['PLZ'] = value;
    if (labelText == "Ort") aaaaaaaaa['Ort'] = value;
    if (labelText == "Telefon / Handynummer")
      aaaaaaaaa['Telefon / Handynummer'] = value;
    if (labelText == "Email") aaaaaaaaa['Email'] = value;
    if (labelText == "Ansprechpartner") aaaaaaaaa['Ansprechpartner'] = value;
  }
}
