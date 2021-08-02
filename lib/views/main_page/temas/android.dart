import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart' as f;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/actions/adapt.dart';
import 'package:lista_compras/app.dart';
import 'package:lista_compras/generated/i18n.dart';
import 'package:lista_compras/globalbasestate/action.dart';
import 'package:lista_compras/globalbasestate/store.dart';
import 'package:lista_compras/routes/routes.dart';
import 'package:lista_compras/views/config_page/page.dart';
import 'package:lista_compras/views/main_page/state.dart';
import 'package:lista_compras/widgets/keepalive_widget.dart';
import 'package:lista_compras/widgets/menu_item.dart';
import 'package:lista_compras/widgets/target_platform_native.dart';


Widget buildViewAndroid(
    MainPageState state, f.Dispatch dispatch, f.ViewService viewService) {

  return Builder(
    builder: (context) {
      Adapt.initContext(context);






      return _buildMenuLateral(state: state,);
    },
  );
}


class _buildMenuLateral extends StatefulWidget {
  final MainPageState state;

  const _buildMenuLateral({Key key, this.state}) : super(key: key);

  @override
  __buildMenuLateralState createState() => __buildMenuLateralState();
}

class __buildMenuLateralState extends State<_buildMenuLateral> {

  int indexState = 0;
  @override
  void initState() {

    super.initState();
  }

  _onSelectItem(int index) {

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {

     indexState = widget.state.configPage ? widget.state.pages.indexWhere((element) => element.id == "config") :
    widget.state.selectedIndexPage == null ? 0 : widget.state.selectedIndexPage;

    List<Widget> menus = [
      DrawerHeader(
        decoration: BoxDecoration(color: Colors.green),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
//             StoreConnector<AppState, UserScreenViewModel>(
//               builder: ((context, vm) {
//                 return
                Column(
                  children: <Widget>[
                    new Text(
                      widget.state.user?.firebaseUser?.displayName,
                      style: new TextStyle(
                          fontSize: 20.0,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        Container(
                          child: Container(
                            width: Adapt.px(100),
                            height: Adapt.px(100),
                            decoration: BoxDecoration(
                              color: Color(0xFF8499FD),
                              shape: BoxShape.circle,
                              image: widget.state.user?.firebaseUser?.photoURL != null
                                  ? DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                    widget.state.user?.firebaseUser?.photoURL?.replaceFirst("s96-c","s300-c")),
                              )
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

            OutlineButton(
              shape: StadiumBorder(),
              textColor:
              defaultTargetPlatformNative == TargetPlatformNative.android
                  ? Colors.white
                  : Colors.blue,
              child: Text('Sair'),
              borderSide: BorderSide(
                  color: defaultTargetPlatformNative ==
                      TargetPlatformNative.android
                      ? Colors.white
                      : Colors.blue,
                  style: BorderStyle.solid,
                  width: 1),
              onPressed: () {
                FirebaseAuth.instance.signOut();

                GlobalStore.store.dispatch(GlobalActionCreator.setUser(null));

                //Rediciona para tela de Login

                 Navigator.of(context).pushReplacement(PageRouteBuilder(
                    pageBuilder: (_, __, ___) {
                      return Routes.routes.buildPage('loginPage', null);
                    },
                    settings: RouteSettings(name: 'mainpage')));
              },
            )
          ],
        ),
      )
    ];


    menus.addAll(widget.state.pages.asMap().entries.map((entry) {

      ItemMenu menuitem = entry.value;
      int idx = entry.key;
        return ListTile(
            title: Text(menuitem.nome, style: TextStyle(
                fontSize: 16.0,
                color: Theme.of(context).textTheme.bodyText1.color
            ),
            ),

            selectedTileColor: Colors.blue.withOpacity(0.5),
            leading: Icon(menuitem.icone.icon, color: Theme.of(context).textTheme.bodyText1.color,),


            selected: idx == indexState,
            onTap: () {
              GlobalStore.store.dispatch(GlobalActionCreator.onTabChanged(idx));
              _onSelectItem(idx);
            });

    }).toList());

    return Scaffold(
      // appBar: new AppBar(
      //   title: new Text(widget.state.pages[indexState].nome),
      // ),
      drawer: Drawer(
        child: ListView(padding: EdgeInsets.zero, children: menus),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return widget.state.pages[indexState].page;
  }
}