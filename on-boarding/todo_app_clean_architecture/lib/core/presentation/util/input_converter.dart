import 'package:dartz/dartz.dart';

import '../../error/failures.dart';

class InputConverter {
  Either<InvalidInputFailure, DateTime> stringToDateTime(String str) {
    try {
      final date = DateTime.parse(str);
      if (DateTime.now().isAfter(date)) {
        return Left(InvalidInputFailure(message: 'Date is in the past'));
      }
      return Right(date);
    } on FormatException {
      return Left(InvalidInputFailure(message: 'Invaid date format'));
    }
  }
}

class InvalidInputFailure extends Failure {
  final String message;

  InvalidInputFailure({this.message = 'Invalid input'}) : super();

  @override
  List<Object?> get props => [message];
}
