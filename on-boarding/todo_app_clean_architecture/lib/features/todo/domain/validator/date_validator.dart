part of 'validator.dart';

class DateValidator extends Validator {
  @override
  Either<ValidationFailure, void> validate(String value) {
    if (value.isEmpty) {
      return Left(ValidationFailure(message: 'Please enter a date'));
    }

    final date = DateTime.tryParse(value);

    if (date == null) {
      return Left(ValidationFailure(message: 'Invalid date format'));
    }

    if (date.isBefore(DateTime.now())) {
      return Left(ValidationFailure(message: 'Date is in the past'));
    }

    return const Right(null);
  }
}
