import 'package:equatable/equatable.dart';

import 'exception.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});

  factory CacheFailure.cacheNotFound() =>
      const CacheFailure(message: 'Cache not found');

  factory CacheFailure.readError() =>
      const CacheFailure(message: 'Error while parsing json');

  factory CacheFailure.fromException(CacheException exception) {
    switch (exception) {
      case CacheException.cacheNotFound:
        return CacheFailure.cacheNotFound();
      case CacheException.readError:
        return CacheFailure.readError();
      default:
        return const CacheFailure(message: 'Unknown error');
    }
  }
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message});

  factory ServerFailure.invalidResponse() =>
      const ServerFailure(message: 'Invalid JSON format');

  factory ServerFailure.operationFailed() =>
      const ServerFailure(message: 'Operation failed');

  factory ServerFailure.connectionFailed() =>
      const ServerFailure(message: 'Unable to connect to server');

  factory ServerFailure.fromException(ServerException exception) {
    switch (exception) {
      case ServerException.invalidResponse:
        return ServerFailure.invalidResponse();
      case ServerException.operationFailed:
        return ServerFailure.operationFailed();
      case ServerException.connectionFailed:
        return ServerFailure.connectionFailed();
      default:
        return const ServerFailure(message: 'Unknown error');
    }
  }
}
