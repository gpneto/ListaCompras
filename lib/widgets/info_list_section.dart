import 'package:flutter/material.dart';

class InfoListSection extends StatelessWidget {
  InfoListSection({ Key key, this.title, this.imagePath, this.child}):super(key:key);

  final String title;
  final String imagePath;
  final Widget child;


  @override
  Widget build(BuildContext context) {
    return new Card(
      margin: EdgeInsets.all(12.0),
      elevation: 8.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new DefaultTextStyle(
              style: Theme.of(context).textTheme.subhead,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                child: new Text(
                  title,
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.green, fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: child,
            )
          ],
        ),
      ),
    );
  }
}