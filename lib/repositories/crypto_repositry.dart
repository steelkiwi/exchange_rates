
import 'package:crypto_exchange/utils/rest_client.dart';
import 'package:crypto_exchange/data/errors.dart';

class CryptoRepository{
  RestClient restClient;

  CryptoRepository(this.restClient);

  void getRates(List<String> cryptos, String currency,{ Function (Map<String,dynamic>) success, Function (Error) error}){
    int iter = 0;
    var c = "";
    cryptos.forEach((cur){
      if(iter == 0){
        c+="?fsyms=$cur";
        iter++;
      }else{
        c+=",$cur";
      }
    });
    var cur = "&tsyms=$currency";
    restClient.get("/pricemulti"+c+cur,
        success: (response){
          Map<String,Map<String,double>> result = new Map();
          Map<String,dynamic> raw = response;
          raw.forEach((s,d){
            Map<String, double> inner = Map();
            (d as Map<String,dynamic>).forEach((ss,dd){
              inner[ss] = dd as double;
            });
            result[s] = inner;
          });
          success(result);
        },
        error: (err){
          Error e = Error.fromJson(err.data);
          error(e);
        }
    );
  }

}