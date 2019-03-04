import 'package:crypto_exchange/common/common_actions.dart';
import 'package:crypto_exchange/data/rate.dart';
import 'package:crypto_exchange/data/screen.dart';
import 'package:crypto_exchange/redux/currency_list/curency_list_state.dart';
import 'package:crypto_exchange/redux/currency_list/currency_list_actions.dart';
import 'package:redux/redux.dart';

final currencyListReducer = combineReducers<CurrencyListState>([
  TypedReducer<CurrencyListState,ShowBackendErrorAction>(_backendErrorAction),
  TypedReducer<CurrencyListState, HideBackendErrorAction>(_hideBackendErrorAction),
  TypedReducer<CurrencyListState, ChangeLoadingStatusAction>(_changeLoadingStatusAction),
  TypedReducer<CurrencyListState, SetRatesAction>(_setRates),
  TypedReducer<CurrencyListState, SetCryptoCurrenciesListAction>(_setCryptoCurrencies),
  TypedReducer<CurrencyListState, SetCurrentCurrencyAction>(_setCurrency),
  TypedReducer<CurrencyListState, SetLocalDataReadyAction>(_localDataReady),
  TypedReducer<CurrencyListState, ReloadCurrenciesAction>(_reload),

]);

CurrencyListState _backendErrorAction(CurrencyListState state, ShowBackendErrorAction action) {
  if(action.screen == Screen.CURRENCY_LIST){
    return state.copyWith(backendError: action.error);
  }else{
    return state;
  }
}

CurrencyListState _hideBackendErrorAction(CurrencyListState state, HideBackendErrorAction action) =>
    state.copyWith(backendError: "");

CurrencyListState _changeLoadingStatusAction(CurrencyListState state, ChangeLoadingStatusAction action){
  if(action.screen == Screen.CURRENCY_LIST){
    return state.copyWith(status: action.status);
  } else return state;
}

CurrencyListState _setRates(CurrencyListState state, SetRatesAction action){
  List<ExchangeRate> rateList = List();
  action.cryptos.forEach((crypto, rate){
    ExchangeRate exchangeRate = new ExchangeRate();
    exchangeRate.cryptoCurrency = crypto;
    rate.forEach((currency,amount){
      Rate r = Rate();
      r.rate = amount;
      r.currency = currency;
      exchangeRate.rate = r;
    });
    rateList.add(exchangeRate);
  });

  return state.copyWith(rates: rateList);
}


CurrencyListState _setCurrency(CurrencyListState state, SetCurrentCurrencyAction action) =>
    state.copyWith(currency: action.currency);

CurrencyListState _setCryptoCurrencies(CurrencyListState state, SetCryptoCurrenciesListAction action) =>
    state.copyWith(cryptos: action.cryptoCurrencies);

CurrencyListState _localDataReady(CurrencyListState state, SetLocalDataReadyAction action) =>
    state.copyWith(localDataReady: action.localDataReady);

CurrencyListState _reload(CurrencyListState state, ReloadCurrenciesAction action) =>
    state.copyWith(reload: action.reload);
