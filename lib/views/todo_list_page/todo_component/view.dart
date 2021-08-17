import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lista_compras/models/item_lista_compra.dart';
import 'package:lista_compras/widgets/CurrencyInputFormatter.dart';
import 'package:lista_compras/widgets/CustomColors.dart';
import 'package:intl/intl.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(
  ToDoState state,
  Dispatch dispatch,
  ViewService viewService,
) {
  return Container(
    padding: const EdgeInsets.all(5.0),
    child: GestureDetector(
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.15,
        child: Container(
          margin: EdgeInsets.fromLTRB(1, 0, 1, 1),
          padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  height: 25,
                  decoration: BoxDecoration(
                    color: Theme.of(viewService.context).iconTheme.color,
                    shape: BoxShape.circle,
                  ),
                  child: FloatingActionButton(
                    backgroundColor: Colors.green,
                    onPressed: () {
                      if (state.isDone) {
                        dispatch(ToDoActionCreator.doneAction(state));
                      } else {
                        openAlertBoxEdit(
                            viewService.context, state, dispatch, false);
                      }
                    },
                    mini: true,
                    child: state.isDone
                        ? Icon(
                            Icons.check,
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 1, bottom: 1),
                            child: Container(
                                decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            )),
                          ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            state.produtoNome + ": ",
                            style: TextStyle(
                                color: CustomColors.TextHeader,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            state.quantidade.toString() + " " + state.medida,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: CustomColors.HeaderBlueDark,
                            ),
                          ),
                        ],
                      ),
                      state.ultimoValor != null
                          ? Text(
                              "${NumberFormat.currency(locale: "pt_BR", symbol: "R\$ ").format(state.ultimoValor)}",
                              style: TextStyle(color: CustomColors.TextGrey),
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
              Container(
                width: 80,
                child: state.isDone == true
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${state.quantidadeComprada} x ${state.valorComprado.toString()} ",
                            style: TextStyle(color: CustomColors.TextGrey),
                          ),
                          Text(
                            "${NumberFormat.currency(locale: "pt_BR", symbol: "R\$ ").format(state.quantidadeComprada * state.valorComprado)}",
                            style: TextStyle(color: CustomColors.TextGrey),
                          )
                        ],
                      )
                    : Container(),
              )
            ],
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              stops: [0.015, 0.015],
              colors: [
                state.isDone
                    ? CustomColors.GreenIcon
                    : CustomColors.HeaderBlueDark,
                Colors.white
              ],
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
            boxShadow: [
              BoxShadow(
                color: CustomColors.GreyBorder,
                blurRadius: 10.0,
                spreadRadius: 5.0,
                offset: Offset(0.0, 0.0),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          SlideAction(
            child: Container(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: CustomColors.TrashRedBackground),
                child: Image.asset('images/trash.png'),
              ),
            ),
            onTap: () =>
                dispatch(ToDoActionCreator.onRemoveAction(state.uniqueId)),
          ),
          SlideAction(
            child: Container(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: CustomColors.BlueIcon),
                child: Icon(
                  Icons.edit,
                ),
              ),
            ),
            onTap: () => {
            openAlertBoxEdit( viewService.context, state, dispatch, true)
          },
          )
        ],
      ),
      onLongPress: () {
        openAlertBoxEdit(viewService.context, state, dispatch, true);
      },
    ),
  );
}

Color myColor = Color(0xff00bfa5);

openAlertBoxEdit(
    BuildContext context, ToDoState itemProduto, Dispatch dispatch, bool edit) {
  TextEditingController controllerQuantidadeCadastrada =
      TextEditingController(text: itemProduto.quantidade.toString());

  TextEditingController controllerQuantidadeComprada =
      TextEditingController(text: edit ? itemProduto.quantidadeComprada?.toString() : itemProduto.quantidade.toString());

  double valorCompra = 0;

  if(itemProduto.valorComprado != null  ){
    valorCompra = itemProduto.valorComprado?.toDouble();
  }else{
    if(!edit && itemProduto.ultimoValor !=null){
      valorCompra =  itemProduto.ultimoValor;
    }
  }

  TextEditingController controllerValor = TextEditingController(
      text: NumberFormat.compactCurrency(locale: "pt_Br", symbol: "")
          .format(valorCompra));

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: 300.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      itemProduto.produtoNome,
                      style: TextStyle(fontSize: 24.0),
                    ),
                    Text(
                      itemProduto.quantidade.toString(),
                      style: TextStyle(fontSize: 24.0),
                    )
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Divider(
                  color: Colors.grey,
                  height: 4.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10),
                  child: Column(
                    children: [
                      edit
                          ? Column(children: [
                              Text(
                                "Quantidade Cadastro",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: CustomColors.TextSubHeader),
                              ),
                              TextFormField(
                                controller: controllerQuantidadeCadastrada,
                                keyboardType: TextInputType.number,
                              )
                            ])
                          : Container(),
                      !itemProduto.isDone && edit
                          ? Container()
                          : Column(children: [
                              Text(
                                "Quantidade Comprada",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: CustomColors.TextSubHeader),
                              ),
                              TextFormField(
                                controller: controllerQuantidadeComprada,
                                keyboardType: TextInputType.number,
                              ),
                              Text(
                                "Valor",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: CustomColors.TextSubHeader),
                              ),
                              TextFormField(
                                controller: controllerValor,
                                decoration: InputDecoration(prefixText: "R\$ "),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  // Fit the validating format.
                                  //fazer o formater para dinheiro
                                  CurrencyInputFormatter()
                                ],
                              ),
                            ]),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    if(itemProduto.isDone || !edit) {
                      itemProduto.quantidadeComprada =
                          int.tryParse(controllerQuantidadeComprada.value.text);
                      itemProduto.valorComprado = double.tryParse(
                          controllerValor.value.text.replaceAll(",", "."));
                    }
                    if(edit) {
                      itemProduto.quantidade =
                          int.parse(controllerQuantidadeCadastrada.value.text);
                      dispatch(ToDoActionCreator.editAction(itemProduto));
                    }else {
                      dispatch(ToDoActionCreator.doneAction(itemProduto));
                    }

                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    decoration: BoxDecoration(
                      color: myColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(32.0),
                          bottomRight: Radius.circular(32.0)),
                    ),
                    child: Text(
                      "Salvar",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
