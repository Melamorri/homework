import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:week9/pages/greeting_page.dart';
import 'package:week9/pages/login_page.dart';
import 'package:week9/pages/registration_page.dart';
import 'package:week9/shared_prefs/session_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sessionManager = SessionManager();
  final initialRoute = await sessionManager.isLoggedIn() ? '/home' : '/login';
  runApp(LoginApp(
    initialRoute: initialRoute,
  ));
}

class LoginApp extends StatelessWidget {
  final String initialRoute;
  final Color _primaryColor = HexColor('#cfd8dc');
  final Color _accentColor = HexColor('#455a64');

  LoginApp({
    Key? key,
    required this.initialRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Flutter Login App',
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.grey.shade100,
            primaryColor: _primaryColor,
            primarySwatch: Colors.grey,
            colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: _accentColor)),
        initialRoute: initialRoute,
        routes: {
          '/login': (_) => LoginPage(),
          '/sign_up': (_) => RegistrationPage(),
          '/home': (_) => GreetingPage(username: ''),
        },
      );
    },
    );
  }
}
