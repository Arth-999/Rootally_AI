import 'package:flutter/material.dart';

//Used for decorating Email Address and Password TextField on login page

const kTextFieldDecoration=InputDecoration(
  hintText: '',
  contentPadding:
  EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 4.0),
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
);

//Used for layout of BottomAppBar items

class Bottombaritems extends StatelessWidget {
  final IconData icon;
  final String txt;
  Bottombaritems(this.icon,this.txt);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon,size: 30,),
        SizedBox(height: 10),
        Text(txt),
      ],
    );
  }
}