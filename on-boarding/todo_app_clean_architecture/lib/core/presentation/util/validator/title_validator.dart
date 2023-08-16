part of 'validator.dart';

class TitleValidator extends Validator {
  @override
  Either<ValidationFailure, void> validate(String value) {
    if (value.isEmpty) {
      return Left(ValidationFailure.emptyTitle());
    }

    return const Right(null);
  }
}
