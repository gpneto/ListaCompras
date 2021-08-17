import 'package:ai_progress/ai_progress.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lista_compras/widgets/CustomColors.dart';
import 'state.dart';

Widget buildView(
  ReportState state,
  Dispatch dispatch,
  ViewService viewService,
) {


  Size size = MediaQuery.of(viewService.context).size;

  String font = GoogleFonts.mcLaren().fontFamily;

  if(state.listaCompra.nome == null){
    return Container(child: CircularProgressIndicator(),);
  }

  return Container(
    padding: EdgeInsets.all(5),
    child: Column(
      children: <Widget>[
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  state.listaCompra.nome,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: size.width * 0.055,
                      fontFamily: font),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.green,
                      //                   <--- border color
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withAlpha(70),
                          offset: const Offset(1.0, 5.0),
                          blurRadius: 10.0)
                    ]),
                child: Padding(
                  padding:
                  const EdgeInsets.only(left: 7, right: 7),
                  child: Text(
                    DateFormat('dd/MM/yyy')
                        .format(state.listaCompra.data.toDate()),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: size.width * 0.035,
                      fontFamily: font,
                    ),
                  ),
                ),
              ),
            ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Itens (${state.done}/${state.total})",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: size.width * 0.035,
                  fontFamily: font),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45),
                          bottomLeft: Radius.circular(45),
                          topRight: Radius.circular(45),
                          bottomRight: Radius.circular(45),
                        )),
                  ),
                  width: 200,
                  height: 15.0,
                  child: state.total == 0 ? Container() : AirStepStateProgressIndicator(
                    size: Size(20, 20),
                    stepCount: state.total,
                    stepValue: state.done,
                    valueColor: CustomColors.GreenAccent,
                    pathColor:  CustomColors.GreenShadow,
                    pathStrokeWidth: 30.0,
                    valueStrokeWidth: 30.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        state
            .listaCompra.listaCompraUsuario.compartilhadoCom != null ? Row(
          children: [
            FaIcon(
              FontAwesomeIcons.users,
              size: 12,
            ),
            Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text( state
                    .listaCompra.listaCompraUsuario.compartilhadoCom.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: size.width * 0.035,
                      fontFamily: font,
                    )))
          ],
        ) : Container(),
        state.listaCompra.listaCompraUsuario.compartilhadoDe != null ?   Row(children: [Text(
          "Compartilhado de ${state.listaCompra.listaCompraUsuario
              .compartilhadoDe}",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: size.width * 0.035,
            fontFamily: font,
          ),
        )]) : Container(),
        Row(children: [
          Text(
            "Valor estimado: ${NumberFormat.currency(locale: "pt_BR", symbol: "R\$ ").format(state.valorEstimado)}",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: size.width * 0.035,
              fontFamily: font,
            ),
          )
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              child: Text(
                NumberFormat.currency(locale: "pt_BR", symbol: "R\$ ").format(state.valorTotal),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: size.width * 0.035,
                  fontFamily: font,
                ),
              ),
            )
          ],
        )
      ],
    ),
  );
}
