import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../firebase_helper.dart';
import '../widgets/header_widget.dart';

class GreetingPage extends StatefulWidget {

  GreetingPage({Key? key}) : super(key: key);
  @override
  State<GreetingPage> createState() => _GreetingPageState();

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}

class _GreetingPageState extends State<GreetingPage> {
  String? username;
  Future<void> _initUsername() async {
    final email = FirebaseAuth.instance.currentUser?.email ?? '';
    setState(() {
      username = email;
    });
  }

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
            FirebaseHelper.logout();
            Navigator.pushNamed(context, '/login');
          }),
    );

  }
}
