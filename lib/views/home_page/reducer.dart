import 'package:fish_redux/fish_redux.dart';
import 'package:lista_compras/models/base_api_model/base_movie.dart';
import 'package:lista_compras/models/base_api_model/base_tvshow.dart';



import 'action.dart';
import 'state.dart';

Reducer<HomePageState> buildReducer() {
  return asReducer(
    <Object, Reducer<HomePageState>>{
      HomePageAction.action: _onAction,

      HomePageAction.initShareMovies: _onInitShareMovies,
      HomePageAction.initShareTvShows: _onInitShareTvShows,
    },
  );
}

HomePageState _onAction(HomePageState state, Action action) {
  final HomePageState newState = state.clone();
  return newState;
}

HomePageState _onInitShareMovies(HomePageState state, Action action) {
  final BaseMovieModel d = action.payload;
  final HomePageState newState = state.clone();
  newState.shareMovies = d;
  return newState;
}

HomePageState _onInitShareTvShows(HomePageState state, Action action) {
  final BaseTvShowModel d = action.payload;
  final HomePageState newState = state.clone();
  newState.shareTvshows = d;
  return newState;
}
