part of 'validator.dart';

class DescriptionValidator extends Validator {
  @override
  Either<ValidationFailure, void> validate(String value) {
    if (value.isEmpty) {
      return const Left(ValidationFailure(message: 'Please enter a description'));
    }

    return const Right(null);
  }
}
