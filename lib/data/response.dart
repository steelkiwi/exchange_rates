
class Response {

  double EUR;

  Response.fromJsonMap(Map<String, dynamic> map): 
    EUR = map["EUR"];

}
