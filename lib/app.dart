import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart' hide Action;

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lista_compras/routes/routes.dart';
import 'package:lista_compras/widgets/prefs.dart';
import 'package:lista_compras/widgets/target_platform_native.dart';

import 'actions/adapt.dart';
import 'actions/app_config.dart';

import 'actions/timeline.dart';
import 'actions/user_info_operate.dart';
import 'generated/i18n.dart';
import 'package:permission_handler/permission_handler.dart';

TargetPlatformNative defaultTargetPlatformNative  = TargetPlatformNative.iOS;


class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final i18n = I18n.delegate;

  ThemeMode themeMode ;

  final AbstractRoutes routes = Routes.routes;
  final ThemeData _lightTheme =
      ThemeData.light().copyWith(accentColor: Colors.transparent, primaryColor: Color(
          0xFFF8F8F8));
  final ThemeData _darkTheme =
      ThemeData.dark().copyWith(accentColor: Colors.transparent);
  final FirebaseAnalytics analytics = FirebaseAnalytics();

  Future _init() async {

    setLocaleInfo('zh', TimelineInfoCN());
    setLocaleInfo('en', TimelineInfoEN());
    setLocaleInfo('Ja', TimelineInfoJA());

    await AppConfig.instance.init(context);

    // await TMDBApi.instance.init();



    await UserInfoOperate.whenAppStart();
  }

  @override
  void initState() {
    I18n.onLocaleChanged = onLocaleChange;

    _init();
    super.initState();

    Prefs.singleton().addListenerForPref(Prefs.THEME_PREF, changeLi);
    Prefs.singleton().addListenerForPref(Prefs.THEME_NATIVE_PREF, changeListener);
  }

  PrefsListener changeListener(String key, Object value) {
    setState(() {
      switch (value) {
        case "TargetPlatformNative.android":
          defaultTargetPlatformNative = TargetPlatformNative.android;
          break;
        case "TargetPlatformNative.iOS":
          defaultTargetPlatformNative = TargetPlatformNative.iOS;
          break;
        case "TargetPlatformNative.app":
          defaultTargetPlatformNative = TargetPlatformNative.app;
          break;
      }

    });


  }

  void onLocaleChange(Locale locale) {
    setState(() {
      I18n.locale = locale;
    });
  }

  PrefsListener changeLi(String key, Object value) {
    setState(() {
      switch (value) {
        case "Themes.LIGHT":
          themeMode = ThemeMode.light;
          break;
        case "Themes.DARK":
          themeMode = ThemeMode.dark;
          break;
        case "Themes.SYSTEM":
          themeMode = ThemeMode.system;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Lista de Compras',
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      theme: _lightTheme,
      darkTheme: _darkTheme,
      localizationsDelegates: [
        I18n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: I18n.delegate.supportedLocales,
      localeResolutionCallback:
          I18n.delegate.resolution(fallback: new Locale("en", "US")),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      home: routes.buildPage('startpage', null),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute<Object>(builder: (BuildContext context) {
          return routes.buildPage(settings.name, settings.arguments);
        });
      },
    );
  }
}
