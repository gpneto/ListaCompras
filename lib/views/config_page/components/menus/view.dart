import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/app.dart';
import 'package:lista_compras/globalbasestate/action.dart';
import 'package:lista_compras/globalbasestate/store.dart';
import 'package:lista_compras/routes/routes.dart';
import 'package:lista_compras/widgets/info_list_section.dart';
import 'package:lista_compras/widgets/prefs.dart';
import 'package:lista_compras/widgets/target_platform_native.dart';
import 'action.dart';
import 'state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:lista_compras/widgets/reorderable_list.dart' as r;

Widget buildView(MenusState state, Dispatch dispatch, ViewService viewService) {
  return InfoListSection(
      title: 'Menus',
      child: _MenusSistema(
        contextPai: viewService.context,
      ));
}

class _MenusSistema extends StatefulWidget {
  final BuildContext contextPai;

  const _MenusSistema({Key key, this.contextPai}) : super(key: key);

  @override
  _MenusSistemaState createState() => _MenusSistemaState();
}

enum DraggingMode {
  iOS,
  Android,
}

class _MenusSistemaState extends State<_MenusSistema> {
  @override
  void initState() {
    super.initState();
    Prefs.singleton().addListenerForPref(
        Prefs.MENUS_DISABLED_PREF, changeListenerMenu,
        executar: false);
  }

  PrefsListener changeListenerMenu(String key, Object value) {
    if (mounted) {
      setState(() {
        montaMenus(value, context);
      });
    }
  }

  bool pimeiroAcesso = true;

  void montaMenus(Object value, BuildContext context) {
    menus = [];

    List ordemMenus = Prefs.singleton().getOrdemMenu();

    Routes.menuItens.asMap().forEach((index, menuItem) {
      String menuStr = menuItem.nome;
      String id = menuItem.id;

      int index_inicial = ordemMenus.indexWhere((d) => d == id);
      List menusD = value;
      var menuTarefas = CupertinoSwitch(
        value: menusD == null || menusD.where((t) => t == id).length == 0,
        onChanged: menuItem.disable
            ? null
            : (bool value) {
                if (mounted) {
                  if (value) {
                    Prefs.singleton().setTheme(Prefs.singleton().getTheme());
                    Prefs.singleton().setMenuDisabledRemove(id);
                  } else {
                    if (verificaQuantosMenusAtivos(id)) {
                      Prefs.singleton().setTheme(Prefs.singleton().getTheme());
                      Prefs.singleton().setMenuDisabled(id);
                    } else {
                if (defaultTargetPlatformNative ==
                    TargetPlatformNative.android) {
//
                  showDialog<void>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Atenção'),
                        content: _logoutMessage,
                        actions: [
                          FlatButton(
                            child: const Text('OK'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      );
                    },
                  );

                }else{
                      showCupertinoModalPopup<void>(
                        context: context,
                        builder: (context) {
                          return CupertinoActionSheet(
                            title: Text('Atenção'),
                            message: _logoutMessage,
                            cancelButton: CupertinoActionSheetAction(
                              child: const Text('OK'),
                              isDefaultAction: true,
                              onPressed: () => Navigator.pop(context),
                            ),
                          );
                        },
                      );
                      }
                    }
                  }
                }
              },
      );

      var menuTarefasColumn = Column(
        key: ValueKey(index),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Routes.menuItens[index].icone,
              Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(left: 10),
                  child: Builder(builder: (context1) {
                    return Text(
                      menuStr,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Theme.of(context1).textTheme.bodyText1.color),
                    );
                  })),
              Expanded(
                child: Container(),
              ),
              menuTarefas
            ],
          ),
          SizedBox(height: 20.0),
        ],
      );

      menus.add(
        Item(
            key: ValueKey(index),
            data: menuTarefasColumn,
            nome: menuStr,
            id: id,
            // first and last attributes affect border drawn during dragging
            isFirst: index == 0,
            isLast: index == menus.length - 1,
            draggingMode: _draggingMode,
            ordem: index_inicial == -1 ? index : index_inicial),
      );
    });

    menus.sort((a, b) => a.ordem.compareTo(b.ordem));
  }

  static const _logoutMessage = Text('Pelo menos 1 menu deve estar ativo');

  bool verificaQuantosMenusAtivos(String title) {
    //Adiciona 2 porque é o menu novo a ser disabilitado + o Menu Conf
    if (Prefs.singleton().getMenusDisabled().where((t) => t != title).length +
            2 ==
        Routes.menuItens.length) {
      return false;
    }

    return true;
  }

  List<Item> menus = [];

  // Returns index of item with given key
  int _indexOfKey(Key key) {
    return menus.indexWhere((Widget d) => d.key == key);
  }

  bool _reorderCallback(Key item, Key newPosition) {
    int draggingIndex = _indexOfKey(item);
    int newPositionIndex = _indexOfKey(newPosition);

    // Uncomment to allow only even target reorder possition
    // if (newPositionIndex % 2 == 1)
    //   return false;

    final draggedItem = menus[draggingIndex];
    setState(() {
      debugPrint("Reordering $item -> $newPosition");
      menus.removeAt(draggingIndex);
      menus.insert(newPositionIndex, draggedItem);
    });
    return true;
  }

  void _reorderDone(Key item) {
    final draggedItem = menus[_indexOfKey(item)];
    Prefs.singleton().setOrdemMenu(menus.map((f) => f.id).toList());
    Prefs.singleton().setTheme(Prefs.singleton().getTheme());
    debugPrint("Reordering finished for ${draggedItem.key}}");
  }

  //
  // Reordering works by having ReorderableList widget in hierarchy
  // containing ReorderableItems widgets
  //

  DraggingMode _draggingMode = DraggingMode.iOS;

  Widget build(BuildContext context) {
    if (pimeiroAcesso) {
      pimeiroAcesso = false;
      montaMenus(Prefs.singleton().getMenusDisabled(), context);
    }
    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              "Ativo:",
              style: TextStyle(
                  fontSize: 16.0,
                  color: Theme.of(context).textTheme.body2.color),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 5),
              child: Text(
                "Ordem:",
                style: TextStyle(
                    fontSize: 16.0,
                    color: Theme.of(context).textTheme.body2.color),
              ),
            ),
          ],
        ),
        r.ReorderableList(
          onReorder: this._reorderCallback,
          onReorderDone: this._reorderDone,
          child: Column(children: menus),
        ),
      ],
    );
  }
}

class Item extends StatelessWidget {
  Item({
    Key key,
    this.data,
    this.isFirst,
    this.isLast,
    this.draggingMode,
    this.ordem,
    this.nome,
    this.id
  }) : super(key: key);

  final Widget data;
  final bool isFirst;
  final bool isLast;
  final DraggingMode draggingMode;
  final int ordem;
  final String nome;
  final String id;

  Widget _buildChild(BuildContext context, r.ReorderableItemState state) {
    BoxDecoration decoration;

    if (state == r.ReorderableItemState.dragProxy ||
        state == r.ReorderableItemState.dragProxyFinished) {
      // slightly transparent background white dragging (just like on iOS)
      decoration = BoxDecoration(color: Color(0xD0FFFFFF));
    } else {
      bool placeholder = state == r.ReorderableItemState.placeholder;
      decoration = BoxDecoration(
          border: Border(
            top: isFirst && !placeholder
                ? Divider.createBorderSide(context) //
                : BorderSide.none,
            bottom: isLast && placeholder
                ? BorderSide.none //
                : Divider.createBorderSide(context),
          ),
          color: placeholder ? null : Colors.white);
    }

    // For iOS dragging mdoe, there will be drag handle on the right that triggers
    // reordering; For android mode it will be just an empty container
    Widget dragHandle = draggingMode == DraggingMode.iOS
        ? r.ReorderableListener(
            child: Container(
              padding: EdgeInsets.only(right: 18.0, left: 18.0),
              color: Color(0x08000000),
              child: Center(
                child: Icon(Icons.reorder, color: Color(0xFF888888)),
              ),
            ),
          )
        : Container();

    Widget content = Container(
//      decoration: decoration,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Opacity(
          // hide content for placeholder
          opacity: state == r.ReorderableItemState.placeholder ? 0.0 : 1.0,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
                    child: data,
                  ),
                ),
                // Triggers the reordering
                dragHandle,
              ],
            ),
          ),
        ),
      ),
    );

    // For android dragging mode, wrap the entire content in DelayedReorderableListener
    if (draggingMode == DraggingMode.Android) {
      content = r.DelayedReorderableListener(
        child: content,
      );
    }

    return content;
  }

  @override
  Widget build(BuildContext context) {
    return r.ReorderableItem(
        key: data.key, //
        childBuilder: _buildChild);
  }
}
