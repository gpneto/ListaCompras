import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:lista_compras/globalbasestate/state.dart';
import 'package:lista_compras/models/app_user.dart';
import 'package:lista_compras/models/lista_compras.dart';
import 'package:lista_compras/widgets/menu_item.dart';
import 'package:lista_compras/widgets/target_platform_native.dart';

import 'report_component/component.dart';
import 'todo_component/component.dart';

class PageState extends MutableSource
    implements GlobalBaseState, Cloneable<PageState> {
  ListaCompra listaCompra;

  List<ToDoState> toDos;

  @override
  Color themeColor;

  @override
  PageState clone() {
    return PageState()
      ..listaCompra = listaCompra
      ..toDos = toDos
      ..themeColor = themeColor;
  }

  @override
  Object getItemData(int index) => toDos[index];

  @override
  String getItemType(int index) => 'toDo';

  @override
  int get itemCount => toDos?.length ?? 0;

  @override
  void setItemData(int index, Object data) => toDos[index] = data;

  @override
  bool configPage;

  @override
  TargetPlatformNative defaultTargetPlatformNative;

  @override
  Locale locale;

  @override
  List<ItemMenu> pages;

  @override
  int selectedIndexPage;

  @override
  AppUser user;
}

PageState initState(Map<String, dynamic> args) {
  ListaCompra listaCompra = args["lista"];
  return PageState()..listaCompra = listaCompra;
}

class ReportConnector extends ConnOp<PageState, ReportState>
    with ReselectMixin<PageState, ReportState> {
  @override
  ReportState computed(PageState state) {
    double valorTotal = 0;
    double valorEstimado = 0;
    int tamanhoMarcado = 0;
    int tamanho = 0;
    if (state.toDos != null && state.toDos.isNotEmpty) {
      Iterable valorTotalEstimadoList = state.toDos
          .where((ToDoState tds) => tds.ultimoValor != null)
          .map((e) => e.quantidade * e.ultimoValor);

      if (valorTotalEstimadoList.length > 0) {
        valorEstimado =
            valorTotalEstimadoList.reduce((value, element) => value + element);
      }

      Iterable valorTotalSelecionado =
          state.toDos.where((ToDoState tds) => tds.isDone);

      if (valorTotalSelecionado.length > 0) {
        valorTotal = valorTotalSelecionado
            .map((e) => e.valorComprado * e.quantidadeComprada)
            .reduce((value, element) => value + element);
      }

      tamanhoMarcado = state.toDos.where((ToDoState tds) => tds.isDone).length;

      tamanho = state.toDos.length;
    }

    return ReportState()
      ..done = tamanhoMarcado
      ..valorTotal = valorTotal
      ..total = tamanho
      ..valorEstimado = valorEstimado
      ..listaCompra = state.listaCompra
    ;
  }

  @override
  List<dynamic> factors(PageState state) {
    ReportState reportState = computed(state);
    return <Object>[
      reportState.valorEstimado,
      reportState.valorTotal,
      reportState.done,
      reportState.total,
      reportState.listaCompra
    ];
  }

  @override
  void set(PageState state, ReportState subState) {
    throw Exception('Unexcepted to set PageState from ReportState');
  }
}
