import 'package:flutter/material.dart';
import 'package:rootally/Next_page.dart';
import 'package:rootally/login_screen.dart';
import 'package:rootally/ForgetPassword.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rootally/Contact_us.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(RootallyAi());
}

class RootallyAi extends StatelessWidget {
  final Future<FirebaseApp> _app=Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: _app,
        builder: (context , snapshot) {
          if(snapshot.hasError){
            return Text('something went wrong');
          }
          else if(snapshot.hasData)
            {
              return LoginScreen();
            }
          else
            {
              return CircularProgressIndicator();
            }
        },
      ),
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        ForgetPasswordScreen.id: (context) => ForgetPasswordScreen(),
        NewScreen.id:(context) =>NewScreen(),
        ContactUs.id:(context) =>ContactUs()
      },
    );
  }
}
