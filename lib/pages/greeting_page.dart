import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../custom_style.dart';
import '../firebase_helper.dart';
import '../stripe_helper.dart';
import '../widgets/header_widget.dart';

class GreetingPage extends StatefulWidget {
  GreetingPage({Key? key}) : super(key: key);

  @override
  State<GreetingPage> createState() => _GreetingPageState();
}

class _GreetingPageState extends State<GreetingPage> {
  User? user;
  var notes = <String>[];
  final nameController = TextEditingController();
  var proMode = false;

  String greetingMessage(String? name) {
    var timeNow = DateTime.now().hour;
    if (timeNow <= 12) {
      return 'Good morning, $name';
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      return 'Good afternoon, $name';
    } else if ((timeNow > 16) && (timeNow < 20)) {
      return 'Good evening, $name';
    } else {
      return 'Good night, $name';
    }
  }

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    _initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              height: 250,
              child: HeaderWidget(250, true, Icons.home_sharp),
            ),
            const SizedBox(
              height: 60,
            ),
            Text(
              greetingMessage(user?.displayName),
              style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold),
            ),
            if (proMode) ..._notes() else _payment(),
          ]),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                  child: Icon(Icons.logout_rounded),
                  onPressed: () async {
                    FirebaseHelper.logout();
                    Navigator.pushNamed(context, '/login');
                  }),
              FloatingActionButton(
                onPressed: () {
                  _showDialog('New Note', 'Name', onPressedWrite, 'Add');
                },
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ));
  }

  void _initData() {
    FirebaseHelper.getNotes().listen((event) {
      final map = event.snapshot.value as Map<dynamic, dynamic>?;
      if (map != null) {
        setState(() {
          notes = map.values.map((e) => e as String).toList();
        });
      }
    });
  }

  Future _showDialog(String title, String name, void Function(String) onPressed,
          String buttonName) =>
      showGeneralDialog(
        context: context,
        barrierDismissible: false,
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
                opacity: a1.value,
                child: AlertDialog(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  title: Text(title),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(hintText: name),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        final note = nameController.text;
                        onPressed(note);
                        Navigator.pop(context);
                      },
                      child: Text(buttonName),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    )
                  ],
                )),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return Text('data');
        },
      );

  onPressedWrite(String note) {
    FirebaseHelper.write(note);
  }

  /*void Function(String) onPressedUpdate(int oldNoteIdx) {
    return (newNote) {
      FirebaseHelper.removeNote(oldNoteIdx);
      FirebaseHelper.write(newNote);
    };
  }*/

  List<Widget> _notes() => [
        Expanded(
          child: ListView.separated(
              itemBuilder: (_, i) => ListTile(
                  title: Text(notes[i]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                          onPressed: () async {
                            _showDialog('Edit note', 'New name', (newText) {
                              FirebaseHelper.updateNote(i, newText);
                            }, 'Edit');
                          },
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            FirebaseHelper.removeNote(i);
                          })
                    ],
                  )),
              separatorBuilder: (context, index) => Divider(
                    color: Colors.blueGrey.shade900,
                  ),
              itemCount: notes.length),
        ),
      ];

  Widget _payment() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
          children: [
            const Text('To obtain access to Notes please subscribe', style: TextStyle(fontSize: 16),),
            const SizedBox(height: 15,),
            Container(
              decoration: CustomDecoration.buttonDecoration(context),
              child: ElevatedButton(
                style: CustomDecoration().buttonStyle(),
                onPressed: () {
                  StripeHelper.initPaymentSheet(
                      email: FirebaseAuth.instance.currentUser?.email ??
                          'cr.olich@gmail.com',
                      amount: 500,
                      onSuccess: () async {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Payment completed!')),
                        );
                        await FirebaseHelper.enableProMode();
                        setState(() {
                          proMode = true;
                        });
                      },
                      onError: (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(error)),
                        );
                      });
                },
                child:  Text('Subscribe'.toUpperCase(), style: TextStyle(letterSpacing: 1, color: Colors.white),),
              )
            ),
          ],
        ));
  }
}
