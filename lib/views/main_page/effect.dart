import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:lista_compras/actions/local_notification.dart';
import 'package:lista_compras/models/notification_model.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'action.dart';
import 'state.dart';

Effect<MainPageState> buildEffect() {
  return combineEffects(<Object, Effect<MainPageState>>{
    MainPageAction.action: _onAction,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

ReceivePort _port = ReceivePort();
void _onAction(Action action, Context<MainPageState> ctx) {}

void _onInit(Action action, Context<MainPageState> ctx) async {
  final _preferences = await SharedPreferences.getInstance();

  final _localNotification = LocalNotification.instance;

  await _localNotification.init();

  _localNotification.didReceiveLocalNotification = (id, title, body, payload) =>
      _didReceiveLocalNotification(id, title, body, payload, ctx);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    NotificationList _list;
    if (_preferences.containsKey('notifications')) {
      final String _notifications = _preferences.getString('notifications');
      _list = NotificationList(_notifications);
    }
    if (_list == null) _list = NotificationList.fromParams(notifications: []);
    final _notificationMessage = NotificationModel.fromMap(message.data);
    _list.notifications.add(_notificationMessage);
    _preferences.setString('notifications', _list.toString());
    _localNotification.sendNotification(_notificationMessage.notification.title,
        _notificationMessage.notification?.body ?? '',
        id: int.parse(_notificationMessage.id),
        payload: _notificationMessage.type);
    print(_list.toString());
  });


  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was published!');
    _push(message.data, ctx);
  });


}

void _onDispose(Action action, Context<MainPageState> ctx) {
  if (Platform.isAndroid) _unbindBackgroundIsolate();
}

Future _push(Map<String, dynamic> message, Context<MainPageState> ctx) async {
  if (message != null) {
    final _notificationMessage = NotificationModel.fromMap(message);
    var data = {
      'id': int.parse(_notificationMessage.id.toString()),
      'bgpic': _notificationMessage.posterPic,
      'name': _notificationMessage.name,
      'posterpic': _notificationMessage.posterPic
    };

    //TODO Notificaoca
    // Page page = _notificationMessage.type == 'movie'
    //     ? MovieDetailPage()
    //     : TvShowDetailPage();
    await Navigator.of(ctx.state.scaffoldKey.currentContext)
        .push(PageRouteBuilder(pageBuilder: (context, animation, secAnimation) {
      return FadeTransition(
        opacity: animation,
        // child: page.buildPage(data),
      );
    }));
  }
}



void _unbindBackgroundIsolate() {
  IsolateNameServer.removePortNameMapping('downloader_send_port');
}



Future _didReceiveLocalNotification(int id, String title, String body,
    String payload, Context<MainPageState> ctx) async {
  // Page page = payload == 'movie' ? MovieDetailPage() : TvShowDetailPage();
  var data = {
    payload == 'movie' ? 'id' : 'tvid': id,
    payload == 'movie' ? 'title' : 'name': title,
  };
  await Navigator.of(ctx.state.scaffoldKey.currentContext).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secAnimation) {
        return FadeTransition(
          opacity: animation,
          // child: page.buildPage(data),
        );
      },
    ),
  );
}
