import 'package:crypto_exchange/data/loading_status.dart';
import 'package:crypto_exchange/data/rate.dart';
import 'package:crypto_exchange/redux/app_state.dart';
import 'package:crypto_exchange/redux/currency_list/currency_list_actions.dart';
import 'package:redux/redux.dart';

class CurrencyListViewModel{

  final String currency;
  final List<String> cryptos;
  final List<ExchangeRate> rates;
  final LoadingStatus loadingStatus;
  final String backendError;
  final bool localDataReady;

  final Function (bool) toggleLocalDataReady;
  final Function cleanBackendError;
  final Function (LoadingStatus) changeLoading;
  final Function (bool, List<String>, String) requestRates;
  final Function openSettings;

  CurrencyListViewModel({
    this.currency,
    this.cryptos,
    this.rates,
    this.loadingStatus,
    this.backendError,
    this.changeLoading,
    this.cleanBackendError,
    this.requestRates,
    this.openSettings,
    this.localDataReady,
    this.toggleLocalDataReady,
  });

  static CurrencyListViewModel fromStore(Store<AppState> store) => CurrencyListViewModel(
    currency: store.state.currencyListState.currency,
    cryptos: store.state.currencyListState.cryptos,
    rates: store.state.currencyListState.rates,
    loadingStatus: store.state.currencyListState.loadingStatus,
    backendError: store.state.currencyListState.backendError,
    localDataReady: store.state.currencyListState.localDataReady,
    
    toggleLocalDataReady: (ready) => store.dispatch(new SetLocalDataReadyAction(ready)),
    requestRates: (showLoading, cryptos, currency) => store.dispatch(new FetchCryptoListAction(cryptos, currency, showLoading)),

  );

}