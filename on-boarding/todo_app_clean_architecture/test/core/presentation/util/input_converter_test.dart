import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app_clean_architecture/core/presentation/util/input_converter.dart';

void main() {
  group('InputConverter', () {
    late InputConverter inputConverter;

    setUp(() {
      inputConverter = InputConverter();
    });

    group('stringToDateTime', () {
      test('should return a datetime when the string represents a vaild date',
          () {
        // arrange
        const str = '2040-01-01';
        final expected = DateTime(2040, 01, 01);

        // act
        final result = inputConverter.stringToDateTime(str);

        // assert
        expect(result, Right(expected));
      });

      test('should return a Failure when the string is not valid date format',
          () {
        // arrange
        const str = '2020-01';

        // act
        final result = inputConverter.stringToDateTime(str);

        // assert
        expect(
            result,
            Left<InvalidInputFailure, DateTime>(
                InvalidInputFailure(message: 'Invalid date format')));
      });

      // test('should return a Failure when the date is the past', () {
      //   // arrange
      //   const str = '2020-01-01';

      //   // act
      //   final result = inputConverter.stringToDateTime(str);

      //   // assert
      //   expect(
      //       result, Left(InvalidInputFailure(message: 'Date is in the past')));
      // });
    });
  });
}
