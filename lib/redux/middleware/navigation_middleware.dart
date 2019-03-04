import 'package:crypto_exchange/common/common_actions.dart';
import 'package:crypto_exchange/redux/app_state.dart';
import 'package:crypto_exchange/utils/keys.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';

class NavigationMiddleware extends MiddlewareClass<AppState>{
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {

      if(action is NavigateBackAction){
        Keys.navKey.currentState.pop();
      }
      if(action is NavigateToSettingsAction){
        Keys.navKey.currentState.pushNamed("/settings");
      }
      next(action);
  }
}

