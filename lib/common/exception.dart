class ServerException implements Exception {}

class NoInternetConnectionException implements Exception {
  String? message;

  NoInternetConnectionException([this.message]);
}
