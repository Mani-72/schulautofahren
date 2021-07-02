import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectcars/OldMain.dart';
import 'package:projectcars/Routes/AddadRoute.dart';
import 'package:projectcars/Routes/EditAccountDetailsRoute.dart';
import 'package:projectcars/Routes/ViewAds.dart';
import 'package:projectcars/Utils/Loading.dart';
import 'package:projectcars/main.dart';
import '../Server/Server.dart';

class aaaaaaaaaaaa extends StatefulWidget {
  aaaaaaaaaaaa(this.user, this.ownerTokens);
  final User user;
  final List<String> ownerTokens;
  @override
  aaaaaaaaaaaaa createState() => aaaaaaaaaaaaa(user, 2, ownerTokens);
}

// Map<String, dynamic> userMap;

class aaaaaaaaaaaaa extends State<aaaaaaaaaaaa> {
  final List<String> ownerTokens;
  aaaaaaaaaaaaa(this.user, this._selectedIndex, this.ownerTokens);
  bool _fetchingData = true;
  final User user;

  Map<String, dynamic> userMap = new Map<String, dynamic>();
  Widget loading = Loading().createLoading();
  int _selectedIndex;

  z server;
  @override
  void initState() {
    _selectedIndex = 2;
    server = new z();
    checkIfUserDetailsAreThere();
    super.initState();
  }

  checkIfUserDetailsAreThere() async {
    await server.zz(user.uid, userMap);
    userMap = await server.zzz(user.uid);

    setState(() {
      _fetchingData = false;
    });
    if ((userMap['Email'] == null || userMap['Email'] == "") &&
        !user.isAnonymous) {
      setState(() {
        _selectedIndex = 0;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  aaaaaa(context, user, true, userMap, ownerTokens)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _fetchingData ? loading : createBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Edit Account',
            // backgroundColor: Colors.black87,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ad_units),
            label: 'View Ads',
            // backgroundColor: Colors.black87,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            // backgroundColor: Colors.black87,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'New Ad',
            // backgroundColor: Colors.black87,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Sign Out',
            // backgroundColor: Colors.black87,
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.orange.shade500,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        setState(() {
          _selectedIndex = 2;
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    aaaaaa(context, user, false, userMap, ownerTokens)));
        break;
      case 1:
        setState(() {
          _selectedIndex = 2;
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => xxxx(context, user, ownerTokens)));
        break;
      case 2:
        //home
        break;
      case 3:
        if (user.isAnonymous) {
          showCupertinoDialog(
            context: context,
            builder: (_) => CupertinoAlertDialog(
              title: Text("Melden Sie sich mit Ihrer Nummer an"),
              content: Text(
                  "Möchten Sie sich anmelden, um Ihre Anzeigen zu speichern?"),
              actions: [
                CupertinoDialogAction(
                  onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                      (route) => false),
                  child: Text("Ja"),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 2;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                aaaa(user, userMap, ownerTokens)));
                  },
                  child: Text("Nein"),
                ),
              ],
            ),
          );
        } else {
          setState(() {
            _selectedIndex = 2;
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => aaaa(user, userMap, ownerTokens)));
        }
        break;
      case 4:
        showCupertinoDialog(
          context: context,
          builder: (_) => CupertinoAlertDialog(
            title: Text("Ausloggen"),
            content: Text("Möchten Sie sich abmelden?"),
            actions: [
              CupertinoDialogAction(
                onPressed: () => signout(),
                child: Text("Ja"),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop("Discard");
                  setState(() {
                    _selectedIndex = 2;
                  });
                },
                child: Text("Nein"),
              ),
            ],
          ),
        );

        break;
    }
  }

  Future<void> signout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context, rootNavigator: true).pop("Discard");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SignInOptionsStateless()),
        (route) => false);
  }

  Widget createBody() {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Card(
            margin: EdgeInsets.fromLTRB(5, 50, 5, 0),
            elevation: 10,
            color: Colors.blueGrey.shade900,
            shadowColor: Colors.blueGrey.shade100,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "WIR KAUFEN DEIN FAHRSCHULAUTO",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.orange.shade500,
                    fontWeight: FontWeight.bold,
                    fontSize: 45),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Card(
            margin: EdgeInsets.fromLTRB(5, 50, 5, 0),
            elevation: 10,
            // color: Colors.blueGrey.shade900,
            shadowColor: Colors.blueGrey.shade100,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "WILKOMMEN",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.blueGrey.shade500,
                    fontWeight: FontWeight.bold,
                    fontSize: 45),
              ),
            ),
          ),
        ),
        // Expanded(
        //   flex: 4,
        //   child: Image.asset(
        //     'lib/Assets/CarsLogo.png',
        //     color: Colors.orange,
        //     colorBlendMode: BlendMode.saturation,
        //   ),
        // ),
      ],
    );
  }
}
