import 'package:fish_redux/fish_redux.dart';
import 'package:lista_compras/models/lista_compras.dart';
import 'todo_component/component.dart';

enum PageAction { initToDos, onAdd, onArquivarLista,onCompartilharLista }

class PageActionCreator {
  static Action initToDosAction(ListaCompra lista) {
    return Action(PageAction.initToDos, payload: lista);
  }

  static Action onAddAction() {
    return const Action(PageAction.onAdd);
  }


  static Action onArquivarLista() {
    return const Action(PageAction.onArquivarLista);
  }

  static Action onCompartilharLista() {
    return const Action(PageAction.onCompartilharLista);
  }

}
