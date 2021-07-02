import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectcars/Routes/HomeScreen.dart';
import 'package:projectcars/Server/Server.dart';
import 'package:projectcars/Utils/Buttons.dart';
import 'package:projectcars/Utils/ClickableText.dart';
import 'package:projectcars/Utils/Loading.dart';

class xxxx extends StatefulWidget {
  final List<String> x;
  final BuildContext xx;
  final User xxx;
  xxxx(this.xx, this.xxx, this.x);
  @override
  State<StatefulWidget> createState() => ViewAdsState(xx, xxx, x);
}

int indexToDelete = -1;
List<Map<String, dynamic>> xxxxxx = new List<Map<String, dynamic>>();

class ViewAdsState extends State<xxxx> {
  final List<String> x;
  final BuildContext xx;
  final User xxx;
  bool noAds = false;
  Widget loading = Loading().createLoading();
  bool isFetching = true;
  ViewAdsState(this.xx, this.xxx, this.x);
  List<String> adsList = new List<String>();

  z server = new z();

  @override
  void initState() {
    zzzzzzzzz();
    indexToDelete = -1;
    super.initState();
  }

  Future<void> zzzzzzzzz() async {
    await server.zzzzzzzz(xxx.uid).then((value) {
      adsList = value;
      if (adsList.isEmpty) {
        print("Empty!");
        setState(() {
          noAds = true;
        });
      } else {
        server.zzzzzzzzz(adsList).then((value) {
          xxxxxx = value;
          convertListOfMApsToListOfStrings();
          isFetching = false;
        }).onError((error, stackTrace) {
          print(error);
        });
      }
    });
  }

  void convertListOfMApsToListOfStrings() {
    String temp;
    adsDataConverted = new List<String>();
    for (int i = 0; i < xxxxxx.length; i++) {
      temp = "Ad ID: \t\t" + //
          xxxxxx[i]['Ad ID'] +
          "\nAbdabe Datum: \t\t" + //
          xxxxxx[i]['Abdabe Datum'] +
          "\nModel: \t\t" + //
          xxxxxx[i]['Model'] +
          "\nMarke: \t\t" + //
          xxxxxx[i]['Marke'] +
          "\nErstzulassung: \t\t" + //
          xxxxxx[i]['Erstzulassung'] +
          "\nBauform: \t\t" + //
          xxxxxx[i]['Bauform'] +
          "\nModellvariante: \t\t" + //
          xxxxxx[i]['Modellvariante'] +
          "\nTyp: \t\t" + //
          xxxxxx[i]['Typ'] +
          "\nKilometer: \t\t" + //
          xxxxxx[i]['Kilometer'] +
          "\nPries: \t\t" +
          xxxxxx[i]['Pries'] +
          "\nFahrschule/Firma Name: \t\t" + //
          xxxxxx[i]['Fahrschule/Firma Name'] +
          "\nAdresse Str Hr: \t\t" + //
          xxxxxx[i]['Adresse Str Hr'] +
          "\nPLZ: \t\t" + //
          xxxxxx[i]['PLZ'] +
          "\nOrt: \t\t" + //
          xxxxxx[i]['Ort'] +
          "\nTelefon / Handynummer: \t\t" + //
          xxxxxx[i]['Telefon / Handynummer'] +
          "\nEmail: \t\t" + //
          xxxxxx[i]['Email'] +
          "\nAnsprechpartner: \t\t" + //
          xxxxxx[i]['Ansprechpartner'] +
          "\nMehrwersteuer: \t\t" + //
          xxxxxx[i]['Mehrwersteuer'];
      setState(() {
        adsDataConverted.add(temp);
      });
    }
  }

  @override
  Widget build(BuildContext xx) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ihre Anzeigen"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: noAds
          ? Center(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 30,
                    child: Center(
                      child: Text(
                        "Sie haben keine anzeige!",
                        style: TextStyle(
                            color: Colors.orange.shade500,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                        flex: 5,
                        child: CreateButton(goToHome, "zurück", xx),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: InkWell(
                          onTap: delete,
                          child: Icon(Icons.delete),
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ],
              ),
            )
          : isFetching
              ? loading
              : Column(
                  children: <Widget>[
                    Expanded(
                      flex: 30,
                      child: ListView.builder(
                          itemCount: adsDataConverted.length,
                          itemBuilder: (xx, index) =>
                              AdsDataBuild(index, onPressed)),
                    ),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Expanded(
                          flex: 5,
                          child: CreateButton(goToHome, "zurück", xx),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: InkWell(
                            onTap: delete,
                            child: Icon(Icons.delete),
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ],
                ),
    );
  }

  void delete() {
    if (indexToDelete == -1) {
      showCupertinoDialog(
        context: xx,
        builder: (_) => CupertinoAlertDialog(
          title: Text("Ungültige Auswahl"),
          content: Text("Bitte wählen Sie eine zu löschende Anzeige aus"),
          actions: [
            CupertinoDialogAction(
              onPressed: () =>
                  Navigator.of(xx, rootNavigator: true).pop("Discard"),
              child: Text("OK"),
            ),
          ],
        ),
      );
    } else {
      showCupertinoDialog(
        context: xx,
        builder: (_) => CupertinoAlertDialog(
          title: Text("Anzeige löschen"),
          content: Text("Möchten Sie diese Anzeige wirklich löschen?"),
          actions: [
            CupertinoDialogAction(
              onPressed: deleteConfirm,
              child: Text("Ja"),
            ),
            CupertinoDialogAction(
              onPressed: () =>
                  Navigator.of(xx, rootNavigator: true).pop("Discard"),
              child: Text("Nein"),
            ),
          ],
        ),
      );
    }
  }

  void deleteConfirm() {
    server.zzzzzzzzzzzzz(xxxxxx[indexToDelete]['Ad ID']);
    server.zzzzzzzzzzzzzz(xxx.uid, xxxxxx[indexToDelete]['Ad ID']);
    server.zzzzzzzzzzzz(
        xxxxxx[indexToDelete]['Ad ID'], xxxxxx[indexToDelete]['totalImages']);
    Navigator.pushAndRemoveUntil(xx,
        MaterialPageRoute(builder: (xx) => xxxx(xx, xxx, x)), (route) => false);
  }

  void goToHome(BuildContext cont) {
    Navigator.pushAndRemoveUntil(
        xx,
        MaterialPageRoute(builder: (xx) => aaaaaaaaaaaa(xxx, x)),
        (route) => false);
  }

  void onPressed(int index) {
    setState(() {
      indexToDelete = index;
    });
  }
}

List<String> adsDataConverted = new List<String>();

class AdsDataBuild extends StatelessWidget {
  final int index;
  final Function updateData;
  Color col = Colors.orange.shade300;
  AdsDataBuild(this.index, this.updateData);
  @override
  Widget build(BuildContext xx) {
    return Card(
      shadowColor: Colors.blueGrey.shade100,
      elevation: 20,
      margin: EdgeInsets.all(20),
      child: Material(
        color: (indexToDelete == index) ? col : Colors.blueGrey.shade300,
        child: InkWell(
          highlightColor: Colors.white,
          splashColor: Colors.white,
          focusColor: Colors.white,
          onTap: () => updateData(index),
          child: Container(
            padding: EdgeInsets.all(15),
            child: Text(
              adsDataConverted[index],
            ),
          ),
        ),
      ),
    );
  }
}
