part of 'validator.dart';

class TitleValidator extends Validator {
  @override
  Either<ValidationFailure, void> validate(String value) {
    if (value.isEmpty) {
      return const Left(ValidationFailure(message: 'Please enter a title'));
    }

    return const Right(null);
  }
}
