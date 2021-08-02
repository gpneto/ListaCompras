import 'package:fish_redux/fish_redux.dart';

import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MenusComponent extends Component<MenusState> {
  MenusComponent()
      : super(
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<MenusState>(
                adapter: null,
                slots: <String, Dependent<MenusState>>{
                }),);

}
