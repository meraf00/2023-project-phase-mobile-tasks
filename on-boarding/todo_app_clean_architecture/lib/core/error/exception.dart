class CacheException implements Exception {
  final String message;

  CacheException({required this.message}) : super();
}

class ServerException implements Exception {
  final String message;

  ServerException({required this.message}) : super();
}
