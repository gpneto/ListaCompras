import 'package:fish_redux/fish_redux.dart' as f;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lista_compras/actions/adapt.dart';
import 'package:lista_compras/app.dart';
import 'package:lista_compras/generated/i18n.dart';
import 'package:lista_compras/globalbasestate/action.dart';
import 'package:lista_compras/globalbasestate/store.dart';
import 'package:lista_compras/routes/routes.dart';
import 'package:lista_compras/views/config_page/page.dart';
import 'package:lista_compras/views/main_page/state.dart';
import 'package:lista_compras/widgets/keepalive_widget.dart';


import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:lista_compras/widgets/target_platform_native.dart';


Widget buildViewCuston(
    MainPageState state, f.Dispatch dispatch, f.ViewService viewService) {

  return KeepAliveWidget(_buildAppHomePage(state: state));
}


class _buildAppHomePage extends StatefulWidget {
  final MainPageState state;

  const _buildAppHomePage({Key key, this.state}) : super(key: key);

  @override
  __buildAppHomePageState createState() => __buildAppHomePageState();
}

class __buildAppHomePageState extends State<_buildAppHomePage> {

  CircularBottomNavigationController _navigationController;
  int selectedPos = 0;
  bool configPage = false;

  @override
  void initState() {
    print('Abrindo a Tela Principal:' + DateTime.now().toString());

    _navigationController = new CircularBottomNavigationController(configPage ? widget.state.pages.indexWhere((element) => element.id == "config") :
    selectedPos) ;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    CircularBottomNavigation bottomNav() {
      return CircularBottomNavigation(
        // UniqueKey(),
        widget.state.pages
            .map((menuItem) => TabItem(
            FontAwesomeIcons.solidCalendarAlt,
            menuItem.nome, Colors.red,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 13
            )))
            .toList(),
        controller: _navigationController,
        barHeight: 75,
        barBackgroundColor: Colors.white,
        selectedPos:  configPage ? widget.state.pages.indexWhere((element) => element.id == "config") :
        selectedPos,
        animationDuration: Duration(milliseconds: 300),
        selectedCallback: (int selectedPos) {
          GlobalStore.store.dispatch(GlobalActionCreator.onTabChanged(selectedPos));
          setState(() {
          this.selectedPos = selectedPos;
          });
        },
      );
    }

    Widget bodyContainer() {
      return Padding(
        padding: EdgeInsets.only(
            bottom:
            defaultTargetPlatformNative == TargetPlatformNative.app ? 40 : 0),
        child: widget.state.pages[configPage ? widget.state.pages.indexWhere((element) => element.id == "config") :
        selectedPos].page,
      );
    }

    return Builder(
      builder: (context) {
        Adapt.initContext(context);

        Widget _buildPage(Widget page) {
          return KeepAliveWidget(page);
        }


        return Scaffold(

          body: Stack(
            children: <Widget>[
              bodyContainer(),
              Align(alignment: Alignment.bottomCenter, child: bottomNav()),
            ],
          ),
        );
      },
    );
  }
}