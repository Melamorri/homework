import 'package:flutter/material.dart';
import 'package:week9/pages/widgets/header_widget.dart';
import '../shared_prefs/session_manager.dart';

class GreetingPage extends StatelessWidget {
  String username;

  GreetingPage({Key? key, required this.username}) : super(key: key);
  final SessionManager _sessionManager = SessionManager();

  String greetingMessage() {
    var timeNow = DateTime.now().hour;
    if (timeNow <= 12) {
      return 'Good morning, $username';
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      return 'Good afternoon, $username';
    } else if ((timeNow > 16) && (timeNow < 20)) {
      return 'Good evening, $username';
    } else {
      return 'Good night, $username';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          Container(
            height: 250,
            child: HeaderWidget(250, true, Icons.home_sharp),
          ),
          SizedBox(
            height: 60,
          ),
          Text(
            greetingMessage(),
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold),
          ),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.logout_rounded),
          onPressed: () async {
            await _sessionManager.logout();
            Navigator.pushNamed(context, '/login');
          }),
    );
  }
}
