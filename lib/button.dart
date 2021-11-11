import 'package:flutter/material.dart';

//Layout of Login button used on Login Page

class RoundedButton1 extends StatelessWidget {
  final dynamic func;
  RoundedButton1(this.func);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      //borderRadius: BorderRadius.circular(30.0),
      child: MaterialButton(
        onPressed: func,
        minWidth: 200.0,
        height: 42.0,
        shape: StadiumBorder(
            side: BorderSide(color: Colors.black,width: 2)
        ),
        child: Text('Login',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 23
          ),
        ),
      ),
    );
  }
}

//Layout of button stacked on listview on NextPage

class RoundedButton2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Container(
        width: 200,
        child: Material(
          color: Colors.blue[700],
          shape: StadiumBorder(
              side: BorderSide(color: Colors.black,width: 5)
          ),
          child: MaterialButton(
            onPressed: (){
              print('session started');
            },
            child: Row(
              children: [
                Icon(Icons.play_arrow,color: Colors.white),
                Text('Start Session',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 23
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}

