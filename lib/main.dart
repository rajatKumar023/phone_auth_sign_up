import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_up_flutter/code_enter_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String phoneNumber;
  String verificationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 60.0,
            ),
            TextField(
              onChanged: (value) {
                phoneNumber = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            RaisedButton(
              onPressed: () {
                phoneAuth();
              },
              color: Colors.blue,
              child: Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> phoneAuth() {
    print(phoneNumber);
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      codeSent: (String id, [int forceCodeSend]) {
        verificationId = id;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CodeEnterPage(
              verificationId: verificationId,
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String id) {
        verificationId = id;
      },
      timeout: Duration(seconds: 5),
      verificationCompleted: (AuthCredential credential) {
        print(credential);
      },
      verificationFailed: (AuthException exception) {
        print(exception.message);
      },
    );
  }
}
