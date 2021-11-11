//Screen used when user clicks on Contact Us icon
import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  static const String id = 'Contact_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.white,
            child: Image.asset('images/2.png'),
          ),
          Container(
            child: Text(
              'CONTACT   US',textAlign: TextAlign.center,
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
