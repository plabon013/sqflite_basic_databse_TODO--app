import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

import 'main.dart';

class NotificationManager {
  setNotification(int diff) {
    Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
    Workmanager().registerOneOffTask('Task identifier', 'taskName',
        initialDelay: Duration(seconds: diff));
  }
}

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) {
    _showNotification();
    return Future.value(true);
  });
}

Future<void> _showNotification() async {
  const AndroidNotificationDetails androidNotificationDetailsChannelSpecific =
  AndroidNotificationDetails('channelId', 'channelName',
      channelDescription: 'Channel description',
      importance: Importance.max,
      priority: Priority.max,
      ticker: 'ticker');

  const NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidNotificationDetailsChannelSpecific);
  await flutterLocalNotificationsPlugin.show(0, 'Check your todo!',
      'You have a scheduled task!', platformChannelSpecifics,
      payload: 'item payload');
}
