import 'package:flutter/material.dart';
import 'package:rootally/button.dart';
import 'constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

const PATH='Session/User/1/';

class NewScreen extends StatefulWidget {
  static const String id = "NewScreen";

  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
//Data displayed initially
// while fetching name,sessions
  String _name='Fetched Data';
  int _sessions = 0;
  final _database=FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    _activateListenerforname();
    _activateListenerfornum();
  }

//Function for fetching user_name from DATABASE
  void _activateListenerforname(){
    _database.child('User/1').onValue.listen((event) {
      final String name =event.snapshot.value;
      setState(() {
        _name='$name';
      });
    });
  }

//Function for fetching sessions from DATABASE
  void _activateListenerfornum(){
    _database.child('$PATH/repetition').onValue.listen((event) {
      final int num =event.snapshot.value;
      setState(() {
        _sessions=num;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.grey[300],
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
//BottomAppBar items
              Bottombaritems(Icons.calendar_today_outlined,'Today'),
              Bottombaritems(Icons.science,'Rehab'),
              Bottombaritems(Icons.compass_calibration_outlined,'Demo'),
              Bottombaritems(Icons.manage_accounts_rounded,'Profile')
            ],
          ),
        ),
      ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 32, 8, 0),
                child: Container(
                  child: Text(
                    'Good Morning\n'
                     '$_name ',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 12.0, 8, 8),
                  child: Text(
                    'You have $_sessions sessions\n'
                    'today!',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700]),
                  ),
                ),
              ),
              Expanded(
//Stack having listview builder and a button
                child: Stack(
                  children: <Widget>[
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _sessions,
                      itemBuilder: (BuildContext context, int index) {
                        return BuildComponentWidget(index + 1);
                      },
                    ),
                    Positioned(right: 30, bottom: 10, child: RoundedButton2()),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}

class BuildComponentWidget extends StatefulWidget {
  final int index;
  BuildComponentWidget(this.index);

  @override
  _BuildComponentWidgetState createState() => _BuildComponentWidgetState();
}

class _BuildComponentWidgetState extends State<BuildComponentWidget> {
//Bool selected is used to change color of icon
//when the specific session is selected
//and as well as have completed container inside session tile when tapped.
  bool selected = false;
  dynamic time;
  int ind = 0;
  String _tt='Fetched Data';

  final _database =FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    ind = func();
    _activateListener();
  }

//Function to get index from constructor
  int func() {
    return widget.index;
  }

//Function for fetching REHAB PROGRAMME from DATABASE
// initialized in init state
  void _activateListener(){
    _database.child('$PATH/desc').onValue.listen((event) {
      final String desc =event.snapshot.value;
      setState(() {
        _tt='$desc';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          SizedBox(width: 30),
          selected
              ? Icon(
                  Icons.check_circle,
                  color: Colors.blue,
                )
              : Icon(Icons.check_circle_outline_outlined),
          SizedBox(width: 10),
          GestureDetector(
            onTap: () async{
              final timechange=_database.child(PATH);
              setState(() {
                selected = true;
                time = DateTime.now();
                print(time.hour.toString() + ":" + time.minute.toString());
              });
//Here(in this try-catch block) time of clicking
// the session title is added to DATABASE.
              try{
                await timechange.update({'Time_pressed_$ind':time.hour.toString() + ":" + time.minute.toString()});
              }
              catch(e){
                print('Error');
                Alert(context: context, title: "ERROR", desc: e.toString()).show();
                print(e);
              }
            },
//Session tile
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 18.0, 50.0, 8.0),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black54)),
                child: Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 8.0, 0, 0),
                          child: Container(
                            child: Text(
                              'Session $ind',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.science_outlined,
                                color: Colors.blue,
                                size: 16,
                              ),
                              Container(
                                child: Text(
//Data from DATABASE is used here
                                  '$_tt',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 32.0),
                          child: Container(
                            child: Text(
                              'programme',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        selected ? CompletedSign(time) : Txt(ind - 1),
                      ],
                    ),
                    SizedBox(width: 15),
                    Container(
                      height: 130,
                      width: 110,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          'images/img.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CompletedSign extends StatelessWidget {
  final DateTime time;
  CompletedSign(this.time);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 16.0),
          child: Container(
            width: 100,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                'Completed',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 8.0),
          child: Container(
            child: Text(
              'Performed At ',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Container(
            child: Text(
              '${time.hour.toString() + ":" + time.minute.toString()}',
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
          ),
        ),
      ],
    );
  }
}

class Txt extends StatelessWidget {
  final int num;
  Txt(this.num);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, top: 5.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.play_arrow,
                size: 22,
              ),
              Text(
                'Finish session $num',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ],
          ),
          Text(
            'to start',
            style: TextStyle(color: Colors.grey, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
