import 'dart:math';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'package:lista_compras/data/FirebaseServiceDados.dart';
import 'package:lista_compras/models/produto.dart';
import 'package:lista_compras/views/todo_list_page/todo_component/component.dart';
import 'package:lista_compras/widgets/CustomColors.dart';
import 'package:lista_compras/widgets/autocomplete_textfield.dart';
import 'package:intl/intl.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(
    AddProdutoState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
      drawer: Scaffold.hasDrawer(viewService.context)
          ? Scaffold.of(viewService.context).widget.drawer
          : null,
      appBar: AppBar(
        title: Container(
          // width: 100,
          child: Row(
            children: [
              Expanded(
                child: AutoCompleteTextField<Produto>(
                  controller: state.autoCompleteController,
                  decoration: new InputDecoration(
                      hintText: "Nome do Produto",
                      suffixIcon: new Icon(Icons.search)),
                  itemSubmitted: (item) =>
                      dispatch(AddProdutoActionCreator.selectProduto(item)),
                  key: GlobalKey(),
                  suggestions: state.produtosCadastrados ?? [],
                  itemBuilder: (context, suggestion) => new Padding(
                      child: new ListTile(
                          title: new Text(suggestion.produtoNome),
                          trailing: new Text(
                              "${suggestion.ultimoValor == null ? "" :
                              NumberFormat
                                  .currency(locale: "pt_BR", symbol: "R\$ ").format(suggestion.ultimoValor)}")),
                      padding: EdgeInsets.all(8.0)),
                  itemSorter: (a, b) => a.produtoNome.compareTo(b.produtoNome),
                  itemFilter: (suggestion, input) => suggestion.produtoNome
                      .toLowerCase()
                      .startsWith(input.toLowerCase()),
                ),
              ),
              Container(
                height: 25,
                decoration: BoxDecoration(
                  color: Theme.of(viewService.context).iconTheme.color,
                  shape: BoxShape.circle,
                ),
                child: FloatingActionButton(
                    backgroundColor: Colors.green,
                    heroTag: 'event_availableTG',
                    onPressed: () {
                      dispatch(AddProdutoActionCreator.selectProduto(Produto(
                          produtoNome:
                              state.autoCompleteController.value.text)));
                    },
                    mini: true,
                    child: Icon(
                      Icons.add,
                    )),
              )
            ],
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            state.produto != null
                ? produtoSelecionadoView(state, dispatch)
                : Container()
          ],
        ),
      ));
}

Widget produtoSelecionadoView(AddProdutoState state, Dispatch dispatch) {
  TextEditingController nomeController =
      TextEditingController(text: state.produto.produtoNome);

  TextEditingController medidaController =
      TextEditingController(text: state.produto.medida);

  TextEditingController ultimoValorController =
      TextEditingController(text: state.produto.ultimoValor?.toString());

  TextEditingController quantidadeController = TextEditingController();

  return Column(
    children: [
      Text(
        "Nome Produto",
        style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: CustomColors.TextSubHeader),
      ),
      TextFormField(
        controller: nomeController,
        readOnly: state.produto.uniqueId != null,
      ),
      Text(
        "Unidade Media",
        style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: CustomColors.TextSubHeader),
      ),
      TextFormField(
        controller: medidaController,
        keyboardType: TextInputType.number,
        readOnly: state.produto.uniqueId != null,
      ),
      Text(
        "Valor",
        style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: CustomColors.TextSubHeader),
      ),
      TextFormField(
        controller: ultimoValorController,
        keyboardType: TextInputType.number,
        readOnly: state.produto.uniqueId != null,
      ),
      Text(
        "Quantidade",
        style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: CustomColors.TextSubHeader),
      ),
      TextFormField(
        controller: quantidadeController,
        keyboardType: TextInputType.number,
      ),
      InkWell(
        onTap: () {
          state.produto.produtoNome = nomeController.value.text;
          state.produto.ultimoValor =  double.tryParse(ultimoValorController
              .value.text);
          state.produto.medida = medidaController.value.text;
          state.produto.quantidade = int.tryParse(quantidadeController.value
              .text);
          // state.produto.idLista = state.idLista;

          dispatch(AddProdutoActionCreator.adicionarProdutoLista(state.produto));
        },
        child: Container(
          width: 200,
          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32.0),
                bottomRight: Radius.circular(32.0)),
          ),
          child: Text(
            "Adicionar",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      )
    ],
  );
}

