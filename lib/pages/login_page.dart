import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:week9/pages/widgets/header_widget.dart';
import '../shared_prefs/session_manager.dart';
import '../shared_prefs/user.dart';
import '../shared_prefs/user_repository.dart';
import '../style/custom_style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userRepository = UserRepository();
  final _sessionManager = SessionManager();

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
                            final user = User(email, password);
                            if (await _userRepository.contains(user)) {
                              await _sessionManager.saveSession(user);
                              Navigator.pushNamed(context, '/home',
                                  arguments: email);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red.shade300,
                                  content: Text('Wrong email or password'),
                                ),
                              );
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                            child: Text(
                              'Sign In',
                              style: TextStyle(letterSpacing: 1),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        child: Text.rich(
                          TextSpan(children: [
                            TextSpan(text: "Don't have an account? "),
                            TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, '/sign_up');
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
}
