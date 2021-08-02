
import 'package:flutter/widgets.dart';

class ItemMenu {
  String id;
  String nome;
  Icon icone;
  bool disable ;
  Widget page;

  ItemMenu({this.id, this.nome, this.icone, this.disable:false, this.page});
}
