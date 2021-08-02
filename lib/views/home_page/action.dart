import 'package:fish_redux/fish_redux.dart';
import 'package:lista_compras/models/enums/media_type.dart';



enum HomePageAction {
  action,
  initMovie,
  initTV,
  initPopularMovies,
  initPopularTVShows,
  moreTapped,
  initTrending,
  searchBarTapped,
  cellTapped,
  trendingMore,
  shareMore,
  initShareMovies,
  initShareTvShows,
}

class HomePageActionCreator {
  static Action onAction() {
    return const Action(HomePageAction.action);
  }


  static Action onSearchBarTapped() {
    return const Action(HomePageAction.searchBarTapped);
  }

  static Action onCellTapped(int id, String bgpic, String title,
      String posterpic, MediaType type) {
    return Action(HomePageAction.cellTapped,
        payload: [id, bgpic, title, posterpic, type]);
  }

  static Action onTrendingMore() {
    return const Action(HomePageAction.trendingMore);
  }

  static Action onShareMore() {
    return const Action(HomePageAction.shareMore);
  }


}
