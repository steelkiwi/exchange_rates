
import 'package:crypto_exchange/redux/currency_list/curency_list_state.dart';
import 'package:crypto_exchange/redux/settings/settings_state.dart';
import 'package:meta/meta.dart';

class AppState{

  final CurrencyListState currencyListState;
  final SettingsState settingsState;

  AppState({
    @required this.currencyListState,
    @required this.settingsState,
  });

  factory AppState.initial() => AppState(
    currencyListState: CurrencyListState.initial(),
    settingsState:  SettingsState.initial(),
  );

  AppState copyWith({
    CurrencyListState currencyListState,
    SettingsState settingsState,

  }) => AppState(
    currencyListState: currencyListState ?? this.currencyListState,
    settingsState: settingsState ?? this.settingsState,

  );
}