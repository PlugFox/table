import 'package:flutter/widgets.dart';

/// {@template column.data_grid_column}
/// DataGridColumn
/// {@endtemplate}
@immutable
class DataGridColumn {
  /// {@macro column.data_grid_column}
  const DataGridColumn({
    required this.id,
    String? title,
    this.frozen = false,
    this.filterable = false,
    this.sortable = false,
    this.textAlign = TextAlign.left,
    this.flex = 1,
    this.width,
  })  : title = title ?? id,
        assert(width == null || width > 0, 'width must be greater than 0');

  /// Name of the column.
  /// This is the key in the data table (HashMap<String, Object?>).
  final String id;

  /// Title of the column.
  final String title;

  /// Whether the column is frozen.
  final bool frozen;

  /// Whether the column is filterable.
  final bool filterable;

  /// Whether the column is sortable.
  final bool sortable;

  /// Text alignment of the column.
  final TextAlign textAlign;

  /// The flex factor to use for this child.
  ///
  /// If null or zero, the child is inflexible and determines its own size. If
  /// non-zero, the amount of space the child's can occupy in the main axis is
  /// determined by dividing the free space (after placing the inflexible
  /// children) according to the flex factors of the flexible children.
  final int flex;

  /// Width of the column.
  final double? width;

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataGridColumn &&
          runtimeType == other.runtimeType &&
          id == other.id;
} // DataGridColumn


