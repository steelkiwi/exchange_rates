import 'package:crypto_exchange/data/currencies.dart';
import 'package:crypto_exchange/data/show_currency_pair.dart';
import 'package:crypto_exchange/redux/app_state.dart';
import 'package:crypto_exchange/redux/currency_list/currency_list_actions.dart';
import 'package:crypto_exchange/redux/settings/settings_actions.dart';
import 'package:crypto_exchange/utils/constants.dart';
import 'package:crypto_exchange/utils/strings.dart';
import 'package:redux/redux.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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

    if(action is UpdateCurrentCurrencyAction){
      SharedPreferences.getInstance().then((preferences){
        preferences.setString(CURRENT_CURRENCY, action.currency);
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

    if(action is GetCurrenciesFroShowingAction){
      SharedPreferences.getInstance().then((preferences){
        if(preferences.get(ITEMS_FOR_SHOWING) == null){
          preferences.setString(ITEMS_FOR_SHOWING, json.encode(ShowList(showCurrency).toJson())).then((v){
            store.dispatch(new UpdateCurrenciesForShowingList(showCurrency));
          });
        }else{
          String jsonString = preferences.get(ITEMS_FOR_SHOWING);
          List<ShowCurrencyPair> items = ShowList.fromJsonMap(json.decode(jsonString)).showList;
          store.dispatch(new UpdateCurrenciesForShowingList(items));
        }
      });
    }

    if(action is UpdateCurrenciesForShowingList){
      var list = List<String>();
      action.currenciesForShowing.forEach((pair){
        if(pair.show){
          list.add(pair.currency);
        }
      });
      SharedPreferences.getInstance().then((preferences){
        preferences.setString(ITEMS_FOR_SHOWING, json.encode(ShowList(action.currenciesForShowing).toJson()));
        preferences.setStringList(CRYPTOS_LIST, list);
      });
    }
  }
}