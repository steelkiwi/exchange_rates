
import 'package:crypto_exchange/data/show_currency_pair.dart';
import 'package:crypto_exchange/utils/strings.dart';

const currency_images = {
  "BTC":"assets/images/btc.png",
  "BCC":"assets/images/bcc.png",
  "ETH":"assets/images/etc.png",
  "DASH":"assets/images/dash.png",
  "GBYTE":"assets/images/gbyte.png",
  "VERI":"assets/images/veri.png",
  "XMR":"assets/images/xmr.png",
  "ZEC":"assets/images/zec.png",
  "USD":"assets/images/dollar_symbol.png",
  "EUR":"assets/images/euro.png"
};

const currency_names = {
  "BTC":"Bitcoin",
  "BCC":"BitConnect",
  "ETH":"Ethereum",
  "DASH":"Dash",
  "GBYTE":"Byteball bytes",
  "VERI":"Veritaseum",
  "XMR":"Monero",
  "ZEC":"Zcash",
  "USD":"US Dollar",
  "EUR":"Euro"
};

var showCurrency= [
  ShowCurrencyPair("BTC",true),
  ShowCurrencyPair("BCC",true),
  ShowCurrencyPair("ETH",true),
  ShowCurrencyPair("DASH",true),
  ShowCurrencyPair("GBYTE",true),
  ShowCurrencyPair("VERI",true),
  ShowCurrencyPair("XMR",true),
  ShowCurrencyPair("ZEC",true),
];

const default_cryptos = [
  btc, eth, bcc, dash, gbyte, veri, xmr, zec,
];

const available_currencies = [
  usd, eur,
];