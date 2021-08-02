import 'package:fish_redux/fish_redux.dart';

import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class BrilhoComponent extends Component<BrilhoState> {
  BrilhoComponent()
      : super(
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<BrilhoState>(
                adapter: null,
                slots: <String, Dependent<BrilhoState>>{
                }),);

}
