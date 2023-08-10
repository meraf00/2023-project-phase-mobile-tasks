import 'package:dartz/dartz.dart';

import '../../error/failures.dart';

class InputConverter {
  String dateTimeToString(DateTime datetime) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    return "${months[datetime.month - 1]} ${datetime.day}, ${datetime.year}";
  }

  Either<InvalidInputFailure, DateTime> stringToDateTime(String str) {
    try {
      final date = DateTime.parse(str);
      return Right(date);
    } on FormatException {
      return Left(InvalidInputFailure(message: 'Invalid date format'));
    }
  }
}

class InvalidInputFailure extends Failure {
  final String message;

  InvalidInputFailure({this.message = 'Invalid input'}) : super();

  @override
  List<Object?> get props => [message];
}