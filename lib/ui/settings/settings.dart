
import 'package:crypto_exchange/data/currencies.dart';
import 'package:crypto_exchange/data/show_currency_pair.dart';
import 'package:crypto_exchange/redux/app_state.dart';
import 'package:crypto_exchange/ui/settings/settings_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: StoreConnector<AppState, SettingsViewModel>(
        converter: (store) => SettingsViewModel.fromStore(store),
        builder: (_, viewModel) => Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              header(viewModel),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 16.0),
                child: Text("Main currency",
                  style: TextStyle(
                      color: Color(0xff90949C),
                      fontSize: 17.0
                  ),
                ),
              ),
              Column(
                children: currencies(viewModel),
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Divider(
                  color: Colors.red,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 16.0),
                child: Text("Crypto-currencies of interest.",
                  style: TextStyle(
                      color: Color(0xff90949C),
                      fontSize: 17.0
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.cryptoCurrenciesForShowing.length,
                  itemBuilder: (BuildContext context, int position) => cryptoCurrencyItem(viewModel,viewModel.cryptoCurrenciesForShowing[position]),
              ),
              )
            ],
          ),
        ),
      )),
    );
  }

  Widget cryptoCurrencyItem(SettingsViewModel viewModel, ShowCurrencyPair pair){
    return Container(
      height: 70.0,
      child: Row(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(left: 16.0),
            child: Image(image: AssetImage((currency_images[pair.currency]))),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left:24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(currency_names[pair.currency],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: new Text(pair.currency,
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Switch(value: pair.show, onChanged: (show){
                List<ShowCurrencyPair> list = new List.from(viewModel.cryptoCurrenciesForShowing);
                ShowCurrencyPair item = list.firstWhere((it)=> it.currency == pair.currency);
                item.show = show;
                viewModel.updateListForShow(list);
            })
          ),
        ],
      ),
    );
  }

  Widget header(SettingsViewModel viewModel) =>Container(
    height: 48.0,
    child: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          child: Center(
            child: Text("Settings",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17.0,
              ),
            ),
          ),
        ),
        Positioned(
          left: 16.0,
          bottom: 0.0,
          top: 0.0,
          child: GestureDetector(
            onTap: (){
              viewModel.close();
            },
            child: Padding(
              padding: const EdgeInsets.only(top:12.0, bottom: 12.0),
              child: Icon(Icons.close),
            ),
          ),
        ),
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Divider(
            height: 1.0,
            color: Colors.black,
          ),
        )
      ],
    ),
  );

  List<Widget> currencies(SettingsViewModel viewModel) {
    List<Widget> currencies = List();
    int index =0;
    viewModel.currencyList.forEach((s){
      currencies.add(Container(
        height: 70.0,
        child: Row(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 16.0),
              child: Image(image: AssetImage((currency_images[s]))),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left:24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text(currency_names[s],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: new Text(s,
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Radio(
                value: index,
                groupValue: viewModel.currencyList.indexOf(viewModel.mainCurrency),
                onChanged: (value){
                  String currency = viewModel.currencyList[value];
                  viewModel.changeMainCurrency(currency);
                },
              ),
            ),
          ],
        ),
      ));
      index++;
    });
    currencies.add(new Padding(padding: EdgeInsets.only(top: 8.0,),
      child: Text("This currency will be used for rates calculation."),
    ));
    return currencies;
  }
}
