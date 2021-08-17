import 'package:fish_redux/fish_redux.dart';

import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class UserInfoComponent extends Component<UserInfoState> {
  UserInfoComponent()
      : super(

    shouldUpdate: (oldState, newState) {
      return oldState.screenController  !=
          newState.screenController || oldState.selectedIndexPage  !=
          newState.selectedIndexPage;
    },
    clearOnDependenciesChanged: true,

            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<UserInfoState>(
                adapter: null,
                slots: <String, Dependent<UserInfoState>>{
                }),);

}
