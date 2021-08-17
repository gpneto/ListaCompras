import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;

import 'action.dart';
import 'state.dart';

Widget buildView(PageState state, Dispatch dispatch, ViewService viewService) {
  final ListAdapter adapter = viewService.buildAdapter();
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.green,
      title: const Text('Lista de Compras'),
      actions: <Widget>[
        IconButton(
          alignment: Alignment.center,
          // highlightColor: Colors.green.withOpacity(0.2),
          onPressed:  () => dispatch(PageActionCreator.onArquivarLista()),
          icon: Icon(
            Icons.file_download_done,
            color: Colors.black,
          ),
        ),
        IconButton(
          alignment: Alignment.center,
          // highlightColor: Colors.green.withOpacity(0.2),
          onPressed:  () => dispatch(PageActionCreator.onCompartilharLista()),
          icon: Icon(
            Icons.share,
            color: Colors.black,
          ),
        )
      ],
    ),
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: <Widget>[
            viewService.buildComponent('report'),
            Expanded(
                child: adapter.itemCount ==0 ? Container(): ListView.builder(
                    itemBuilder: adapter.itemBuilder,
                    itemCount: adapter.itemCount))
          ],
        ),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () => dispatch(PageActionCreator.onAddAction()),
      tooltip: 'Add',
      child: const Icon(Icons.add),
    ),
  );
}
