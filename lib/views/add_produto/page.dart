import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class AddProdutoPage extends Page<AddProdutoState, Map<String, dynamic>> {
  AddProdutoPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<AddProdutoState>(
                adapter: null,
                slots: <String, Dependent<AddProdutoState>>{
                }),
            middleware: <Middleware<AddProdutoState>>[
            ],);

}
