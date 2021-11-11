//Screen used when user clicks on Forget Password
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static const String id = 'forgetpass';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.white,
            child: Image.asset('images/1.png'),
          ),
          Container(
            child: Text(
              'YOU ARE LOST',textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.pink,
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
