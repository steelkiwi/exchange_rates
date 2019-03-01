import 'package:crypto_exchange/data/currencies.dart';
import 'package:crypto_exchange/redux/app_state.dart';
import 'package:crypto_exchange/redux/currency_list/currency_list_actions.dart';
import 'package:crypto_exchange/utils/constants.dart';
import 'package:crypto_exchange/utils/strings.dart';
import 'package:redux/redux.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageMiddleware extends MiddlewareClass<AppState>{


  LocalStorageMiddleware();

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    next(action);
    if(action is GetCurrentCurrencyAction){
      SharedPreferences.getInstance().then((preferences){
        if(preferences.get(CURRENT_CURRENCY) == null){
          preferences.setString(CURRENT_CURRENCY, usd).then((v){
            store.dispatch(new GetCryptoCurrenciesListAction());
          });
        }else{
          String currency = preferences.get(CURRENT_CURRENCY);
          store.dispatch(new SetCurrentCurrencyAction(currency));
          store.dispatch(new GetCryptoCurrenciesListAction());
        }
      });

    }
    
    if(action is GetCryptoCurrenciesListAction){
      SharedPreferences.getInstance().then((preferences){
        if(preferences.get(CRYPTOS_LIST) == null){
          preferences.setStringList(CRYPTOS_LIST, default_cryptos).then((v){
            store.dispatch(new SetLocalDataReadyAction(true));
          });
        }else{
          List<String> list = preferences.getStringList(CRYPTOS_LIST);
          store.dispatch(new SetCryptoCurrenciesListAction(list));
          store.dispatch(new SetLocalDataReadyAction(true));
        }
      });
    }
  }
}