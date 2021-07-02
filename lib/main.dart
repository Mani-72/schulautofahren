import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectcars/OldMain.dart';
import 'package:projectcars/Routes/HomeScreen.dart';
import 'package:projectcars/Server/Server.dart';
import 'package:projectcars/Utils/Buttons.dart';
import 'package:projectcars/Utils/Loading.dart';

void main() {
  runApp(SignInOptionsStateless());
}

class SignInOptionsStateless extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WIR KAUFEN DEIN FAHRSCHULAUTO',
      theme: ThemeData(
        dialogBackgroundColor: Colors.blueGrey.shade300,
        canvasColor: Colors.white,
        primarySwatch: Colors.orange,
        appBarTheme: AppBarTheme(color: Colors.orange.shade500),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignInOptions(),
    );
  }
}

class SignInOptions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SignInOptionsState();
}

class SignInOptionsState extends State<SignInOptions> {
  bool y = false;
  bool yy = false;
  bool yyy = true;
  bool yyyy = false;
  z yyyyy = new z();
  List<String> yyyyyy = new List<String>();

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
              child: yyy ? loading : result,
            ),
          ],
        ),
        alignment: Alignment.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (yy) {
      return mainScreen(Text("Something Went Wrong!"));
    }

    if (!y) {
      return Scaffold(body: loading);
    }

    return mainScreen(Center(
      child: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          CreateButton(yyyyyyy, "Melden Sie sich anonym an", context),
          SizedBox(
            height: 20,
          ),
          CreateButton(
              signInWithNumber, "Melden Sie sich mit Ihrer Nummer an", context),
        ],
      ),
    ));
  }

  void signInWithNumber(BuildContext context) {
    setState(() {
      yyy = true;
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyHomePage()));
    setState(() {
      yyy = false;
    });
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  void preEmptiveOperations() {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null || user.uid == "") {
        setState(() {
          yyy = false;
        });
      } else {
        if (!yyyy) {
          yyyy = true;
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => aaaaaaaaaaaa(user, yyyyyy)),
              (route) => false);
        }
      }
    });
  }

  Future<void> yyyyyyy(BuildContext context) async {
    setState(() {
      yyy = true;
    });
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
  }

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      preEmptiveOperations();
      yyyyyy = await yyyyy.zzzzzzzzzzz();

      setState(() {
        y = true;
      });
    } catch (e) {
      setState(() {
        yy = true;
      });
    }
  }
}
