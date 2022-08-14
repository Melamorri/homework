import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:week9/pages/widgets/header_widget.dart';
import 'package:week9/shared_prefs/user.dart';
import 'package:week9/shared_prefs/user_repository.dart';
import 'package:week9/style/custom_style.dart';
import 'greeting_page.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final userRepository = UserRepository();
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;

  @override
  Widget build(BuildContext context) {
    final width = Device.orientation == Orientation.landscape ? 70.w : 40.h;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              child: const HeaderWidget(
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
                        SizedBox(height: 110),
                        Text(
                          'Please enter your data',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 30),
                        Container(
                          width: width,
                          decoration: CustomDecoration().myBoxDecoration(),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: firstNameController,
                            decoration: CustomDecoration.textFieldStyle(
                                labelText: 'First Name',
                                hintText: 'Enter your first name'),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: width,
                          decoration: CustomDecoration().myBoxDecoration(),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            decoration: CustomDecoration.textFieldStyle(
                                labelText: 'Last Name',
                                hintText: 'Enter your last name'),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          width: width,
                          decoration: CustomDecoration().myBoxDecoration(),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: _emailController,
                            decoration: CustomDecoration.textFieldStyle(
                                labelText: "E-mail address",
                                hintText: "Enter your email"),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter your email address";
                              }
                              if (!value.contains("@")) {
                                return 'Invalid email address';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          width: width,
                          decoration: CustomDecoration().myBoxDecoration(),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            decoration: CustomDecoration.textFieldStyle(
                                labelText: "Mobile Number",
                                hintText: "Enter your mobile number"),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter your phone number";
                              }
                              if (value.length < 10) {
                                return "Your phone number must have a minimum of ten characters";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          width: width,
                          decoration: CustomDecoration().myBoxDecoration(),
                          child: TextFormField(
                            textInputAction: TextInputAction.done,
                            controller: _passwordController,
                            obscureText: true,
                            decoration: CustomDecoration.textFieldStyle(
                                labelText: "Password",
                                hintText: "Enter your password"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your password";
                              }
                              if (value.length < 8) {
                                return 'Your password must have a minimum of eight characters';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 15.0),
                        FormField<bool>(
                          builder: (state) {
                            return Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: Device.orientation == Orientation.landscape ? MainAxisAlignment.center: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Checkbox(
                                        value: checkboxValue,
                                        onChanged: (value) {
                                          setState(() {
                                            checkboxValue = value!;
                                            state.didChange(value);
                                          });
                                        }),
                                    Text(
                                      "I accept all terms and conditions.",
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
                              return 'You need to accept terms and conditions';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          decoration:
                              CustomDecoration.buttonDecoration(context),
                          child: ElevatedButton(
                            style: CustomDecoration().buttonStyle(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Sign Up".toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () async {
                              final name = firstNameController.text;
                              final email = _emailController.text;
                              final password = _passwordController.text;
                              if (_formKey.currentState!.validate()) {
                                await userRepository
                                    .signUp(User(email, password));
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        GreetingPage(username: name)));
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 20.0),
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
