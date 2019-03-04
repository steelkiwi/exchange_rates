import 'package:crypto_exchange/redux/app_state.dart';
import 'package:crypto_exchange/redux/middleware/local_storage_middleware.dart';
import 'package:crypto_exchange/redux/middleware/navigation_middleware.dart';
import 'package:crypto_exchange/redux/middleware/rest_middleware.dart';
import 'package:crypto_exchange/utils/rest_client.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto_exchange/redux/app_reducer.dart';
import 'package:redux_logging/redux_logging.dart';
import 'dart:async';

Future<Store<AppState>> createStore() async {
  var prefs = await SharedPreferences.getInstance();
  var restClient = new RestClient(prefs);
  return Store(
    appReducer,
    initialState: AppState.initial(),
    middleware: [
      LoggingMiddleware.printer(),
      LocalStorageMiddleware(),
      RestMiddleware(prefs,restClient),
      NavigationMiddleware(),
    ],
  );
}