
import 'package:crypto_exchange/data/currencies.dart';
import 'package:crypto_exchange/data/loading_status.dart';
import 'package:crypto_exchange/data/rate.dart';
import 'package:crypto_exchange/utils/strings.dart';

class CurrencyListState{
  final String currency;
  final List<String> cryptos;
  final List<ExchangeRate> rates;
  final LoadingStatus loadingStatus;
  final String backendError;
  final bool localDataReady;
  final bool reload;

  CurrencyListState({
    this.currency,
    this.cryptos,
    this.rates,
    this.loadingStatus,
    this.backendError,
    this.localDataReady,
    this.reload,
  });

  factory CurrencyListState.initial() => CurrencyListState(
    cryptos: default_cryptos,
    currency: usd,
    rates: List(),
    loadingStatus: LoadingStatus.success,
    backendError: "",
    localDataReady: false,
    reload: false,
  );

  CurrencyListState copyWith({
    LoadingStatus status,
    String currency,
    List<String> cryptos,
    List<ExchangeRate> rates,
    String backendError,
    bool localDataReady,
    bool reload,
  }) => CurrencyListState(
    loadingStatus: status ?? this.loadingStatus,
    currency: currency ?? this.currency,
    cryptos: cryptos ?? this.cryptos,
    rates: rates ?? this.rates,
    backendError: backendError ?? this.backendError,
    localDataReady: localDataReady ?? this.localDataReady,
    reload: reload ?? this.reload,
  );
}