import 'package:meta/meta.dart';

/// {@template row.data_grid_row}
/// DataGridRGridRow
/// {@endtemplate}
@immutable
class DataGridRow {
  /// {@macro row.data_grid_row}
  const DataGridRow(Map<String, Object?> data) : _data = data;

  final Map<String, Object?> _data;

  /// Make a new instance of [DataGridRow].
  DataGridRow copy() => DataGridRow(toJson());

  /// Convert to JSON
  Map<String, Object?> toJson() => Map<String, Object?>.from(_data);

  @override
  String toString() => _data.values.join(' | ');
} // DataGridRow
