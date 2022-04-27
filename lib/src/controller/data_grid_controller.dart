import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:table/src/entity/row.dart';

/// {@template data_grid_controller.data_grid_controller}
/// DataGridController
/// {@endtemplate}
class DataGridController extends ChangeNotifier
    implements ValueListenable<Iterable<DataGridRow>> {
  /// {@macro data_grid_controller.data_grid_controller}
  DataGridController.empty()
      : _tableData = UnmodifiableListView<DataGridRow>(
          List<DataGridRow>.empty(growable: false),
        );

  /// {@macro data_grid_controller.data_grid_controller}
  DataGridController(Iterable<DataGridRow> tableData)
      : _tableData = UnmodifiableListView<DataGridRow>(
          tableData.toList(growable: false),
        );

  /// {@macro data_grid_controller.data_grid_controller}
  ///
  /// [data] must be convertable to JSON.
  factory DataGridController.convert(Object data) {
    try {
      if (data is Map<String, Object?>) {
        return DataGridController(<DataGridRow>[DataGridRow(data)]);
      } else if (data is Iterable) {
        data = data.toList(growable: false);
        if (data is Iterable<DataGridRow>) {
          return DataGridController(data);
        } else if (data is Iterable<Map<String, Object?>>) {
          return DataGridController(
            data.map<DataGridRow>(DataGridRow.new),
          );
        } else {
          return DataGridController.convert(
            data.whereType<Object>().map<Map<String, Object?>>(
                  (Object e) => e is Map<String, Object?>
                      ? e
                      // ignore: avoid_dynamic_calls
                      : (data as dynamic).toJson() as Map<String, Object?>,
                ),
          );
        }
      } else if (data is String) {
        return DataGridController.convert(jsonDecode(data) as Object);
      } else {
        return DataGridController.convert(
          // ignore: avoid_dynamic_calls
          (data as dynamic).toJson() as Object,
        );
      }
    } on Object catch (_, stackTrace) {
      Error.throwWithStackTrace(
        FormatException(
          'The passed object "${Error.safeToString(data)}" is '
          'not converted to a hash table using the method "toJson()"',
        ),
        stackTrace,
      );
    }
  }

  UnmodifiableListView<DataGridRow> _tableData;

  /// Set new data to the table.
  void setTable(List<DataGridRow> newTableData) {
    if (listEquals(_tableData, newTableData)) return;

    _tableData = UnmodifiableListView<DataGridRow>(
      List<DataGridRow>.of(newTableData, growable: false),
    );
    notifyListeners();
  }

  @override
  Iterable<DataGridRow> get value => _tableData;
}
