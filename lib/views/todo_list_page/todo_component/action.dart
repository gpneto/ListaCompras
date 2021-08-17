import 'package:fish_redux/fish_redux.dart';
import 'package:lista_compras/models/item_lista_compra.dart';
import 'state.dart';

enum ToDoAction { onEdit, edit, done, onRemove, remove }

class ToDoActionCreator {
  static Action onEditAction(String uniqueId) {
    return Action(ToDoAction.onEdit, payload: uniqueId);
  }

  static Action editAction(ToDoState toDo) {
    return Action(ToDoAction.edit, payload: toDo);
  }

  static Action doneAction(ToDoState uniqueId) {
    return Action(ToDoAction.done, payload: uniqueId);
  }

  static Action onRemoveAction(String uniqueId) {
    return Action(ToDoAction.onRemove, payload: uniqueId);
  }

  static Action removeAction(ToDoState uniqueId) {
    return Action(ToDoAction.remove, payload: uniqueId);
  }
}
