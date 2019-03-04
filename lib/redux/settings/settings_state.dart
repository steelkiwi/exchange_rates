
import 'package:crypto_exchange/data/currencies.dart';
import 'package:crypto_exchange/data/show_currency_pair.dart';
import 'package:crypto_exchange/utils/strings.dart';

class SettingsState{

  final List<String> currencyList;
  final List<String> allCryptoCurrencies;
  final String mainCurrency;
  final List<ShowCurrencyPair> cryptoCurrenciesForShowing;

  SettingsState({
    this.currencyList,
    this.allCryptoCurrencies,
    this.mainCurrency,
    this.cryptoCurrenciesForShowing,

  });

  factory SettingsState.initial() => SettingsState(
    cryptoCurrenciesForShowing: showCurrency,
    allCryptoCurrencies: default_cryptos,
    mainCurrency: usd,
    currencyList: available_currencies,
  );

  SettingsState copyWith({
    List<String> currencyList,
    List<String> allCryptoCurrencies,
    String mainCurrency,
    List<ShowCurrencyPair> cryptoCurrenciesForShowing,
  })=> SettingsState(
    currencyList: currencyList ?? this.currencyList,
    allCryptoCurrencies: allCryptoCurrencies ?? this.allCryptoCurrencies,
    mainCurrency: mainCurrency ?? this.mainCurrency,
    cryptoCurrenciesForShowing: cryptoCurrenciesForShowing ?? this.cryptoCurrenciesForShowing,
  );
}