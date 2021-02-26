import 'package:intl/intl.dart';

class FcmNotification {
  String title;
  String body;
  String type;

  FcmNotification({this.title, this.body, this.type});

  FcmNotification.fromJson(doc) {
    print('Notification doc: $doc');
    this.title = doc['notification']['title'];
    this.body = doc['notification']['body'];
    this.type = doc['data']['type'];
    print(this.toJson());
  }

  toJson() {
    return {
      'title': this.title,
      'body': this.body,
      'type': this.type,
    };
  }
}
