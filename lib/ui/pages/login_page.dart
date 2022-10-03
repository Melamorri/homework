import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../const/strings.dart';
import '../style/custom_style.dart';
import '../../firebase/firebase_helper.dart';
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
            const SizedBox(
              height: 250,
              child:  HeaderWidget(200, true, Icons.login_outlined),
            ),
            Column(
              children: [
                 const Text(
                  Strings.singInToYourAcc,
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
                         SizedBox(
                           width: width,
                           child: TextFormField(
                             validator: (value) {
                               if (value!.isEmpty) {
                                 return Strings.pleaseEnterEmail;
                               }
                               return null;
                             },
                             decoration: CustomDecoration.textFieldStyle(
                               labelText: (Strings.email),
                               hintText: (Strings.enterEmail),
                             ),
                             controller: _emailController,
                             textInputAction: TextInputAction.next,
                           ),
                         ),
                        const SizedBox(height: 30.0),
                        SizedBox(
                          width: width,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return Strings.pleaseEnterPwd;
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: CustomDecoration.textFieldStyle(
                                labelText: (Strings.pwd),
                                hintText: (Strings.enterPwd)),
                            textInputAction: TextInputAction.done,
                            controller: _passwordController,
                          ),
                        ),
                      ],
                    )),
                const SizedBox(height: 30.0),
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
                            content: const Text(Strings.wrongEmailOrPwd),
                          ),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                      child: Text(
                        Strings.signIn.toUpperCase(),
                        style: const TextStyle(letterSpacing: 1, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Text.rich(
                  TextSpan(children: [
                    const TextSpan(text: Strings.dontHaveAcc),
                    TextSpan(
                        text: Strings.signUp,
                        style: const TextStyle(fontWeight: FontWeight.bold,),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, '/sign_up');
                          }),
                  ]),
                ),
                const SizedBox(height: 10,),
                Text.rich(
                  TextSpan(children: [
                    const TextSpan(text: Strings.forgotPwd),
                    TextSpan(
                        text: Strings.reset,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            FirebaseHelper.resetPassword(_emailController.text);
                            _showDialog();

                          }),
                  ]),
                ),
                const SizedBox(height: 30.0),
              ],
            ),
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
                padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                child: Text(Strings.sentInstructions)
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child:  const Text(Strings.okButton),
                )
              ],
            )),
      );
    },
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return const Text('data');
    },
  );
}
