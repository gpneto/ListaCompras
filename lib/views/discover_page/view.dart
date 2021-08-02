import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:lista_compras/style/themestyle.dart';
import 'package:lista_compras/views/discover_page/widgets/popularlist.widget.dart';
import 'package:lista_compras/views/discover_page/widgets/provincelist.widget.dart';
import 'package:lista_compras/views/discover_page/widgets/recentlist.widget.dart';
import 'package:lista_compras/views/discover_page/models/mountain.model.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    DiscoverPageState state, Dispatch dispatch, ViewService viewService) {


  return Builder(
    builder: (context) {
      final ThemeData _theme = ThemeStyle.getTheme(context);

      return _HomeScreen();
    },
  );
}


class _HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<_HomeScreen> {
  bool isSearch = false;
  String searchValue = '';

  void clickSearch() {
    setState(() {
      isSearch = !this.isSearch;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;



    return Scaffold(
      // backgroundColor: Colors.white,
      drawer: Scaffold.hasDrawer(context)  ?  Scaffold.of(context).widget.drawer : null,
      appBar: buildAppBar(size),
      body:  Container(
          width: size.width,
          height: size.height,
          child: Column(
            children: <Widget>[
              ProvinceList(),
              RecentList(
                listRecent: recents,
              ),
              PopularList(
                listPopular: recents,
              )
              ,
            ],

        ),
      ),
    );
  }

  AppBar buildAppBar(Size size) {
    return AppBar(
      // backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.green),
      title: Container(
        child: this.isSearch
            ? TextField(
          onChanged: (value) {
            setState(() {
              searchValue = value;
            });
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Apa yang kamu cari?",
          ),
        )
            : Text(
          "Pendaki",
          style: TextStyle(
            fontSize: size.width * 0.06,
            color: Colors.black.withOpacity(0.7),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          alignment: Alignment.center,
          // highlightColor: Colors.green.withOpacity(0.2),
          onPressed: this.clickSearch,
          icon: Icon(
            this.isSearch ? Icons.close : Icons.search,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}