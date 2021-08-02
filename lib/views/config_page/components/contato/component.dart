import 'package:fish_redux/fish_redux.dart';

import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ContatoComponent extends Component<ContatoState> {
  ContatoComponent()
      : super(
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ContatoState>(
                adapter: null,
                slots: <String, Dependent<ContatoState>>{
                }),);

}
