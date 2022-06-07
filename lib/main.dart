import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: MainScreen());
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController controller = TextEditingController();
  int age = 0;
  approvalMessage(int age) {
    if (age == 0) {
      return "";
    } else if (age < 16) {
      return "You're not allowed to watch this movie";
    } else if (age >= 18) {
      return "You're allowed to watch this movie";
    } else {
      return "You're allowed to watch this movie accompanied by an adult";
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
            body: Container(
                padding: EdgeInsets.all(17.0),
                height: double.infinity,
                    margin: EdgeInsets.all(15),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                      const Center(
                        child: Text(
                          "Enter your age",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'AHS',
                            letterSpacing: 1,
                            color: Color(0xFF800000),
                          ),
                        ),
                      ),
                      Image.network('https://avatarfiles.alphacoders.com/164/thumb-164270.png'),
                      TextField(
                        style: TextStyle(color: Color(0xFF800000), fontFamily: 'AHS', fontSize: 22),
                        keyboardType: TextInputType.number,
                        controller: controller,
                        decoration: const InputDecoration(
                          fillColor: Colors.redAccent,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.redAccent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF800000)),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        onSubmitted: (value) {
                          var result = int.parse(value);
                          setState(() {
                            age = result;
                          });
                        },
                      ),

                        Text(approvalMessage(age), style: TextStyle(color: Color(0xFF800000), fontFamily: "AHS", fontSize: 25,letterSpacing: 1),),
                    ]
                    )

            )
        )
    );
  }
}
