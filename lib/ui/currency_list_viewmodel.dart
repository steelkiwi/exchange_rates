import 'package:crypto_exchange/common/common_actions.dart';
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
  final bool reload;

  final Function (bool) toggleLocalDataReady;
  final Function cleanBackendError;
  final Function (LoadingStatus) changeLoading;
  final Function (bool, List<String>, String) requestRates;
  final Function openSettings;
  final Function navigateToSettings;
  final Function (bool) setReload;
  final Function restart;

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
    this.navigateToSettings,
    this.reload,
    this.setReload,
    this.restart,
  });

  static CurrencyListViewModel fromStore(Store<AppState> store) => CurrencyListViewModel(
    currency: store.state.currencyListState.currency,
    cryptos: store.state.currencyListState.cryptos,
    rates: store.state.currencyListState.rates,
    loadingStatus: store.state.currencyListState.loadingStatus,
    backendError: store.state.currencyListState.backendError,
    localDataReady: store.state.currencyListState.localDataReady,
    reload: store.state.currencyListState.reload,
    
    toggleLocalDataReady: (ready) => store.dispatch(new SetLocalDataReadyAction(ready)),
    requestRates: (showLoading, cryptos, currency) => store.dispatch(new FetchCryptoListAction(cryptos, currency, showLoading)),
    navigateToSettings: () => store.dispatch(new NavigateToSettingsAction()),
    setReload: (reload) => store.dispatch(new ReloadCurrenciesAction(reload)),
    restart: () => store.dispatch(new GetCurrentCurrencyAction()),

  );

}