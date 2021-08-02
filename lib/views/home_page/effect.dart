import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;

import 'package:lista_compras/routes/routes.dart';
import 'package:lista_compras/widgets/searchbar_delegate.dart';

import 'action.dart';
import 'state.dart';

Effect<HomePageState> buildEffect() {
  return combineEffects(<Object, Effect<HomePageState>>{
    HomePageAction.action: _onAction,
    HomePageAction.moreTapped: _moreTapped,
    HomePageAction.searchBarTapped: _onSearchBarTapped,
    HomePageAction.cellTapped: _onCellTapped,
    HomePageAction.trendingMore: _trendingMore,
    HomePageAction.shareMore: _shareMore,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<HomePageState> ctx) {}

Future _onInit(Action action, Context<HomePageState> ctx) async {
  final Object ticker = ctx.stfState;
  ctx.state.animatedController =
      AnimationController(vsync: ticker, duration: Duration(milliseconds: 600));
  ctx.state.scrollController = new ScrollController();
  // final _tmdb = TMDBApi.instance;
  // final _baseApi = BaseApi.instance;
  // final _movies = await _tmdb.getNowPlayingMovie();
  // if (_movies.success)
  //   ctx.dispatch(HomePageActionCreator.onInitMovie(_movies.result));
  // final _tv = await _tmdb.getTVOnTheAir();
  // if (_tv.success) ctx.dispatch(HomePageActionCreator.onInitTV(_tv.result));
  // final _trending = await _tmdb.getTrending(MediaType.all, TimeWindow.day);
  // if (_trending.success)
  //   ctx.dispatch(HomePageActionCreator.initTrending(_trending.result));
  // final _shareMovie = await _baseApi.getMovies(pageSize: 10);
  // if (_shareMovie.success)
  //   ctx.dispatch(HomePageActionCreator.initShareMovies(_shareMovie.result));
  // final _sharetv = await _baseApi.getTvShows(pageSize: 10);
  // if (_sharetv.success)
  //   ctx.dispatch(HomePageActionCreator.initShareTvShows(_sharetv.result));
  // final _popMovie = await _tmdb.getPopularMovies();
  // if (_popMovie.success)
  //   ctx.dispatch(HomePageActionCreator.onInitPopularMovie(_popMovie.result));
  // final _popTv = await _tmdb.getPopularTVShows();
  // if (_popTv.success)
  //   ctx.dispatch(HomePageActionCreator.onInitPopularTV(_popTv.result));
}

void _onDispose(Action action, Context<HomePageState> ctx) {
  ctx.state.animatedController.dispose();
  ctx.state.scrollController.dispose();
}

Future _moreTapped(Action action, Context<HomePageState> ctx) async {
  await Navigator.of(ctx.context).pushNamed('MoreMediaPage',
      arguments: {'list': action.payload[0], 'type': action.payload[1]});
}

Future _onSearchBarTapped(Action action, Context<HomePageState> ctx) async {
  await showSearch(context: ctx.context, delegate: SearchBarDelegate());
}

Future _onCellTapped(Action action, Context<HomePageState> ctx) async {

}

Future _trendingMore(Action action, Context<HomePageState> ctx) async {
  await Navigator.of(ctx.context)
      .push(PageRouteBuilder(pageBuilder: (context, animation, secAnimation) {
    return FadeTransition(
      opacity: animation,
      child:
          Routes.routes.buildPage('trendingPage', {'data': ctx.state.trending}),
    );
  }));
}

Future _shareMore(Action action, Context<HomePageState> ctx) async {
  // await Navigator.of(ctx.context)
  //     .push(PageRouteBuilder(pageBuilder: (context, animation, secAnimation) {
  //   return FadeTransition(
  //     opacity: animation,
  //     child: AllStreamLinkPage().buildPage(
  //         {'type': ctx.state.showShareMovie ? MediaType.movie : MediaType.tv}),
  //   );
  // }));
}
