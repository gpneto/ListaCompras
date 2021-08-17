import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';

class ListaCompraUsuario {

  DocumentReference refListaUsuario;
  DocumentReference documentReference;
  Timestamp data;
  bool finalizado;

  List compartilhadoCom;
  String compartilhadoDe;



  ListaCompraUsuario({this.refListaUsuario, this.documentReference,this.data, this.finalizado, this
      .compartilhadoCom, this
      .compartilhadoDe});


  ListaCompraUsuario.fromParams(
      {this.documentReference, this.data, this.finalizado = false,this
          .compartilhadoCom, this.compartilhadoDe});


  ListaCompraUsuario.fromJson(DocumentReference  refListaUsuario, Map dados) {
    this.refListaUsuario = refListaUsuario;
    this.documentReference = dados['lista'];
    this.data = dados['data'];
    this.finalizado = dados['finalizado'];
    this.compartilhadoCom = dados['compartilhado_com'];
    this.compartilhadoDe = dados['compartilhado_de'];
  }

  // @override
  // String toString() {
  //   return '{"data": $data,"finalizado": $finalizado,"documentReference": '
  //       '$documentReference}';
  // }

  Map<String, dynamic> toMap() {
    return {"data": data,  "finalizado": finalizado,
      "lista":documentReference, "compartilhado_de":  this.compartilhadoDe};
  }

}