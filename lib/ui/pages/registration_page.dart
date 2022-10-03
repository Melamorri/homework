import 'package:firebase/const/strings.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../style/custom_style.dart';
import '../../firebase/firebase_helper.dart';
import '../widgets/header_widget.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordAgainController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  late String _username;

  @override
  Widget build(BuildContext context) {
    final width = Device.orientation == Orientation.landscape ? 70.w : 40.h;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const SizedBox(
              height: 150,
              child: HeaderWidget(
                  150, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 110),
                        const Text(
                          Strings.enterData,
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          width: width,
                          decoration: CustomDecoration().myBoxDecoration(),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            decoration: CustomDecoration.textFieldStyle(
                                labelText: Strings.username,
                                hintText: Strings.enterUsername),
                            onChanged: (value) {
                             setState(() {
                               _username = value;
                             });
                            },
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          width: width,
                          decoration: CustomDecoration().myBoxDecoration(),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: _emailController,
                            decoration: CustomDecoration.textFieldStyle(
                                labelText: Strings.email,
                                hintText: Strings.enterEmail),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return Strings.enterEmail;
                              }
                              if (!value.contains("@")) {
                                return Strings.invalidEmail;
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          width: width,
                          decoration: CustomDecoration().myBoxDecoration(),
                          child: TextFormField(
                            textInputAction: TextInputAction.done,
                            controller: _passwordController,
                            obscureText: true,
                            decoration: CustomDecoration.textFieldStyle(
                                labelText: Strings.pwd,
                                hintText: Strings.enterPwd),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return Strings.pleaseEnterPwd;
                              }
                              if (value.length < 8) {
                                return Strings.pwdLength;
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          width: width,
                          decoration: CustomDecoration().myBoxDecoration(),
                          child: TextFormField(
                            textInputAction: TextInputAction.done,
                            controller: _passwordAgainController,
                            obscureText: true,
                            decoration: CustomDecoration.textFieldStyle(
                                labelText: Strings.confirmPwd,
                                hintText: Strings.confirmYourPwd),
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        FormField<bool>(
                          builder: (state) {
                            return Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: Device.orientation ==
                                          Orientation.landscape
                                      ? MainAxisAlignment.center
                                      : MainAxisAlignment.start,
                                  children: <Widget>[
                                    Checkbox(
                                        value: checkboxValue,
                                        onChanged: (value) {
                                          setState(() {
                                            checkboxValue = value!;
                                            state.didChange(value);
                                          });
                                        }),
                                    const Text(
                                      Strings.acceptTerms,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.errorText ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Theme.of(context).errorColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                          validator: (value) {
                            if (!checkboxValue) {
                              return Strings.youNeedToAcceptTerms;
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration:
                              CustomDecoration.buttonDecoration(context),
                          child: ElevatedButton(
                            style: CustomDecoration().buttonStyle(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                Strings.signUp.toUpperCase(),
                                style: const TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () async {
                              final email = _emailController.text;
                              final password = _passwordController.text;
                              final passwordAgain = _passwordAgainController.text;
                              if (password == passwordAgain) {
                                final success = await FirebaseHelper.signUp(email, password, _username);
                                if (success) {
                                  Navigator.pushReplacementNamed(context, '/greeting');
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(Strings.somethingWentWrong),
                                    ),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(Strings.pwdsNotMatch),
                                  ),
                                );
                              }
                              setState(() {

                              });
                            }),
                        ),
                        const SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          }),
    );
  }
}
