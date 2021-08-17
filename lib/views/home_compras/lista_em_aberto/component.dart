import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:lista_compras/views/home_compras/lista_em_aberto/state.dart';


import 'effect.dart';
import 'reducer.dart';
import 'view.dart';


class ListaComprasEmAbertoComponent extends Component<ListaComprasAbertaState> {
  ListaComprasEmAbertoComponent({
  @required  view,
   reducer,
   filter,
    effect})
      : super(
          view: view==null ? buildView : view,
          effect: effect== null ? buildEffect(): effect,
          reducer: reducer == null ? buildReducer() :  reducer
        );
}


