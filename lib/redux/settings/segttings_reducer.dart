import 'package:crypto_exchange/redux/currency_list/currency_list_actions.dart';
import 'package:crypto_exchange/redux/settings/settings_actions.dart';
import 'package:crypto_exchange/redux/settings/settings_state.dart';
import 'package:redux/redux.dart';

final settingsReducer = combineReducers<SettingsState>([
  TypedReducer<SettingsState,SetCurrentCurrencyAction>(_setMainCurrency),
  TypedReducer<SettingsState, UpdateCurrenciesForShowingList>(_setCurrencyListForShowing),

]);

SettingsState _setMainCurrency(SettingsState state, SetCurrentCurrencyAction action) =>
    state.copyWith(mainCurrency: action.currency);

SettingsState _setCurrencyListForShowing(SettingsState state, UpdateCurrenciesForShowingList action) =>
    state.copyWith(cryptoCurrenciesForShowing: action.currenciesForShowing);