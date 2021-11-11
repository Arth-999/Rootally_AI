import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rootally/Next_page.dart';
import 'package:rootally/button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rootally/constants.dart';
import 'package:rootally/ForgetPassword.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rootally/Contact_us.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "login";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String ps = '';
  bool loading = false;
  bool obscure = true;
  final _auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Spacer(),
              Row(
                children: [
                  Container(
                    height: 100.0,
                    width: 100,
                    child: Image.asset('images/1.png'),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 8.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.input,
                      size: 30,
                    ),
                  ],
                ),
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.left,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                kTextFieldDecoration.copyWith(hintText: 'Email Address'),
              ),
              SizedBox(
                height: 12.0,
              ),
              TextField(
                textAlign: TextAlign.left,
                obscureText: obscure,
                onChanged: (value) {
                  ps = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Password',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                    child: Icon(Icons.remove_red_eye),
                  ),
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    Navigator.pushNamed(context,ForgetPasswordScreen.id );
                  });
                },
                child: Container(
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: RoundedButton1(() async {
                    setState(() {
                      loading = true;
                    });
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: ps);
                      setState(() {
                        loading=false;
                      });
                      if (user!=null){
                        Navigator.pushNamed(context,NewScreen.id);
                      }
                    }
                    catch (e) {
                      setState(() {
                        loading=false;
                      });
                      Alert(context: context, title: "ERROR", desc: e.toString()).show();
                      print(e);
                    }
                  })),
              Spacer(),
              GestureDetector(
                onTap: (){
                  setState(() {
                    Navigator.pushNamed(context,ContactUs.id );
                  });
                },
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone_callback,color: Colors.blue,),
                      Text('Contact Us'),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
