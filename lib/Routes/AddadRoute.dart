import 'dart:io';
import 'package:date_field/date_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:projectcars/Routes/HomeScreen.dart';
import 'package:projectcars/Server/Server.dart';
import 'package:projectcars/Utils/ButtonForImageReduceJugaar.dart';
import 'package:projectcars/Utils/Buttons.dart';
import 'package:projectcars/Utils/TextFields.dart';

class aaaa extends StatefulWidget {
  final List<String> aa;
  final User a;
  final Map<String, dynamic> aaa;
  aaaa(this.a, this.aaa, this.aa);
  @override
  State<StatefulWidget> createState() => aaaaa(a, DateTime.now(), aaa, aa);
}

String convertDateTimeDisplay(String date) {
  final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
  final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
  final DateTime displayDate = displayFormater.parse(date);
  final String formatted = serverFormater.format(displayDate);
  return formatted;
}

enum RadioEnum { Ja, Nein }

class aaaaa extends State<aaaa> {
  final List<String> aa;
  Map<String, dynamic> aaa = Map<String, dynamic>();
  final Map<String, dynamic> userMapUserOnly;
  int screenNumber = 1;
  TextEditingController _editingController;
  List<bool> _isEditingText = new List<bool>();
  List<String> initialText = new List<String>();
  final User a;
  List<File> images = new List<File>();
  DateTime userSelectedDate;
  aaaaa(this.a, this.userSelectedDate, this.userMapUserOnly, this.aa);
  RadioEnum radioEnum = RadioEnum.Ja;
  z server = new z();
  double percentFiller = 0;
  Widget reduce;

  @override
  void initState() {
    aaa = userMapUserOnly;
    _editingController = TextEditingController(text: "bild");
    aaa['Abdabe Datum'] = convertDateTimeDisplay(DateTime.now().toString());
    aaa['Mehrwersteuer'] = "Ja";
    addImage(context);
    addImage(context);
    addImage(context);
    addImage(context);
    super.initState();
  }

//Screens LAyout
  Widget firstScreen() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                SizedBox(height: 10),
                CreateTextField(
                    "Marke", "alphaNumeric", updateVariables, aaa['Marke']),
                SizedBox(height: 10),
                CreateTextField(
                    "Model", "alphaNumeric", updateVariables, aaa['Model']),
                SizedBox(height: 10),
                CreateTextField("Erstzulassung", "alphaNumeric",
                    updateVariables, aaa['Erstzulassung']),
                SizedBox(height: 10),
                CreateTextField(
                    "Bauform", "alphaNumeric", updateVariables, aaa['Bauform']),
                SizedBox(height: 10),
                CreateTextField("Modellvariante", "alphaNumeric",
                    updateVariables, aaa['Modellvariante']),
                SizedBox(height: 10),
                CreateTextField(
                    "Typ", "alphaNumeric", updateVariables, aaa['Typ']),
                SizedBox(height: 10),
                CreateTextField("Kilometer", "alphaNumeric", updateVariables,
                    aaa['Kilometer']),
                SizedBox(height: 10),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              SizedBox(width: 10),
              Expanded(child: CreateButton(goToHome, "zurück", context)),
              SizedBox(width: 10),
              Expanded(child: CreateButton(nextScreen, "Weiter", context)),
              SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }

  Widget secondScreen() {
    return Expanded(
      child: Material(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return imagePlaceHolder(index);
                },
              ),
            ),
            Row(
              children: <Widget>[
                if (images.length > 4) SizedBox(width: 10),
                if (images.length > 4)
                  Expanded(
                    child: reduce,
                  ),
                SizedBox(width: 10),
                Expanded(
                  child: CreateButton(addImage, "mehr Bilder", context),
                ),
                SizedBox(width: 10),
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 10),
                Expanded(
                  child: CreateButton(previousScreen, "zurück", context),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CreateButton(nextScreen, "Weiter", context),
                ),
                SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void removeImage(BuildContext context) {
    setState(() {
      images.removeLast();
      initialText.removeLast();
      _isEditingText.removeLast();
    });
  }

  void addImage(BuildContext context) {
    setState(() {
      images.add(null);
      initialText.add("Bild " + (images.length).toString());
      _isEditingText.add(false);
      if (images.length > 4)
        reduce =
            new CreateButtonJugaar(removeImage, "Bilder reduzieren", context);
    });
  }

  Widget thirdScreen() {
    return Expanded(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                SizedBox(height: 20),
                CreateTextField(
                    "Pries", "alphaNumeric", updateVariables, aaa['Pries']),
                SizedBox(height: 20),
                Card(
                  color: Colors.blueGrey.shade300,
                  shadowColor: Colors.blueGrey.shade100,
                  elevation: 10,
                  child: DateField(
                    label: "Abdabe Datum",
                    onDateSelected: (DateTime value) {
                      setState(() {
                        userSelectedDate = value;
                        aaa['Abdabe Datum'] =
                            convertDateTimeDisplay(value.toString());
                      });
                    },
                    selectedDate: userSelectedDate,
                  ),
                ),
                SizedBox(height: 10),
                Card(
                  color: Colors.blueGrey.shade300,
                  shadowColor: Colors.blueGrey.shade100,
                  elevation: 20,
                  child: Column(
                    children: <Widget>[
                      Text("Mehrwersteuer",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w800)),
                      ListTile(
                        title: const Text('Ja'),
                        leading: Radio<RadioEnum>(
                          value: RadioEnum.Ja,
                          groupValue: radioEnum,
                          onChanged: (value) {
                            setState(() {
                              aaa['Mehrwersteuer'] = "Ja";
                              radioEnum = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Nein'),
                        leading: Radio<RadioEnum>(
                          value: RadioEnum.Nein,
                          groupValue: radioEnum,
                          onChanged: (value) {
                            setState(() {
                              aaa['Mehrwersteuer'] = "Nein";
                              radioEnum = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              SizedBox(width: 10),
              Expanded(child: CreateButton(previousScreen, "zurück", context)),
              SizedBox(width: 10),
              Expanded(child: CreateButton(nextScreen, "Weiter", context)),
              SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }

  Widget fourthScreen() {
    return Expanded(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                SizedBox(height: 20),
                CreateTextField("Fahrschule/Firma Name", "alphaNumeric",
                    updateVariables, userMapUserOnly['Fahrschule/Firma Name']),
                SizedBox(height: 20),
                CreateTextField("Adresse Str Hr", "alphaNumeric",
                    updateVariables, userMapUserOnly['Adresse Str Hr']),
                SizedBox(height: 20),
                Row(children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: CreateTextField("PLZ", "alphaNumeric",
                        updateVariables, userMapUserOnly['PLZ']),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 2,
                    child: CreateTextField("Ort", "alphaNumeric",
                        updateVariables, userMapUserOnly['Ort']),
                  ),
                ]),
                SizedBox(height: 20),
                CreateTextField("Telefon / Handynummer", "alphaNumeric",
                    updateVariables, userMapUserOnly['Telefon / Handynummer']),
                SizedBox(height: 20),
                CreateTextField("Email", "alphaNumeric", updateVariables,
                    userMapUserOnly['Email']),
                SizedBox(height: 20),
                CreateTextField("Ansprechpartner", "alphaNumeric",
                    updateVariables, userMapUserOnly['Ansprechpartner']),
                SizedBox(height: 20),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              SizedBox(width: 10),
              Expanded(child: CreateButton(previousScreen, "zurück", context)),
              SizedBox(width: 10),
              Expanded(
                  child: CreateButtonStateFul(
                      uploadDataAndGoToMainScreen, "Absenden", context)),
              SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }

  //////
  Future<void> uploadDataAndGoToMainScreen(BuildContext cont) async {
    String adId;
    print(adId);
    if ((aaa['Fahrschule/Firma Name'] == null) ||
        (aaa['Adresse Str Hr'] == null) ||
        (aaa['PLZ'] == null) ||
        (aaa['Ort'] == null) ||
        (aaa['Telefon / Handynummer'] == null) ||
        (aaa['Email'] == null) ||
        (aaa['Ansprechpartner'] == null) ||
        (aaa['Fahrschule/Firma Name'] == "") ||
        (aaa['Adresse Str Hr'] == "") ||
        (aaa['PLZ'] == "") ||
        (aaa['Ort'] == "") ||
        (aaa['Telefon / Handynummer'] == "") ||
        (aaa['Email'] == "") ||
        (aaa['Ansprechpartner'] == "")) {
      Scaffold.of(cont).showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: Text(
          "alle Felder sind erforderlich!",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ));
    } else {
      aaa['New'] = "true";
      aaa['totalImages'] = images.length;
      aaa['userID'] = a.uid;
      await server.zzzz(aaa).then((value) {
        adId = value;

        for (int i = 0; i < images.length; i++) {
          server.zzzzzz(images[i], adId, "image" + i.toString());
          server.zzzzz(adId, i.toString() + initialText[i]);
        }
        server.zzzzzzz(a.uid, adId);
        for (int i = 0; i < aa.length; i++) {
          print(aa[i]);
          server.zzzzzzzzzz(aa[i]);
        }
      });
      Scaffold.of(cont)
          .showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            content: Text(
              "Anzeige eingereicht",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ))
          .closed
          .then((value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => aaaaaaaaaaaa(a, aa)),
            (route) => false);
      });
    }
  }

  void goToHome(BuildContext cont) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => aaaaaaaaaaaa(a, aa)),
        (route) => false);
  }

  /////Screens Controls
  void nextScreen(BuildContext cont) {
    switch (screenNumber) {
      case 1:
        if (aaa['Marke'] == null ||
            aaa['Model'] == null ||
            aaa['Erstzulassung'] == null ||
            aaa['Bauform'] == null ||
            aaa['Modellvariante'] == null ||
            aaa['Typ'] == null ||
            aaa['Kilometer'] == null ||
            aaa['Marke'] == "" ||
            aaa['Model'] == "" ||
            aaa['Erstzulassung'] == "" ||
            aaa['Bauform'] == "" ||
            aaa['Modellvariante'] == "" ||
            aaa['Typ'] == "" ||
            aaa['Kilometer'] == "") {
          Scaffold.of(cont).showSnackBar(SnackBar(
            duration: Duration(seconds: 1),
            content: Text(
              "alle Felder sind erforderlich!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ));
        } else {
          setState(() {
            screenNumber++;
            setState(() {
              percentFiller = 0.25 * (screenNumber - 1);
            });
          });
        }
        break;
      case 2:
        bool gotAll = true;
        for (int i = 0; i < images.length; i++) {
          if (images[i] == null) {
            gotAll = false;
          }
        }
        if (!gotAll) {
          Scaffold.of(cont).showSnackBar(SnackBar(
            duration: Duration(seconds: 1),
            content: Text(
              "alle Felder sind erforderlich!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ));
        } else {
          setState(() {
            screenNumber++;
            setState(() {
              percentFiller = 0.25 * (screenNumber - 1);
            });
          });
        }
        break;
      case 3:
        if (aaa['Pries'] == null || aaa['Pries'] == "") {
          Scaffold.of(cont).showSnackBar(SnackBar(
            duration: Duration(seconds: 1),
            content: Text(
              "alle Felder sind erforderlich!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ));
        } else {
          setState(() {
            screenNumber++;
            setState(() {
              percentFiller = 0.25 * (screenNumber - 1);
            });
          });
        }
        break;
    }
  }

  void previousScreen(BuildContext cont) {
    setState(() {
      screenNumber--;
      setState(() {
        percentFiller = 0.25 * (screenNumber - 1);
      });
    });
  }
  ////

  /////Image

  Widget imagePlaceHolder(int index) {
    return GestureDetector(
      onTap: () {
        showPicker(context, index);
      },
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
              width: 0,
            ),
            SizedBox(
              height: 70,
              width: 70,
              child: images[index] != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                        images[index],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: Colors.blueGrey.shade900,
                          borderRadius: BorderRadius.circular(50)),
                      width: 70,
                      height: 70,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
            ),
            SizedBox(
              height: 10,
              width: 0,
            ),
            SizedBox(
              width: 100,
              child: _editTitleTextField(index),
            ),
            SizedBox(
              height: 10,
              width: 0,
            ),
          ],
        ),
      ),
    );
  }

  imageFromCamera(int index) async {
    File image = (await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 25));

    setState(() {
      images[index] = image;
    });
  }

  imageFromGallery(int index) async {
    File image = (await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 25));
    setState(() {
      images[index] = image;
    });
  }

  void showPicker(context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(
                        Icons.photo_library,
                        color: Colors.black,
                      ),
                      title: new Text(
                        'Photo Library',
                        style: TextStyle(color: Colors.black),
                      ),
                      onTap: () {
                        imageFromGallery(index);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(
                      Icons.photo_camera,
                      color: Colors.black,
                    ),
                    title: new Text(
                      'Camera',
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      imageFromCamera(index);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _editTitleTextField(int index) {
    if (_isEditingText[index])
      return Center(
        child: TextField(
          onChanged: (newValue) {
            setState(() {
              print(newValue + index.toString());
              initialText[index] = newValue;
              // _isEditingText[index] = false;
            });
          },
          autofocus: true,
          controller: _editingController,
        ),
      );
    return InkWell(
      onTap: () {
        setState(() {
          for (int i = 0; i < images.length; i++) {
            _isEditingText[i] = false;
          }
          _isEditingText[index] = true;
          _editingController.text = initialText[index];
        });
      },
      child: Center(
        child: Text(
          initialText[index],
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }

  //////////////////////////////
  updateVariables(String labelText, String value) {
    //1
    if (labelText == "Marke") aaa['Marke'] = value;
    if (labelText == "Model") aaa['Model'] = value;
    if (labelText == "Erstzulassung") aaa['Erstzulassung'] = value;
    if (labelText == "Bauform") aaa['Bauform'] = value;
    if (labelText == "Modellvariante") aaa['Modellvariante'] = value;
    if (labelText == "Typ") aaa['Typ'] = value;
    if (labelText == "Kilometer") aaa['Kilometer'] = value;
    //3
    if (labelText == "Pries") aaa['Pries'] = value;
    //4
    if (labelText == "Fahrschule/Firma Name")
      aaa['Fahrschule/Firma Name'] = value;
    if (labelText == "Adresse Str Hr") aaa['Adresse Str Hr'] = value;
    if (labelText == "PLZ") aaa['PLZ'] = value;
    if (labelText == "Ort") aaa['Ort'] = value;
    if (labelText == "Telefon / Handynummer")
      aaa['Telefon / Handynummer'] = value;
    if (labelText == "Email") aaa['Email'] = value;
    if (labelText == "Ansprechpartner") aaa['Ansprechpartner'] = value;
  }

  Widget screenSelectionToDisplay() {
    switch (screenNumber) {
      case 1:
        return firstScreen();
        break;
      case 2:
        return secondScreen();
        break;
      case 3:
        return thirdScreen();
        break;
      case 4:
        return fourthScreen();
        break;
      default:
        return Container(
          child: Text("ERROR"),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              child: LinearPercentIndicator(
                width: MediaQuery.of(context).size.width,
                lineHeight: 20.0,
                percent: percentFiller,
                animation: true,
                animationDuration: 1000,
                backgroundColor: Colors.blueGrey.shade300,
                progressColor: Colors.orange.shade500,
              ),
            ),
            SizedBox(height: 10),
            screenSelectionToDisplay(),
          ],
        ),
      ),
    );
  }
}
