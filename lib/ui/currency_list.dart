
import 'package:crypto_exchange/data/currencies.dart';
import 'package:crypto_exchange/data/loading_status.dart';
import 'package:crypto_exchange/redux/app_state.dart';
import 'package:crypto_exchange/redux/currency_list/currency_list_actions.dart';
import 'package:crypto_exchange/ui/currency_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:async';

class CurrencyList extends StatefulWidget {
  @override
  _CurrencyListState createState() => _CurrencyListState();
}

class _CurrencyListState extends State<CurrencyList> {

  RefreshController _refreshController = new RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: StoreConnector<AppState,CurrencyListViewModel>(
        onInit: (store){
          store.dispatch(new GetCurrentCurrencyAction());
        },
        onWillChange: (viewModel){
          if(viewModel.localDataReady && viewModel.loadingStatus != LoadingStatus.loading){
            viewModel.toggleLocalDataReady(false);
            viewModel.requestRates(true,viewModel.cryptos,viewModel.currency);
          }
        },
        converter: (store) => CurrencyListViewModel.fromStore(store),
        builder: (_, viewModel) => content(viewModel),
      )),
    );
  }

  Widget content(CurrencyListViewModel viewModel) =>
      viewModel.loadingStatus != LoadingStatus.loading?Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            header(viewModel),
            Divider(
              height: 1.0,
              color: Colors.black,
            ),
            Expanded(
              child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                controller: _refreshController,
                onRefresh: (v){
                  viewModel.requestRates(false,viewModel.cryptos,viewModel.currency);
                  Future.delayed(Duration(seconds: 2)).then((v){
                    _refreshController.sendBack(true, RefreshStatus.completed);
                  });
                },
                child: ListView.builder(
                    itemCount: viewModel.rates.length,
                    itemBuilder: (BuildContext context, int position) => Container(
                      height: 80.0,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Image(image: AssetImage(currency_images[viewModel.rates[position].cryptoCurrency]),),
                          ),
                          Expanded(
                            child: Padding(padding: EdgeInsets.only(left: 16.0,right: 16.0,top: 16.0, bottom: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Text(currency_names[viewModel.rates[position].cryptoCurrency],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: new Text(viewModel.rates[position].cryptoCurrency,
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
                          Padding(padding: EdgeInsets.only(right: 16.0),
                            child: Text('${viewModel.rates[position].rate.rate} ${viewModel.rates[position].rate.currency}',
                            ),
                          )
                        ],
                      ),
                    ),
                ),
              ),
            )
          ],
        ),
      ):Center(
        child: Text("Loading"),
      );

  Widget header(CurrencyListViewModel viewModel) =>Container(
    height: 48.0,
    child: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          child: Center(
            child: Text("Exchange rates",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17.0,
              ),
            ),
          ),
        ),
        Positioned(
          right: 16.0,
          bottom: 0.0,
          top: 0.0,
          child: GestureDetector(
            onTap: (){

            },
            child: Padding(
              padding: const EdgeInsets.only(top:12.0, bottom: 12.0),
              child: Image(image: AssetImage("assets/images/settings.png")),
            ),
          ),
        )
      ],
    ),
  );
}
