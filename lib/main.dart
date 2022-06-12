import 'package:flutter/material.dart';
import 'custom_decoration.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const Scaffold(
        body: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  MyFormState createState() => MyFormState();
}

class MyFormState extends State {
  final _formKey = GlobalKey<FormState>();
  Gender? _gender;
  Species? _species;
  var _agreement1 = false;
  var _agreement2 = false;
  var _agreement3 = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color(0xB3b684ca),
          Color(0xac9bbc8),
        ],
      )),
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Text(
              "Выберите питомца",
              style: myTextStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: RadioListTile(
                    title: const Text('Собака',
                        style: TextStyle(fontFamily: 'Poppins')),
                    value: Species.dog,
                    groupValue: _species,
                    onChanged: (Species? value) {
                      setState(() {
                        if (value != null) _species = value;
                        if (value != null) {
                          pic = dogPic;
                        }
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: const Text('Кошка',
                        style: TextStyle(fontFamily: 'Poppins')),
                    value: Species.cat,
                    groupValue: _species,
                    onChanged: (Species? value) {
                      setState(() {
                        if (value != null) _species = value;
                        if (value != null) {
                          pic = catPic;
                        }
                      });
                    },
                  ),
                )
              ],
            ),
            pic,
            Text('Кличка питомца:', style: myTextStyle),
            Container(
              margin: EdgeInsets.all(20),
              decoration: textFieldCont,
              child: TextFormField(
                  decoration: textFieldDec,
                  validator: (value) {
                    if (value!.isEmpty) return 'Пожалуйста, введите кличку';
                  }),
            ),
            Text(
              'Имя владельца:',
              style: myTextStyle,
            ),
            Container(
              margin: EdgeInsets.all(20),
              decoration: textFieldCont,
              child: TextFormField(
                  decoration: textFieldDec,
                  validator: (value) {
                    if (value!.isEmpty) return 'Пожалуйста, введите своё имя';
                  }),
            ),
            Text(
              'Номер телефона:',
              style: myTextStyle,
            ),
            Container(
              margin: EdgeInsets.all(20),
              decoration: textFieldCont,
              child: TextFormField(
                  decoration: textFieldDec,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Пожалуйста, введите свой номер телефона';
                    }
                    if (value.length != 10) {
                      return 'Номер телефона должен содержать 10 цифр';
                    }
                  }),
            ),
            Text(
              'Электронная почта:',
              style: myTextStyle,
            ),
            Container(
              margin: EdgeInsets.all(20),
              decoration: textFieldCont,
              child: TextFormField(
                  decoration: textFieldDec,
                  validator: (value) {
                    if (value!.isEmpty) return 'Пожалуйста, введите e-mail';
                    if (!value.contains('@')) return 'Это не E-mail';
                  }),
            ),

            Text(
              'Порода:',
              style: myTextStyle,
            ),
            //const SizedBox(height: 10.0),
            Container(
              margin: EdgeInsets.all(20),
              decoration: textFieldCont,
              child: TextFormField(
                  decoration: textFieldDec,
                  validator: (value) {
                    if (value!.isEmpty) return 'Пожалуйста, укажите породу';
                  }),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: customBoxDec,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Пол питомца:',
                    style: myTextStyle,
                  ),
                  RadioListTile(
                    title: const Text('Самец',
                        style: TextStyle(fontFamily: 'Poppins')),
                    value: Gender.male,
                    groupValue: _gender,
                    onChanged: (Gender? value) {
                      setState(() {
                        if (value != null) _gender = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Самка',
                        style: TextStyle(fontFamily: 'Poppins')),
                    value: Gender.female,
                    groupValue: _gender,
                    onChanged: (Gender? value) {
                      setState(() {
                        if (value != null) _gender = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.all(10),
              decoration: customBoxDec,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Тип корма:',
                    style: myTextStyle,
                  ),
                  const SizedBox(height: 10.0),
                  CheckboxListTile(
                      value: _agreement1,
                      title: Text('Сухой корм',
                          style: const TextStyle(fontFamily: 'Poppins')),
                      onChanged: (bool? value) =>
                          setState(() => _agreement1 = value!)),
                  CheckboxListTile(
                      value: _agreement2,
                      title: const Text('Влажный корм',
                          style: TextStyle(fontFamily: 'Poppins')),
                      onChanged: (bool? value) =>
                          setState(() => _agreement2 = value!)),
                  CheckboxListTile(
                      value: _agreement3,
                      title: const Text('Натуральный корм',
                          style: TextStyle(fontFamily: 'Poppins')),
                      onChanged: (bool? value) =>
                          setState(() => _agreement3 = value!)),
                ],
              ),
            ),

            GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  Color color = Color(0xFF9e1a1a);
                  String text;
                  if (_gender == null) {
                    text = 'Выберите пол питомца';
                  } else if (_agreement1 == false &&
                      _agreement2 == false &&
                      _agreement3 == false) {
                    text = 'Выберите как минимум один тип корма';
                  } else {
                    text = 'Форма успешно заполнена';
                    color = Color(0xFF5dbb63);
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(text),
                      backgroundColor: color,
                    ),
                  );
                }
              },
              child: Container(
                margin: EdgeInsets.all(30.0),
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFf7cac0), Color(0xFF9a7787)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(5, 5),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Проверить',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum Gender { male, female }

enum Species { dog, cat }
