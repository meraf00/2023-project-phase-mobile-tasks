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

    return '${months[datetime.month - 1]} ${datetime.day}, ${datetime.year}';
  }

  Either<InvalidInputFailure, DateTime> stringToDateTime(String str,
      {bool future = false}) {
    try {
      final date = DateTime.parse(str);

      if (future && date.isBefore(DateTime.now())) {
        return Left(InvalidInputFailure.invalidDate());
      }

      return Right(date);
    } on FormatException {
      return Left(InvalidInputFailure.invalidDateFormat());
    }
  }
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure({super.message = 'Invalid input'});

  factory InvalidInputFailure.invalidDateFormat() =>
      const InvalidInputFailure(message: 'Invalid date format');

  factory InvalidInputFailure.invalidDate() =>
      const InvalidInputFailure(message: 'Date is in the past');
}
