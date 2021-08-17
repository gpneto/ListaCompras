import 'package:fish_redux/fish_redux.dart';
import 'package:lista_compras/actions/adapt.dart';
import 'package:lista_compras/globalbasestate/state.dart';
import 'package:lista_compras/globalbasestate/store.dart';
import 'package:lista_compras/views/add_produto/page.dart';
import 'package:lista_compras/views/config_page/page.dart';
import 'package:lista_compras/views/home_compras/page.dart';
import 'package:lista_compras/views/login_page/page.dart';
import 'package:lista_compras/views/views.dart';
import 'package:lista_compras/widgets/menu_item.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Routes {

  static const list_compras = 'list_compras';
  static const add_produto = 'add_produto';
  static const home_exemplo = 'home_exemplo';


  static final List<ItemMenu> menuItens = [
    ItemMenu(id: "home", nome: "Home", icone: widgets.Icon(FontAwesomeIcons.home,size: Adapt.px(44)), page:Routes.routes.buildPage('homePage', null)),
    ItemMenu(id: "home_exemplo", nome: "Home", icone: widgets.Icon(FontAwesomeIcons.home,size: Adapt.px(44)), page:Routes.routes.buildPage('home_exemplo', null)),
    ItemMenu(id:"outros", nome: "Outros", icone: widgets.Icon(FontAwesomeIcons.tasks,size: Adapt.px(44)),page:Routes.routes.buildPage('discoverPage', null)),
    ItemMenu(id: "config",nome: "Configurações", icone: widgets.Icon(FontAwesomeIcons.confluence,size: Adapt.px(44)), disable: true, page:Routes.routes.buildPage('configPage', null))];

  static final PageRoutes routes = PageRoutes(
    pages: <String, Page<Object, dynamic>>{
      'startpage': StartPage(),
      'mainpage': MainPage(),
      'homePage': HomeComprasPage(),
      'home_exemplo': HomePage(),
      'discoverPage': DiscoverPage(),
      'configPage': ConfigPage(),
      'loginPage': LoginPage(),
      // list_compras: ListEntriesPage(),
      add_produto: AddProdutoPage()

    },
    visitor: (String path, Page<Object, dynamic> page) {
      if (page.isTypeof<GlobalBaseState>()) {
        page.connectExtraStore<GlobalState>(GlobalStore.store,
            (Object pagestate, GlobalState appState) {
          final GlobalBaseState p = pagestate;
          if (p.themeColor != appState.themeColor ||
              p.locale != appState.locale ||
              p.user != appState.user ||
              p.selectedIndexPage != appState.selectedIndexPage ||
              p.pages != appState.pages ||
              p.configPage != appState.configPage ||
              p.defaultTargetPlatformNative != appState.defaultTargetPlatformNative


          ) {
            if (pagestate is Cloneable) {
              final Object copy = pagestate.clone();
              final GlobalBaseState newState = copy;
              newState.themeColor = appState.themeColor;
              newState.locale = appState.locale;
              newState.user = appState.user;
              newState.selectedIndexPage = appState.selectedIndexPage;
              newState.pages = appState.pages;
              newState.configPage = appState.configPage;
              newState.defaultTargetPlatformNative = appState.defaultTargetPlatformNative;

              return newState;
            }
          }
          return pagestate;
        });
      }
      page.enhancer.append(
        /// View AOP
        viewMiddleware: <ViewMiddleware<dynamic>>[
          safetyView<dynamic>(),
        ],

        /// Adapter AOP
        adapterMiddleware: <AdapterMiddleware<dynamic>>[
          safetyAdapter<dynamic>()
        ],

        /// Effect AOP
        effectMiddleware: [
          _pageAnalyticsMiddleware<dynamic>(),
        ],

        /// Store AOP
        middleware: <Middleware<dynamic>>[
          logMiddleware<dynamic>(tag: page.runtimeType.toString()),
        ],
      );
    },
  );
}

EffectMiddleware<T> _pageAnalyticsMiddleware<T>() {
  return (AbstractLogic<dynamic> logic, Store<T> store) {
    return (Effect<dynamic> effect) {
      return (Action action, Context<dynamic> ctx) {
        if (logic is Page<dynamic, dynamic> && action.type is Lifecycle) {
          print('${logic.runtimeType} ${action.type.toString()} ');
        }
        return effect?.call(action, ctx);
      };
    };
  };
}
