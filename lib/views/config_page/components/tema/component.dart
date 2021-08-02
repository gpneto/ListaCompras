import 'package:fish_redux/fish_redux.dart';

import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TemaComponent extends Component<TemaState> {
  TemaComponent()
      : super(
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<TemaState>(
                adapter: null,
                slots: <String, Dependent<TemaState>>{
                }),);

}
