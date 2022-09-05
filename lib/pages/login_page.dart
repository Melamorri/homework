import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../custom_style.dart';
import '../firebase_helper.dart';
import '../widgets/header_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  User? user;

  @override
  Widget build(BuildContext context) {
    final width = Device.orientation == Orientation.landscape ? 70.w : 30.h;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              child:  HeaderWidget(200, true, Icons.login_outlined),
            ),
            Container(
                  child: Column(
                    children: [
                      const Text(
                        'Sign in to your account',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                               Container(
                                 width: width,
                                 child: TextFormField(
                                   validator: (value) {
                                     if (value!.isEmpty)
                                       return 'Please enter your e-mail';
                                     return null;
                                   },
                                   decoration: CustomDecoration.textFieldStyle(
                                     labelText: ('E-mail'),
                                     hintText: ('Enter your e-mail'),
                                   ),
                                   controller: _emailController,
                                   textInputAction: TextInputAction.next,
                                 ),
                               ),
                              SizedBox(height: 30.0),
                              Container(
                                width: width,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                  decoration: CustomDecoration.textFieldStyle(
                                      labelText: ('Password'),
                                      hintText: ('Enter your password')),
                                  textInputAction: TextInputAction.done,
                                  controller: _passwordController,
                                ),
                              ),
                            ],
                          )),
                      SizedBox(height: 30.0),
                      Container(
                        decoration: CustomDecoration.buttonDecoration(context),
                        child: ElevatedButton(
                          style: CustomDecoration().buttonStyle(),
                          onPressed: () async {
                            final email = _emailController.text;
                            final password = _passwordController.text;
                            final success = await FirebaseHelper.login(email, password);
                            if (success) {
                              Navigator.pushReplacementNamed(context, '/greeting');
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red.shade300,
                                  content: Text('Wrong email or password'),
                                ),
                              );
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                            child: Text(
                              'Sign In'.toUpperCase(),
                              style: TextStyle(letterSpacing: 1, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        child: Text.rich(
                          TextSpan(children: [
                            TextSpan(text: "Don't have an account? "),
                            TextSpan(
                                text: 'Sign Up',
                                style: const TextStyle(fontWeight: FontWeight.bold,),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, '/sign_up');
                                  }),
                          ]),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        child: Text.rich(
                          TextSpan(children: [
                            TextSpan(text: "Forgot password? "),
                            TextSpan(
                                text: 'Reset',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    FirebaseHelper.resetPassword(_emailController.text);
                                    _showDialog();

                                  }),
                          ]),
                        ),
                      ),
                      SizedBox(height: 30.0),
                    ],
                  )),
          ],
        ),
      ),
    );
  }
  Future _showDialog() => showGeneralDialog(
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
              content: const Padding(
                child: Text('We have sent the instructions to your email'),
                padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0)
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok'),
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
}
