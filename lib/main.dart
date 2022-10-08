import 'dart:async';
import 'package:firebase/ui/pages/login_page.dart';
import 'package:firebase/ui/pages/notes_page/notes_page.dart';
import 'package:firebase/ui/pages/registration_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'di/config.dart';
import 'firebase/firebase_options.dart';

void main() async {
  configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = "pk_test_51Lej2tKIHorZMKMijHsySdKFp800ESygUGrDTPOSWEJ7woz5RqKxNcUNxBUOsEXuNsPv6qUMQqGc0h8oeBwg9wL100pgmuTqtp";
  await Stripe.instance.applySettings();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<User?> user;
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: generateMaterialColor(color: const Color(0xfffb998e)),
        ),
        initialRoute: FirebaseAuth.instance.currentUser == null ? '/login' : '/greeting',
        routes: {
          '/login': (_) => const LoginPage(),
          '/sign_up': (_) => const RegistrationPage(),
          '/greeting': (_) => const NotesPage(),
        },
      );
    },);
  }
}
