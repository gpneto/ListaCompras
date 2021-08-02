import 'package:fish_redux/fish_redux.dart';


enum DiscoverPageAction {
  loadData,
  action,
  mediaTypeChange,
  sortChanged,
  videoCellTapped,
  refreshData,
  loadMore,
  busyChanged,
  filterTap,
  applyFilter
}

class DiscoverPageActionCreator {
  static Action onAction() {
    return const Action(DiscoverPageAction.action);
  }

  static Action onSortChanged(String s) {
    return Action(DiscoverPageAction.sortChanged, payload: s);
  }


  static Action onRefreshData() {
    return const Action(DiscoverPageAction.refreshData);
  }


  static Action onVideoCellTapped(
      int p, String backpic, String name, String poster) {
    return Action(DiscoverPageAction.videoCellTapped,
        payload: [p, backpic, name, poster]);
  }

  static Action onBusyChanged(bool p) {
    return Action(DiscoverPageAction.busyChanged, payload: p);
  }

  static Action mediaTypeChange(bool isMovie) {
    return Action(DiscoverPageAction.mediaTypeChange, payload: isMovie);
  }

  static Action filterTap() {
    return const Action(DiscoverPageAction.filterTap);
  }

  static Action applyFilter() {
    return const Action(DiscoverPageAction.applyFilter);
  }
}
