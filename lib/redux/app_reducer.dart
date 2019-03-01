
import 'package:crypto_exchange/redux/app_state.dart';
import 'package:crypto_exchange/redux/currency_list/currency_list_reducer.dart';

AppState appReducer(AppState state, dynamic action) =>
    new AppState(
      currencyListState: currencyListReducer(state.currencyListState,action),
    );