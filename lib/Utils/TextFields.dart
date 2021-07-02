import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateTextField extends StatelessWidget {
  final String labelText;
  final String type;
  final String initialValue;
  final Function updateData;
  final valueSelected = new TextEditingController();
  CreateTextField(
      this.labelText, this.type, this.updateData, this.initialValue);

  TextInputType getKeyboardType() {
    switch (type) {
      case "numbers":
        return TextInputType.number;
      case "alphaNumeric":
        return TextInputType.text;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Material(
        // color: Colors.blueGrey.shade400,
        // borderRadius: BorderRadius.all(Radius.circular(30)),
        // elevation: 5,
        shadowColor: Colors.blueGrey.shade100,
        child: TextField(
          controller: TextEditingController()
            ..text = initialValue == null ? "" : initialValue,
          textAlign: TextAlign.center,
          onChanged: (value) {
            updateData(labelText, value);
          },
          keyboardType: getKeyboardType(),
          decoration: InputDecoration(
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(30)),
            //   borderSide: new BorderSide(color: Colors.orange.shade500),
            // ),
            labelText: labelText,
            // enabledBorder: OutlineInputBorder(
            //     // borderRadius: BorderRadius.all(Radius.circular(30)),
            //     // borderSide: new BorderSide(color: Colors.orange.shade500),
            //     ),
            // focusedBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(30)),
            //   borderSide: new BorderSide(color: Colors.white),
            // ),
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
