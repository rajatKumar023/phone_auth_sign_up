import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CodeEnterPage extends StatefulWidget {
  CodeEnterPage({this.verificationId});

  String verificationId;

  @override
  _CodeEnterPageState createState() => _CodeEnterPageState();
}

class _CodeEnterPageState extends State<CodeEnterPage> {
  String smsCode;
  FirebaseUser currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0),
        child: currentUser == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('An OTP has been sent to this phone Number'),
                  SizedBox(
                    height: 60.0,
                  ),
                  TextField(
                    onChanged: (value) {
                      smsCode = value;
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
                      FirebaseAuth.instance
                          .currentUser()
                          .then((FirebaseUser user) {
                        if (user != null) {
                          setState(() {
                            currentUser = user;
                          });
                        } else {
                          _enterOtp();
                        }
                      });
                    },
                    color: Colors.blue,
                    child: Text(
                      'Verify',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              )
            : Column(
                children: <Widget>[
                  SizedBox(
                    height: 60.0,
                  ),
                  Text(
                      'You have signed in successfully.\n Your phone number is ' +
                          currentUser.phoneNumber)
                ],
              ),
      ),
    );
  }

  void _enterOtp() {
    AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: widget.verificationId, smsCode: smsCode);
    FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((AuthResult result) {
      setState(() {
        currentUser = result.user;
      });
    });
  }
}
