import 'package:crypto_exchange/redux/app_state.dart';
import 'package:crypto_exchange/redux/store.dart';
import 'package:crypto_exchange/ui/currency_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';


void main() async{
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  var store = await createStore();
  runApp(new CryptoExchangeApp(store));
}

class CryptoExchangeApp extends StatefulWidget {
  final Store<AppState> store;

  CryptoExchangeApp(this.store);

  @override
  _CryptoExchangeAppState createState() => _CryptoExchangeAppState();
}

class _CryptoExchangeAppState extends State<CryptoExchangeApp> {
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: widget.store,
      child: new MaterialApp(
        theme: new ThemeData(
          brightness: Brightness.light,
          // ignore: strong_mode_invalid_cast_new_expr
        ),
        debugShowCheckedModeBanner: false,
        home: new CurrencyList(),
      ),
    );
  }
}
