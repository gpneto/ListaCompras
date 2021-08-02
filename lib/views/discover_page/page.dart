import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class DiscoverPage extends Page<DiscoverPageState, Map<String, dynamic>> {
  DiscoverPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),

          view: buildView,

          middleware: <Middleware<DiscoverPageState>>[],
        );
}
