part of 'validator.dart';

class DescriptionValidator extends Validator {
  @override
  Either<ValidationFailure, void> validate(String value) {
    if (value.isEmpty) {
      return Left(ValidationFailure.emptyDescription());
    }

    return const Right(null);
  }
}
