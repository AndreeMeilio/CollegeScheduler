
import 'package:college_scheduler/config/constants_value.dart';
import 'package:college_scheduler/config/shared_preference.dart';
import 'package:college_scheduler/utils/date_format_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationConfig {

  static FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  static FlutterLocalNotificationsPlugin getFlutterLocalNotif(){
    if (flutterLocalNotificationsPlugin != null) return flutterLocalNotificationsPlugin!;

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    return flutterLocalNotificationsPlugin!;
  }

  static Future<void> initialize() async{

    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings("ic_launcher");

    final InitializationSettings settings = InitializationSettings(
      android: androidSettings
    );

    //Request Permisssion
    FlutterLocalNotificationsPlugin flutterLocalNotif = getFlutterLocalNotif();
    bool isPermissionGranted = await getFlutterLocalNotif().resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission() ?? false;

    if (isPermissionGranted){
      print("test");
      await getFlutterLocalNotif().initialize(settings);
    }
  }

  static Future<void> scheduleEventNotification({
    required int id,
    required String titleNotification, 
    required String descNotification,
    required DateTime dateTime,
  }) async{
    try {
      const AndroidNotificationDetails androidDetail = AndroidNotificationDetails(
        ConstansValue.channelEventNotif, 
        ConstansValue.channelEventNotif,
        channelDescription: "Notification For Reminder Event",
        importance: Importance.max,
        priority: Priority.max,
        sound: RawResourceAndroidNotificationSound("notification"),
        playSound: true,
        ticker: 'ticker',
      );

      const NotificationDetails details = NotificationDetails(
        android: androidDetail
      );

      String formattedDateTime = DateFormatUtils.dateFormatyMMddkkiiss(date: dateTime);
      final userId = await SharedPreferenceConfig().getInt(key: ConstansValue.user_id);

      await NotificationConfig.getFlutterLocalNotif().zonedSchedule(
        id,
        titleNotification,
        descNotification,
        tz.TZDateTime.parse(tz.local, formattedDateTime),
        details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: "userid$userId!"
      );
    } catch (e){
      print(e);
    }
  }

  static Future<void> cancelEventNotification({
    required int id
  }) async{
    try {
      final userId = await SharedPreferenceConfig().getInt(key: ConstansValue.user_id);
      await NotificationConfig.getFlutterLocalNotif().cancel(id);
    } catch (e){
      print(e);
    }
  }
}