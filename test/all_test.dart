// ignore_for_file: unnecessary_lambdas

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:table/table.dart';

void main() {
  group('unit', () {
    late Object value;
    setUpAll(() {
      value = '[\n'
          ' {\n'
          '  "id": "1",\n'
          '  "name": "John",\n'
          '  "age": "25",\n'
          ' },\n'
          ' {\n'
          '  "id": "2",\n'
          '  "name": "Jane",\n'
          '  "age": "24",\n'
          ' }\n'
          ']';
    });
    test('placeholder', () {
      expect(
          () => DataGrid.value(
                value: value,
                columns: <DataGridColumn>[],
              ),
          returnsNormally);
      expect(
        DataGrid.value(
          value: value,
          columns: <DataGridColumn>[],
        ),
        isA<DataGrid>(),
      );
    });
    testWidgets(
      'pump',
      (tester) async {
        await tester.pumpWidget(
          DataGrid.value(
            value: value,
            columns: <DataGridColumn>[],
          ),
        );
        expect(find.byType(DataGrid), findsOneWidget);
      },
    );
  });
}
