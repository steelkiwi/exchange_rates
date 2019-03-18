

import 'package:crypto_exchange/common/common_actions.dart';
import 'package:crypto_exchange/data/show_currency_pair.dart';
import 'package:crypto_exchange/redux/app_state.dart';
import 'package:crypto_exchange/redux/currency_list/currency_list_actions.dart';
import 'package:crypto_exchange/redux/settings/settings_actions.dart';
import 'package:redux/redux.dart';

class SettingsViewModel{
  final List<String> currencyList;
  final List<String> allCryptoCurrencies;
  final String mainCurrency;
  final List<ShowCurrencyPair> cryptoCurrenciesForShowing;

  final Function (String) changeMainCurrency;
  final Function (List<ShowCurrencyPair>) updateListForShow;
  final Function close;

  SettingsViewModel({
    this.currencyList,
    this.allCryptoCurrencies,
    this.mainCurrency,
    this.cryptoCurrenciesForShowing,
    this.changeMainCurrency,
    this.updateListForShow,
    this.close,
  });

  static SettingsViewModel fromStore(Store<AppState> store) => SettingsViewModel(
    currencyList:  store.state.settingsState.currencyList,
    allCryptoCurrencies: store.state.settingsState.allCryptoCurrencies,
    mainCurrency: store.state.settingsState.mainCurrency,
    cryptoCurrenciesForShowing: store.state.settingsState.cryptoCurrenciesForShowing,

    changeMainCurrency: (currency){
      store.dispatch(new SetCurrentCurrencyAction(currency));
      store.dispatch(new UpdateCurrentCurrencyAction(currency));
    },
    updateListForShow:  (dict) =>
        store.dispatch(new UpdateCurrenciesForShowingList(dict)),
    close: (){
      store.dispatch(new ReloadCurrenciesAction(true));
      store.dispatch(new NavigateBackAction());
    }
  );
}