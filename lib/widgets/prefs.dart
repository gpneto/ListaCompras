import 'dart:ui';

import 'package:lista_compras/globalbasestate/action.dart';
import 'package:lista_compras/globalbasestate/store.dart';
import 'package:lista_compras/widgets/target_platform_native.dart';
import 'package:shared_preferences/shared_preferences.dart';


enum Themes { DARK, LIGHT, SYSTEM }

class Prefs {
  Map<String, List<PrefsListener>> _listeners;

  factory Prefs.singleton() {
    return _instance;
  }

  static final Prefs _instance = Prefs._internal();

  SharedPreferences _prefs;
  bool _initialized = false;

  static const String THEME_PREF = "AppTheme";
  static const String THEME_NATIVE_PREF = "AppThemeNative";
  static const String MENUS_DISABLED_PREF = "MenusSistema_2";
  static const String MENUS_ORDEM_PREF = "MenusOrdem_2";
  static const String INTO_1_PREF = "Into_1";

  Prefs._internal() {
    _listeners = Map<String, List<PrefsListener>>();
    _getPrefs().then((prefs) {

      for (String key in _listeners.keys) {
        List<PrefsListener> listeners = _listeners[key];
        if (listeners != null && listeners.isNotEmpty) {
          Object value = prefs.get(key);
          for (PrefsListener listener in listeners) {
            listener(key, value);
          }
        }
      }
      _initialized = true;
    });
  }

  void addListenerForPref(String key, PrefsListener listener,
      {bool executar = true}) {
    List<PrefsListener> list = _listeners[key];
    if (list == null) {
      list = List<PrefsListener>();
      _listeners[key] = list;
    }
    list.add(listener);

    if (_initialized) {
      if (executar) {
        try {
          String value = _prefs.getString(key);

          listener(key, value);
        } catch (e) {
          List<String> value = _prefs.getStringList(key);

          listener(key, value == null ? List<String>() : value);
        }
      }
    }
  }

  Future<SharedPreferences> _getPrefs() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
    return _prefs;
  }

  Future<Object> getValuePref(String prefName) async {
    if (Prefs.singleton()._initialized) {
      var pref = await Prefs.singleton()._getPrefs();
      String valuePref = pref.getString(prefName);
      return valuePref;
    }else{
      //aguarda ser inicializado
      return getValuePref(prefName);
    }
  }

  Future<Object> isInit() async {
    if (Prefs.singleton()._initialized) {
          return true;
    }else{
      //aguarda ser inicializado
      var pref = await Prefs.singleton()._getPrefs();
      return isInit();
    }
  }


  void setValuePref(String pref, String value) {
    _getPrefs().then((prefs) {
      prefs.setString(pref, value);
    });

    List<PrefsListener> listenerList = _listeners[pref];
    if (listenerList != null) {
      for (PrefsListener listener in listenerList) {
        listener(pref, value);
      }
    }
  }

  void removePref(String pref) {
    _getPrefs().then((prefs) {
      prefs.remove(pref);
    });

    List<PrefsListener> listenerList = _listeners[pref];
    if (listenerList != null) {
      for (PrefsListener listener in listenerList) {
        listener(pref, null);
      }
    }
  }


  String getTheme() {
    if (_initialized) {
      String theme = _prefs.getString(THEME_PREF);
      if (theme != null) {
        return theme;
      } else {
        // _prefs.setString(THEME_PREF, Themes.SYSTEM.toString()); //ok not to wait
        return Themes.SYSTEM.toString();
      }
    } else {
      return Themes.SYSTEM.toString();
    }
  }

  List<String> getMenusDisabled() {
    if (_initialized) {
      List<String> theme = _prefs.getStringList(MENUS_DISABLED_PREF);
      if (theme != null) {
        return theme;
      } else {
        _prefs.setStringList(MENUS_DISABLED_PREF, []); //ok not to wait
        return [];
      }
    } else {
      return [];
    }
  }



  List<String> getOrdemMenu() {
    if (_initialized) {
      List<String> theme = _prefs.getStringList(MENUS_ORDEM_PREF);
      if (theme != null) {
        return theme;
      } else {
        _prefs.setStringList(MENUS_ORDEM_PREF, []); //ok not to wait
        return [];
      }
    } else {
      return [];
    }
  }



  //called when the user updates the operating system theme
  //(by choosing light or dark mode)
  void systemThemeUpdated(Brightness brightness) {
    String theme = getTheme();

    List<PrefsListener> listenerList = _listeners[THEME_PREF];
    if (listenerList != null) {
      for (PrefsListener listener in listenerList) {
        listener(THEME_PREF, theme);
      }
    }
  }

  ///set the app's theme preference from the
  ///app's own UI
  void setTheme(String theme) {
    _getPrefs().then((prefs) {
      prefs.setString(THEME_PREF, theme);
    });
    List<PrefsListener> listenerList = _listeners[THEME_PREF];
    if (listenerList != null) {
      for (PrefsListener listener in listenerList) {
        listener(THEME_PREF, theme);
      }
    }
  }

  ///set the app's theme preference from the
  ///app's own UI
  void setMenuDisabled(String theme) {
    List<String> menus = getMenusDisabled();
    menus.add(theme);

    _getPrefs().then((prefs) async{
      await prefs.setStringList(MENUS_DISABLED_PREF, menus);
      GlobalStore.store.dispatch(GlobalActionCreator.setPages(true));
    });
    List<PrefsListener> listenerList = _listeners[MENUS_DISABLED_PREF];
    if (listenerList != null) {
      for (PrefsListener listener in listenerList) {
        listener(MENUS_DISABLED_PREF, menus);
      }
    }
  }

  ///set the app's theme preference from the
  ///app's own UI
  void setMenuDisabledRemove(String theme) {
    List<String> menus = getMenusDisabled();
    menus.removeWhere((t) => t == theme);

    _getPrefs().then((prefs) async{
      await prefs.setStringList(MENUS_DISABLED_PREF, menus);
      GlobalStore.store.dispatch(GlobalActionCreator.setPages(true));
    });
    List<PrefsListener> listenerList = _listeners[MENUS_DISABLED_PREF];
    if (listenerList != null) {
      for (PrefsListener listener in listenerList) {
        listener(MENUS_DISABLED_PREF, menus);
      }
    }
  }

  ///set the app's theme preference from the
  ///app's own UI
  void setOrdemMenu(List<String> theme) {
    _getPrefs().then((prefs) async{
      await prefs.setStringList(MENUS_ORDEM_PREF, theme);
      GlobalStore.store.dispatch(GlobalActionCreator.setPages(true));
    });
    List<PrefsListener> listenerList = _listeners[MENUS_ORDEM_PREF];
    if (listenerList != null) {
      for (PrefsListener listener in listenerList) {
        listener(MENUS_ORDEM_PREF, theme);
      }
    }
  }

  ///set the app's theme preference from the
  ///app's own UI
  void setThemeNative(String theme) {
    _getPrefs().then((prefs) async{
      await prefs.setString(THEME_NATIVE_PREF, theme);
      GlobalStore.store.dispatch(GlobalActionCreator.setTheme(TargetPlatformNative.values.firstWhere((e) => e.toString() == theme)));
    });
    List<PrefsListener> listenerList = _listeners[THEME_NATIVE_PREF];
    if (listenerList != null) {
      for (PrefsListener listener in listenerList) {
        listener(THEME_NATIVE_PREF, theme);
      }
    }
  }
}

typedef PrefsListener(String key, Object value);
