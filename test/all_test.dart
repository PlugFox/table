// ignore_for_file: unnecessary_lambdas

import 'package:flutter_test/flutter_test.dart';

import 'package:table/table.dart';

void main() {
  test('placeholder', () {
    expect(() => DataGrid(), returnsNormally);
    expect(DataGrid(), isA<DataGrid>());
  });
}
