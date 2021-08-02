import 'package:fish_redux/fish_redux.dart';
import 'package:lista_compras/models/base_api_model/base_movie.dart';
import 'package:lista_compras/models/base_api_model/base_tvshow.dart';


import '../../state.dart';


class ShareState implements Cloneable<ShareState> {
  BaseMovieModel shareMovies;
  BaseTvShowModel shareTvshows;
  bool showShareMovie;
  @override
  ShareState clone() {
    return ShareState()
      ..shareMovies = shareMovies
      ..shareTvshows = shareTvshows
      ..showShareMovie = showShareMovie;
  }
}

class ShareConnector extends ConnOp<HomePageState, ShareState> {
  @override
  ShareState get(HomePageState state) {
    ShareState mstate = ShareState();
    mstate.shareMovies = state.shareMovies;
    mstate.shareTvshows = state.shareTvshows;
    mstate.showShareMovie = state.showShareMovie;
    return mstate;
  }

  void set(HomePageState state, ShareState subState) {
    state.showShareMovie = subState.showShareMovie;
  }
}
