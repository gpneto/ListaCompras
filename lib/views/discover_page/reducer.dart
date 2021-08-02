import 'package:fish_redux/fish_redux.dart';


import 'action.dart';
import 'state.dart';

Reducer<DiscoverPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<DiscoverPageState>>{
      DiscoverPageAction.action: _onAction,
      DiscoverPageAction.loadData: _onLoadData,
      DiscoverPageAction.loadMore: _onLoadMore,
      DiscoverPageAction.busyChanged: _busyChanged,
    },
  );
}

DiscoverPageState _onAction(DiscoverPageState state, Action action) {
  final DiscoverPageState newState = state.clone();
  return newState;
}

DiscoverPageState _busyChanged(DiscoverPageState state, Action action) {
  final bool _isBusy = action.payload;
  final DiscoverPageState newState = state.clone();
  newState.isbusy = _isBusy;
  return newState;
}

DiscoverPageState _onLoadData(DiscoverPageState state, Action action) {

  final DiscoverPageState newState = state.clone();

  return newState;
}

DiscoverPageState _onLoadMore(DiscoverPageState state, Action action) {

  final DiscoverPageState newState = state.clone();

  return newState;
}
