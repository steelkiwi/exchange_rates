
class Error {
  String errorMessage;

  Error.fromJson(Map<String,dynamic> json) {
    var errors = new List<String>();
    json.forEach((s,l){
      var list = json[s].cast<String>();
      errors.addAll(list);
    });
    var uniqueErrors = errors.toSet();
    var error = "";
    if(uniqueErrors.isNotEmpty){
      uniqueErrors.forEach((s){
        error+=s;
        error+='\n';
      });
    }
    errorMessage = error;
  }
}