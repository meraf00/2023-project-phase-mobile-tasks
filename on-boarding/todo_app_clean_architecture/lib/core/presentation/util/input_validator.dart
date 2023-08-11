import 'package:dartz/dartz.dart';
import 'validator/validator.dart';
import '../../../injection_container.dart';

String? dateValidator(String? value) {
  final result = serviceLocator<DateValidator>().validate(value ?? "");

  if (result.isLeft()) {
    return (result as Left<ValidationFailure, void>).value.message;
  }

  return null;
}

String? titleValidator(String? value) {
  final result = serviceLocator<TitleValidator>().validate(value ?? "");

  if (result.isLeft()) {
    return (result as Left<ValidationFailure, void>).value.message;
  }

  return null;
}

String? descriptionValidator(String? value) {
  final result = serviceLocator<DescriptionValidator>().validate(value ?? "");

  if (result.isLeft()) {
    return (result as Left<ValidationFailure, void>).value.message;
  }

  return null;
}
