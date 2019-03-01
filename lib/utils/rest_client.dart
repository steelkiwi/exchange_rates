import 'package:crypto_exchange/utils/constants.dart';
import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';


class RestClient{

  Dio dio = new Dio();
  SharedPreferences _pref;
  Connectivity _connectivity;


  RestClient(this._pref){
    dio.options.baseUrl ="https://min-api.cryptocompare.com/data";
    dio.options.connectTimeout = 60000; //30s
    dio.options.receiveTimeout=60000;
    _connectivity = new Connectivity();
    onSendInterceptors();
  }

  void onSendInterceptors() {
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options){
         options.headers["Authorization"] = "Apikey $API_KEY";
      return options;
    },
    ));
  }


 void post(String path,{dynamic data, Function(Map<String, dynamic>) success ,Function(Response) error, CancelToken cancelToken}) {
    _connectivity.checkConnectivity().then((_result){
      if(_result == ConnectivityResult.none){
        error(new Response(
            data: {"error":["No internet connectivity."]}
        ));
      }else{
        dio.post(path,data: data,cancelToken: cancelToken).then((response){
          if(response.data != null){
            if (success!=null) {
              success(response.data);
            }
            print("URL:"+ response.request.baseUrl+response.request.path+ " - Response: "+response.data.toString());
          }else{
            if (success!=null) {
              success({});
            }
            print("URL:"+ response.request.baseUrl+response.request.path);
          }
        }).catchError((e){
          if (e is DioError) {
            DioError err = e as DioError;
            if(err.response != null) {
              if (error != null) {
                try {
                  error(err.response);
                } catch (e) {
                  print(e);
                  error(new Response(
                      data: {"error":["Unknown error."]}
                  ));
                }
              }
              print("Post error: "+err.response.data.toString());
            } else{
              error(new Response(
                  data: {"error":["Unknown error."]}
              ));
            }
          }
        });
      }
    });
  }

  void get(String path,{dynamic data, Function(Map<String, dynamic>) success ,Function(Response) error, CancelToken cancelToken}){
    _connectivity.checkConnectivity().then((_result){
      if(_result == ConnectivityResult.none){
        error(new Response(
            data: {"error":["No internet connectivity."]}
        ));
      }else{
        dio.get(path,cancelToken: cancelToken).then((response){
          if(response.data != null){
            print("URL:"+ response.request.baseUrl+response.request.path+ " - Response: "+response.data.toString());
            success(response.data);
          }else{
            print("URL:"+ response.request.baseUrl+response.request.path);
            success({});
          }
        }).catchError((e){
          if (e is DioError) {
            DioError err = e as DioError;
            if (err.response.statusCode < 500) {
              if(err.response != null) {
                            print("Post error: "+err.response.data.toString());
                            error(err.response);
                          } else{
                            // Something happened in setting up or sending the request that triggered an Error
                          }
            }
          }
        });
      }
    });
  }

  Future<Map<String, dynamic>> getSync(String path) async{

    ConnectivityResult result = await   _connectivity.checkConnectivity();
    if(result == ConnectivityResult.none){
      return {"error":["No internet connectivity."]};
    }else{
      try {
        Response<Map<String, dynamic>> response = await dio.get(path);
        if(response!= null && response.data!=null){
                return response.data;
              }else{
                return {};
              }
      } catch (e) {
        print(e);
        return {};
      }
    }
  }

  void patch(String path,{dynamic data, Function(Map<String, dynamic>) success ,Function(Response) error, CancelToken cancelToken}){
    _connectivity.checkConnectivity().then((_result){
      if(_result == ConnectivityResult.none){
        error(new Response(
            data: {"error":["No internet connectivity."]}
        ));
      }else{
        dio.patch(path,data: data,cancelToken: cancelToken).then((response){
          if(response.data != null){
            print("URL:"+ response.request.baseUrl+response.request.path+ " - Response: "+response.data.toString());
            success(response.data);
          }else{
            print("URL:"+ response.request.baseUrl+response.request.path);
            success({});
          }
        }).catchError((e){
          DioError err = e as DioError;
          if(err.response != null) {
            print("Post error: "+err.response.data.toString());
            error(err.response);
          } else{
            // Something happened in setting up or sending the request that triggered an Error
          }
        });
      }
    });
  }

  void delete(String path,{dynamic data, Function success ,Function(Response) error, CancelToken cancelToken}){
    _connectivity.checkConnectivity().then((_result){
      if(_result == ConnectivityResult.none){
        error(new Response(
            data: {"error":["No internet connectivity."]}
        ));
      }else{
        dio.delete(path,
        ).then((response){
          if(response.data != null && response.data.toString().isNotEmpty){
            success();
            print("URL:"+ response.request.baseUrl+response.request.path+ " - Response: "+response.data.toString());
          }else{
            success();
            print("URL:"+ response.request.baseUrl+response.request.path);
          }
        }).catchError((e){
          if (e is DioError) {
            DioError err = e as DioError;
            if(err.response != null) {
              print("Post error: "+err.response.data.toString());
              error(err.response);
            } else{
              print(e);
            }
          }
        });
      }
    });
  }

  void put(String path, {dynamic data, Function(Map<String, dynamic>) success ,Function(Response) error, CancelToken cancelToken, Function noConnection}){
    _connectivity.checkConnectivity().then((_result){
      if(_result == ConnectivityResult.none){
        error(new Response(
            data: {"error":["No internet connectivity."]}
        ));
      }else{
        dio.put(path,
          data: data,
        ).then((response){
          if(response.data != null){
            print("URL:"+ response.request.baseUrl+response.request.path+ " - Response: "+response.data.toString());
            success(response.data);
          }else{
            print("URL:"+ response.request.baseUrl+response.request.path);
            success({});
          }
        }).catchError((e){
          if (e is DioError) {
            DioError err = e as DioError;
            if(err.response != null) {
              print("Post error: "+err.response.data.toString());
              error(err.response);
            } else{
              // Something happened in setting up or sending the request that triggered an Error
            }
          }
        });
      }
    });
  }
}