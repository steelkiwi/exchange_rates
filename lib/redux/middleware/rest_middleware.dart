import 'package:crypto_exchange/common/common_actions.dart';
import 'package:crypto_exchange/data/loading_status.dart';
import 'package:crypto_exchange/data/screen.dart';
import 'package:crypto_exchange/redux/app_state.dart';
import 'package:crypto_exchange/redux/currency_list/currency_list_actions.dart';
import 'package:crypto_exchange/repositories/crypto_repositry.dart';
import 'package:crypto_exchange/utils/rest_client.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class RestMiddleware extends MiddlewareClass<AppState> {
  SharedPreferences _pref;
  RestClient _client;
  CryptoRepository _repository;
  //repository

  RestMiddleware(this._pref, this._client) {
    _repository = new CryptoRepository(_client);
  }

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    next(action);
    if(action is FetchCryptoListAction){
      if (action.showLoading) {
        store.dispatch(new ChangeLoadingStatusAction(LoadingStatus.loading, Screen.CURRENCY_LIST));
      }
      _repository.getRates(action.cryptos, action.currency,
        success: (rate){
          print(rate.toString());
          store.dispatch(new SetRatesAction(rate));
          store.dispatch(new ChangeLoadingStatusAction(LoadingStatus.success, Screen.CURRENCY_LIST));
        },
          error: (error){
            store.dispatch(
                new ChangeLoadingStatusAction(LoadingStatus.error, Screen.CURRENCY_LIST));
            store.dispatch(
                new ShowBackendErrorAction(error.errorMessage, Screen.CURRENCY_LIST));
          }
      );
    }
  }
}
