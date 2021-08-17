import 'package:fish_redux/fish_redux.dart';
import 'package:lista_compras/models/produto.dart';
import 'package:lista_compras/views/todo_list_page/todo_component/component.dart';

//TODO replace with your own action
enum AddProdutoAction { selectProduto, addProduto, setListaProdutos }

class AddProdutoActionCreator {
  static Action selectProduto(Produto p) {
    return  Action(AddProdutoAction.selectProduto, payload: p);
  }

  static Action adicionarProdutoLista(ToDoState p) {
    return  Action(AddProdutoAction.addProduto, payload: p);
  }

  static Action setListaProdutos(List<Produto> p) {
    return  Action(AddProdutoAction.setListaProdutos, payload: p);
  }
}
