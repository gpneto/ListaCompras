import 'package:fish_redux/fish_redux.dart' as f;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/actions/adapt.dart';
import 'package:lista_compras/generated/i18n.dart';
import 'package:lista_compras/globalbasestate/action.dart';
import 'package:lista_compras/globalbasestate/store.dart';
import 'package:lista_compras/routes/routes.dart';
import 'package:lista_compras/views/config_page/page.dart';
import 'package:lista_compras/views/main_page/state.dart';
import 'package:lista_compras/widgets/keepalive_widget.dart';


Widget buildViewIos(
    MainPageState state, f.Dispatch dispatch, f.ViewService viewService) {


  CupertinoTabBar bottomNav() {
    return CupertinoTabBar(
      backgroundColor: CupertinoColors.quaternarySystemFill.withOpacity(0.4),
      inactiveColor: CupertinoColors.black.withOpacity(0.6),
      items:  state.pages
          .map((menuItem) => BottomNavigationBarItem(
                icon: menuItem.icone,
                label: menuItem.nome,
              ))
          .toList(),
      currentIndex: state.configPage ? state.pages.indexWhere((element) => element.id == "config") :
          state.selectedIndexPage == null ? 0 : state.selectedIndexPage,
      // selectedItemColor: _theme.tabBarTheme.labelColor,
      // unselectedItemColor: _theme.tabBarTheme.unselectedLabelColor,
      onTap: (int index) {
        // pageController.jumpToPage(index);
        GlobalStore.store.dispatch(GlobalActionCreator.onTabChanged(index));
      },
      // type: BottomNavigationBarType.fixed,
    );
  }

  return Builder(
    builder: (context) {
      Adapt.initContext(context);

      Widget _buildPage(Widget page) {
        return KeepAliveWidget(page);
      }

      final MediaQueryData existingMediaQuery = MediaQuery.of(context);
      MediaQueryData newMediaQuery = MediaQuery.of(context);

      // Widget content = PageView(
      //   physics: NeverScrollableScrollPhysics(),
      //   children:
      //   state.pages
      //       .map<Widget>((menuItem) => _buildPage(menuItem.page))
      //       .toList(),
      //   controller: pageController,
      //   onPageChanged: (int i) =>
      //       GlobalStore.store.dispatch(GlobalActionCreator.onTabChanged(i)),
      // );

      Widget content = _buildPage(state.pages[ state.selectedIndexPage == null ? 0 : state.configPage ? state.pages.indexWhere((element) => element.id == "config") :
      state.selectedIndexPage == null ? 0 : state.selectedIndexPage].page);
      EdgeInsets contentPadding = EdgeInsets.zero;

      // Remove the view inset and add it back as a padding in the inner content.
      newMediaQuery = newMediaQuery.removeViewInsets(removeBottom: true);
      contentPadding =
          EdgeInsets.only(bottom: existingMediaQuery.viewInsets.bottom);

      var tabBar = bottomNav();

      if (
          // Only pad the content with the height of the tab bar if the tab
          // isn't already entirely obstructed by a keyboard or other view insets.
          // Don't double pad.
          (tabBar.preferredSize.height >
              existingMediaQuery.viewInsets.bottom)) {
        // TODO(xster): Use real size after partial layout instead of preferred size.
        // https://github.com/flutter/flutter/issues/12912
        final double bottomPadding =
            tabBar.preferredSize.height + existingMediaQuery.padding.bottom;

        // If tab bar opaque, directly stop the main content higher. If
        // translucent, let main content draw behind the tab bar but hint the
        // obstructed area.
        if (tabBar.opaque(context)) {
          contentPadding = EdgeInsets.only(bottom: bottomPadding);
        } else {
          newMediaQuery = newMediaQuery.copyWith(
            padding: newMediaQuery.padding.copyWith(
              bottom: bottomPadding,
            ),
          );
        }
      }

      content = MediaQuery(
        data: newMediaQuery,
        child: Padding(
          padding: contentPadding,
          child: content,
        ),
      );

      return DecoratedBox(
        decoration: BoxDecoration(
          color: CupertinoTheme.of(context).scaffoldBackgroundColor,
        ),
        child: Stack(
          children: <Widget>[
            // The main content being at the bottom is added to the stack first.
            content,
            MediaQuery(
              data: existingMediaQuery.copyWith(textScaleFactor: 1),
              child: Align(
                alignment: Alignment.bottomCenter,
                // Override the tab bar's currentIndex to the current tab and hook in
                // our own listener to update the [_controller.currentIndex] on top of a possibly user
                // provided callback.
                child: tabBar,
              ),
            ),
          ],
        ),
      );
    },
  );
}
