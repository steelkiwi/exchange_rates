class ShowList {

  List<ShowCurrencyPair> showList;


  ShowList(this.showList);

  ShowList.fromJsonMap(Map<String, dynamic> map):
        showList = List<ShowCurrencyPair>.from(map["show_list"].map((it) => ShowCurrencyPair.fromJsonMap(it)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.showList != null) {
      data['show_list'] = this.showList.map((v) => v.toJson()).toList();
    }
    return data;
  }

}

class ShowCurrencyPair {

  String currency;
  bool show;

  ShowCurrencyPair(this.currency, this.show);

  ShowCurrencyPair.fromJsonMap(Map<String, dynamic> map):
        currency = map["currency"],
        show = map["show"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency'] = this.currency;
    data['show'] = this.show;
    return data;
  }
}
