import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:lista_compras/models/item_lista_compra.dart';
import 'package:lista_compras/models/lista_compra_usuario.dart';
import 'package:lista_compras/models/lista_compras.dart';
import 'package:lista_compras/models/produto.dart';
import 'package:lista_compras/views/home_compras/action.dart';
import 'package:lista_compras/views/todo_list_page/state.dart';
import 'package:lista_compras/views/todo_list_page/todo_component/component.dart';

class FirebaseServiceDados {
  void listaComprarEmAbertoFromFirebase(Context ctx) {
    print("Verifica lista de usuarios do servidor!");
  }

  void listaComprarFinalizadasFromFirebase(Context ctx) {
    print("Verifica lista de usuarios do servidor!");
    ctx.dispatch(HomeComprasActionCreator.finalizouBuscaListaFinalizadas([]));
  }

  static Stream<List<ListaCompra>> consultaListaComprasDoUsuarioFirebase() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .snapshots()
        .asyncMap((snap) async {
      List<dynamic> groceryListsArr = snap.get("lista_compras");

      var groceryList = <ListaCompra>[];
      for (var groceryPath in groceryListsArr) {
        DocumentSnapshot dadosLista = (await groceryPath.get());
        groceryList.add(ListaCompra(
            id: dadosLista.id,
            nome: dadosLista.get("nome"),
            data: dadosLista.get("data"),
            totalProdutos: dadosLista.get("total_itens"),
            totalSeledcionados: dadosLista.get("total_selecionado")));
      }
      return groceryList;
    });
  }

  static Stream<QuerySnapshot<Map>>
      consultaReferenciaListaComprasDoUsuarioFirebase() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("lista_compras_usuarios")
        .snapshots();
  }

  static Stream<DocumentSnapshot<Map>> consultaListaComprasFirebase(
      String idLista) {
    return FirebaseFirestore.instance
        .collection('lista_compras')
        .doc(idLista)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map>> consultaProdutosFirebase() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("produtos")
        .snapshots();
  }

  static saveUserFirebase(User user) {
    FirebaseFirestore.instance.collection("users").doc(user.uid).set({
      "displayName": user.displayName,
      "photoURL": user.photoURL,
      "email": user.email
    }, SetOptions(merge: true));
  }

  static saveProdutoLista(ToDoState toDoState) {
    FirebaseFirestore.instance
        .collection("lista_compras")
        .doc(toDoState.idLista)
        .collection("produtos")
        .doc(toDoState.uniqueId)
        .set({
      "selecionado": toDoState.isDone,
      "valorCompra": toDoState.valorComprado,
      "quantidadeComprada": toDoState.quantidadeComprada,
      "quantidade": toDoState.quantidade,
    }, SetOptions(merge: true));

    atualizaContadorLista(toDoState.idLista);
  }

  static Future<Produto> saveProdutoNoUsuario(ToDoState produto) async {
    DocumentReference doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("produtos")
        .add({
      "medida": produto.medida,
      "nome": produto.produtoNome,
      "valor": produto.ultimoValor
    });
    Map dadosFirebase = (await doc.get()).data();
    return Produto(
        id: doc.id,
        medida: dadosFirebase["medida"],
        produtoNome: dadosFirebase["nome"],
        ultimoValor: double.tryParse(dadosFirebase["valor"].toString()));
  }

  static Future<void> saveProdutoNaLista(ToDoState produto) async {
    await FirebaseFirestore.instance
        .collection("lista_compras")
        .doc(produto.idLista)
        .collection("produtos")
        .doc(produto.uniqueId)
        .set({
      "medida": produto.medida,
      "nome": produto.produtoNome,
      "valor": produto.ultimoValor,
      "quantidade": produto.quantidade
    }, SetOptions(merge: true));

    atualizaContadorLista(produto.idLista);

    return;
  }

  static Future<void> removerProdutoDaLista(ToDoState produto) async {
    await FirebaseFirestore.instance
        .collection("lista_compras")
        .doc(produto.idLista)
        .collection("produtos")
        .doc(produto.uniqueId)
        .delete();

    atualizaContadorLista(produto.idLista);

    return;
  }

  static Future<void> atualizaContadorLista(String idLista) async {
    QuerySnapshot todos = await FirebaseFirestore.instance
        .collection("lista_compras")
        .doc(idLista)
        .collection("produtos")
        .get();

    QuerySnapshot selecionados = await FirebaseFirestore.instance
        .collection("lista_compras")
        .doc(idLista)
        .collection("produtos")
        .where("selecionado", isEqualTo: true)
        .get();

    await FirebaseFirestore.instance
        .collection("lista_compras")
        .doc(idLista)
        .set({
      "total_itens": todos.docs.length,
      "total_selecionado": selecionados.docs.length
    }, SetOptions(merge: true));
    return;
  }

  static Future<DocumentReference<Object>> addNovaListaNoUsuario(
      String nome) async {
    DocumentReference doc = await FirebaseFirestore.instance
        .collection("lista_compras")
        .add({"nome": nome, "data": Timestamp.now()});

    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("lista_compras_usuarios")
        .add(ListaCompraUsuario.fromParams(
                data: Timestamp.now(), documentReference: doc)
            .toMap());

    return doc;
  }

  static arquivarListaCompra(ListaCompra listaCompra) async {
    await listaCompra.listaCompraUsuario.refListaUsuario.update({"finalizado": true});
  }

  static Future<bool> compartilharLista(PageState lista, String email) async {
    QuerySnapshot user = await FirebaseFirestore.instance
        .collection('users')
        .where("email", isEqualTo: email)
        .get();

    if (user.size == 0) {
      return false;
    } else {
      await user.docs.first.reference.collection("lista_compras_usuarios").add(
          ListaCompraUsuario.fromParams(
                  data: lista.listaCompra.data,
                  documentReference: FirebaseFirestore.instance
                      .collection("lista_compras")
                      .doc(lista.listaCompra.id),
                  compartilhadoDe: FirebaseAuth.instance.currentUser.email)
              .toMap());

      lista.listaCompra.listaCompraUsuario.refListaUsuario.set({
        "compartilhado_com": FieldValue.arrayUnion([email])
      }, SetOptions(merge: true));

      return true;
    }
  }
}
