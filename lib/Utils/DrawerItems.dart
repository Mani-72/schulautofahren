import 'package:flutter/material.dart';

import 'ClickableText.dart';

class DrawerItems extends StatelessWidget {
  Divider applyDivider() {
    return Divider(
      color: Colors.teal,
      height: 15,
      thickness: 2,
      indent: 10,
      endIndent: 10,
    );
  }

  final String uid;
  final Map<String, dynamic> userMap;
  DrawerItems(this.uid, this.userMap);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 350,
      ),
      body: ListView(
        children: <Widget>[
          applyDivider(),
          ClickableText("Edit Account Details", context, uid, userMap),
          applyDivider(),
          ClickableText("View Ads", context, uid, userMap),
          applyDivider(),
          ClickableText("Sign Out", context, uid, userMap),
          applyDivider(),
        ],
      ),
    );
  }
}
