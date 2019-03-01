
import 'package:crypto_exchange/redux/currency_list/curency_list_state.dart';
import 'package:meta/meta.dart';

class AppState{

  final CurrencyListState currencyListState;

  AppState({
    @required this.currencyListState,
  });

  factory AppState.initial() => AppState(
    currencyListState: CurrencyListState.initial()
  );

  AppState copyWith({
    CurrencyListState currencyListState,
  }) => AppState(
    currencyListState: currencyListState ?? this.currencyListState

  );
}