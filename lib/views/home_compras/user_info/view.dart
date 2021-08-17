import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/actions/adapt.dart';
import 'package:lista_compras/views/config_page/action.dart';
import 'package:lista_compras/widgets/CustomColors.dart';
import 'package:lista_compras/widgets/gradient_app_bar.dart';
import 'package:lista_compras/widgets/info_list_section.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(UserInfoState state, Dispatch dispatch, ViewService viewService) {

    return GradientAppBar(
        flexibleSpace: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CustomPaint(
              painter: CircleOne(),
            ),
            CustomPaint(
              painter: CircleTwo(),
            ),
          ],
        ),
        title: Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Olá ${state.user?.firebaseUser?.displayName.split(" ")[0]}',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              Text(
                'Você possiu ${state.totalListaAberto} listas de Compras em Aberto',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 20, 0),
            child: Container(
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
            )
          ),
        ],
        elevation: 0,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [CustomColors.HeaderBlueDark, CustomColors.HeaderBlueLight],
        ),

      );


}

class CircleOne extends CustomPainter {
  Paint _paint;

  CircleOne() {
    _paint = Paint()
      ..color = CustomColors.HeaderCircle
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(28.0, 0.0), 99.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CircleTwo extends CustomPainter {
  Paint _paint;

  CircleTwo() {
    _paint = Paint()
      ..color = CustomColors.HeaderCircle
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(-30, 20), 50.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
