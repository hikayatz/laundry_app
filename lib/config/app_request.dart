class AppRequest {
  static Map<String, String> header([String? bearerToken]) {
    var map = {"Accept": "application/json"};
    if (bearerToken != null) {
      map["Authorization"] = 'Bearer $bearerToken';
    }
    return map;
  }
}
