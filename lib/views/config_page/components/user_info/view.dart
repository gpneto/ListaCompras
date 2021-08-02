import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/actions/adapt.dart';
import 'package:lista_compras/views/config_page/action.dart';
import 'package:lista_compras/widgets/info_list_section.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(UserInfoState state, Dispatch dispatch, ViewService viewService) {

  Widget buildViewImage(
      UserInfoState state, Dispatch dispatch, ViewService viewService) {


    if (state.user?.firebaseUser?.photoURL == null ) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child:Image.asset(
          "images/c3po.png",
          height: 36.0,
          width: 36.0,
          fit: BoxFit.contain,
        ),
      );

    }

    return Container(
      width: Adapt.px(100),
      height: Adapt.px(100),
      decoration: BoxDecoration(
        color: Color(0xFF8499FD),
        shape: BoxShape.circle,
        image: state.user?.firebaseUser?.photoURL != null
            ? DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(
              state.user?.firebaseUser?.photoURL?.replaceFirst("s96-c","s300-c")),
        )
            : null,
      ),
    );


  }


  Size screenSize = MediaQuery
      .of(viewService.context)
      .size;
  final Orientation orientation = MediaQuery
      .of(viewService.context)
      .orientation;

  Animation<double> animation =  new CurvedAnimation(
    parent: state.screenController,
    curve: Curves.easeIn,
  );




  return InfoListSection(
    title: 'Usuário',
//                      imagePath: 'assets/info_backgrounds/bg_1.png',
    child: AnimatedBuilder(
      animation: state.screenController,
      builder: (_, __) {
        return Stack(
      children: <Widget>[
        state.user?.firebaseUser == null ? Container():
        (new Container(
            width: screenSize.width,
            height: 300,
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.grey, Colors.grey[100]],
              ),
            ),
            child: new Container(
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                    colors: <Color>[
                      const Color.fromRGBO(110, 101, 103, 0.6),
                      const Color.fromRGBO(51, 51, 63, 0.9),
                    ],
                    stops: [0.2, 1.0],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.0, 1.0),
                  )),
              child: Stack(
                children: <Widget>[
                  Positioned(
                      child: Align(
                          alignment: FractionalOffset.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Text(
                                state.user?.firebaseUser?.displayName,
                                style: new TextStyle(
                                    fontSize: 25.0,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                              ),

                              Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 200,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        CircularProgressIndicator(),
                                        Container(
                                            width: animation.value * 180,
                                            height: animation.value * 180,
                                            decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: new ExactAssetImage('images/c3po.png'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            child: buildViewImage(state,dispatch,viewService)
                                        ),
                                        Positioned(
                                          bottom: 12,
                                          right: 12,
                                          child: Container(
                                            width: animation.value * 50,
                                            height: animation.value * 50,
                                            child: AnimatedSwitcher(
                                              // child: _buildPictureIconButton(context, vm) ?? SizedBox.shrink(),
                                              duration: Duration(milliseconds: 200),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),


                              new OutlineButton(
                                shape: StadiumBorder(),
                                textColor: Colors.blue,
                                child: Text('Sair'),
                                borderSide: BorderSide(
                                    color: Colors.blue, style: BorderStyle.solid,
                                    width: 1),
                                onPressed: () => dispatch(ConfigPageActionCreator.onLogout()),
                              )
                            ],
                          ))),
                  Positioned(
                    child: Align(
                      alignment: FractionalOffset.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: Text(
                          "Versão 1",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ))),

      ],
    );
  },
    )
);
}
