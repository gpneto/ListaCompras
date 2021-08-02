import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/widgets/info_list_section.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(ContatoState state, Dispatch dispatch, ViewService viewService) {
  return  InfoListSection(
    title: 'Contato',
    child: new StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('contacts')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return new Center(
              child: new CircularProgressIndicator());

        List<Widget> children =
        snapshot.data.docs.map((document) {
          return Column(
            children: <Widget>[
              new ListTile(
                title: new Text(document.get('name')),
                subtitle: new Text(document.get('title')),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        List<Widget> children = [
                          new ListTile(
                              title:
                              new Text(document.get('info'))),
                          new Divider(
                            height: 1.0,
                          )
                        ];

                        if (document.get('email') != null) {
                          children.add(
                            new ListTile(
                              title: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: new Text(
                                    document.get('email'),
                                  )),
                              leading: new Icon(Icons.email),
                              onTap: () {
//                                                  launch('mailto:${document['email']}');
                              },
                            ),
                          );
                          children
                              .add(new Divider(height: 1.0));
                        }

                        if (document.get('phone') != null) {
                          children.add(
                            new ListTile(
                              title:
                              new Text(document.get('phone')),
                              leading: new Icon(Icons.phone),
                              onTap: () {
//                                                  launch('tel:${document['phone']}');
                              },
                            ),
                          );
                          children
                              .add(new Divider(height: 1.0));
                        }

                        return new AlertDialog(
                          title: new Text(document.get('name')),
                          content: new Column(
                            mainAxisSize: MainAxisSize.min,
                            children: children,
                          ),
                          actions: <Widget>[
                            new FlatButton(
                                child: new Text('Close'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                })
                          ],
                        );
                      });
                },
              ),
              new Divider(
                height: 2.0,
              ),
            ],
          );
        }).toList();

        return new Column(
          children: children,
        );
      },
    ),
  );
}
