import 'package:fish_redux/fish_redux.dart';

import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class AddProdutoComponent extends Component<AddProdutoState> {
  AddProdutoComponent()
      : super(
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<AddProdutoState>(
                adapter: null,
                slots: <String, Dependent<AddProdutoState>>{
                }),);

}
