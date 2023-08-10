import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

part 'date_validator.dart';
part 'description_validator.dart';
part 'title_validator.dart';

abstract class Validator {
  Either<ValidationFailure, void> validate(String value);
}

class ValidationFailure extends Failure {
  final String message;

  ValidationFailure({required this.message});

  @override
  List<Object?> get props => [message];
}