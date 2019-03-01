
class SetLocalDataReadyAction{
  bool localDataReady;
  SetLocalDataReadyAction(this.localDataReady);
}

class FetchCryptoListAction{
  List<String> cryptos;
  String currency;
  bool showLoading;
  FetchCryptoListAction(this.cryptos, this.currency, this.showLoading);
}

class SetRatesAction{
  Map<String,Map<String,double>> cryptos;
  SetRatesAction(this.cryptos);
}

class NeedToShowSettingsAction{
  bool show;
  NeedToShowSettingsAction(this.show);
}

class GetCryptoCurrenciesListAction{
}

class SetCryptoCurrenciesListAction{
  List<String> cryptoCurrencies;
  SetCryptoCurrenciesListAction(this.cryptoCurrencies);
}

class GetCurrentCurrencyAction{
}

class SetCurrentCurrencyAction{
  String currency;
  SetCurrentCurrencyAction(this.currency);
}