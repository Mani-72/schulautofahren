import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectcars/Routes/EditAccountDetailsRoute.dart';
import 'package:projectcars/Routes/ViewAds.dart';

import '../OldMain.dart';

class ClickableText extends StatelessWidget {
  final String text;
  final BuildContext cont;
  final String uid;
  final Map<String, dynamic> userMap;
  ClickableText(this.text, this.cont, this.uid, this.userMap);

  Future<void> navigate(BuildContext context) async {
    switch (text) {
      case "Edit Account Details":
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>
        //             EditAccountDetailsRoute(context, uid, false, userMap)));
        break;
      case "View Ads":
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => ViewAds(context, uid)));
        break;
      case "Sign Out":
        // await FirebaseAuth.instance.signOut();
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => MyApp()));
        break;
      default:
        break;
    }
  }

  Icon getIcon(String type) {
    switch (type) {
      case "Edit Account Details":
        return Icon(Icons.edit);
      case "View Ads":
        return Icon(Icons.view_carousel);
      case "Sign Out":
        return Icon(Icons.logout);
      default:
        return Icon(Icons.touch_app);
    }
  }

  Container getText(String type, BuildContext cont) {
    return Container(
      child: Text(
        type,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigate(context);
      },
      child: Row(
        children: <Widget>[
          getIcon(text),
          Flexible(child: getText(text, context)),
        ],
      ),
    );
  }
}
