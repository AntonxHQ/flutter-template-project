
import 'package:antonx/core/models/fcm_notification.dart';
import 'package:antonx/ui/locator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'database_services.dart';

class NotificationsService {
  var _fcm = FirebaseMessaging();

  final _dbService = locator<DatabaseService>();

//  NotificationsStatusProvider notificationsStatusProvider;

  void initConfigure() {
//    notificationsStatusProvider = Provider.of<NotificationsStatusProvider>(
//        _navKey.currentContext,
//        listen: false);
    _fcm.onTokenRefresh.listen((newToken) {
//      print('FCM Token refreshed with new token: $newToken');
//      _dbService.updateFcmToken(newToken, locator<AuthService>().user.uid);
    });
    _fcm.configure(
      onMessage: _onMessage,
      onLaunch: _onLaunch,
      onResume: _onResume,
      onBackgroundMessage: _backgroundMessageHandler,
    );
  }

  Future<dynamic> _onMessage(Map<String, dynamic> message) async {
    print('@onMessage');
    try {
      final notification = FcmNotification.fromJson(message);
      print('${notification.toJson()}');

      /// To update the UI showing there is a new notification
//      if (locator<AuthService>().isLogin) {
//        print('showing dialog');
      switch (notification.type) {
        case 'newAttendance':
          Get.dialog(AlertDialog(
            title: Text('${notification.title}'),
            content: Text('${notification.body}'),
            actions: [
              RaisedButton(
                child: Text('See'),
                onPressed: () {
                  Get.back();
//                  Get.to(AttendanceScreen());
                },
              )
            ],
          ));
          break;
        case 'downloads':
          Get.dialog(AlertDialog(
            title: Text('${notification.title}'),
            content: Text('${notification.body}'),
            actions: [
              RaisedButton(
                child: Text('See'),
                onPressed: () {
                  Get.back();
//                  Get.to(DownloadScreen());
                },
              )
            ],
          ));
          break;
        case 'newAnnouncement':
          Get.dialog(AlertDialog(
            title: Text('${notification.title}'),
            content: Text('${notification.body}'),
            actions: [
              RaisedButton(
                child: Text('See'),
                onPressed: () {
                  Get.back();
//                  Get.to(AnnouncementScreen());
                },
              )
            ],
          ));
          break;
        case 'newResult':
          Get.dialog(AlertDialog(
            title: Text('${notification.title}'),
            content: Text('${notification.body}'),
            actions: [
              RaisedButton(
                child: Text('See'),
                onPressed: () {
                  Get.back();
//                  Get.to(ResultScreen());
                },
              )
            ],
          ));
          break;
        case 'accountApproved':
          Get.dialog(AlertDialog(
            title: Text('${notification.title}'),
            content: Text('${notification.body}'),
            actions: [
              RaisedButton(
                child: Text('See'),
                onPressed: () {
                  Get.back();
//                  Get.to(HomeScreen());
                },
              )
            ],
          ));
          break;
        default:
          print('Any other type of notification');
      }
//      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> _onResume(Map<String, dynamic> message) async {
    print('@onResume');
    final notification = FcmNotification.fromJson(message);
    _handleMessage(notification);
  }

  Future<dynamic> _onLaunch(Map<String, dynamic> message) async {
    print('@onLaunch');
    final notification = FcmNotification.fromJson(message);
    _handleMessage(notification);
  }

  _handleMessage(FcmNotification notification) async {
    print('@handleMessage');

    /// To update the UI showing there is a new notification
    switch (notification.type) {
      case 'newAttendance':
//        Get.to(AttendanceScreen());
        break;
      case 'downloads':
//        Get.to(DownloadScreen());
        break;
      case 'newAnnouncement':
//        Get.to(AnnouncementScreen());
        break;
      case 'newResult':
//        Get.to(ResultScreen());
        break;
      case 'accountApproved':
//        Get.to(HomeScreen());
        break;
    }
  }

  static Future<dynamic> _backgroundMessageHandler(
      Map<String, dynamic> message) {
    print('@backgroundMessageHandler');
  }
}
