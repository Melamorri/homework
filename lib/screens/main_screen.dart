import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notifications/alert_message.dart';
import 'package:notifications/custom_button.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  late FlutterLocalNotificationsPlugin localNotifications;
  late AnimationController animation;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    animation =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(animation);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animation.stop();
      }
    });
    animation.forward();
    super.initState();
    tz.initializeTimeZones();
    const androidInitialize = AndroidInitializationSettings('ic_launcher');
    const iOSInitialize = IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    const initializationSettings = InitializationSettings(
        android: androidInitialize, iOS: iOSInitialize);
    localNotifications = FlutterLocalNotificationsPlugin();
    localNotifications.initialize(initializationSettings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your programming reminder'),
          centerTitle: true,
          backgroundColor: Colors.black54,
        ),
        body: FadeTransition(
            opacity: _fadeIn,
            child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/background.jpg"),
                    fit: BoxFit.cover,
                    opacity: 0.4,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      customButton('Show Notification', _showNotification),
                      customButton('Schedule Notifications', () async {
                        await showScheduledNotification();
                        showAlertMessage(context, 'Great!',
                            "You'll get your reminder at 10 AM");
                      },),
                      customButton('Cancel Notifications', () async {
                        final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
                        FlutterLocalNotificationsPlugin();
                        await flutterLocalNotificationsPlugin.cancel(0);
                        showAlertMessage(context, 'Allrighty',
                            "You won't get more notifications");
                      })
                    ],
                  ),
                )
            ))
    );
  }

  Future _showNotification() async {
    const androidDetails = AndroidNotificationDetails(
      "ID",
      "Title",
      importance: Importance.high,
      channelDescription: "Content",
    );

    const iosDetails = IOSNotificationDetails();
    const generalNotificationDetails = NotificationDetails(
        android: androidDetails, iOS: iosDetails);
    await localNotifications.show(
        0, "Hi there!", "Time to code", generalNotificationDetails);
  }

  Future<void> showScheduledNotification() async {
    const androidDetails = AndroidNotificationDetails(
      "ID",
      "Title",
      importance: Importance.high,
      channelDescription: "Content",
    );

    const iosDetails = IOSNotificationDetails();
    const generalNotificationDetails = NotificationDetails(
        android: androidDetails, iOS: iosDetails);
    await localNotifications.zonedSchedule(
      0, "Hi there!", "Time to code",
      _tenAmNotification(),
      generalNotificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  tz.TZDateTime _tenAmNotification() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime date = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, 15);
    if (date.isBefore(now)) {
      date = date.add(const Duration(days: 1));
    }
    return date;
  }
}

