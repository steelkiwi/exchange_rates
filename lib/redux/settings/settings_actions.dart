
import 'package:crypto_exchange/data/show_currency_pair.dart';

class UpdateCurrenciesForShowingList{
  final List<ShowCurrencyPair> currenciesForShowing;
  UpdateCurrenciesForShowingList(this.currenciesForShowing);
}

class UpdateCurrentCurrencyAction{
  final String currency;
  UpdateCurrentCurrencyAction(this.currency);
}

class GetCurrenciesFroShowingAction{
  final List<ShowCurrencyPair> currenciesForShowing;
  GetCurrenciesFroShowingAction(this.currenciesForShowing);
}