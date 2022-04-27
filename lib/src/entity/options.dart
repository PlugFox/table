/// {@template options.options}
/// DataGridOptions
/// {@endtemplate}
class DataGridOptions {
  /// {@macro options.options}
  const DataGridOptions({
    this.headerHeight = 39,
    this.rowHeight = 57,
    this.headerFloating = false,
    this.headerPinned = false,
  });

  /// Header height.
  final double headerHeight;

  /// Row height.
  final double rowHeight;

  /// Floating header.
  final bool headerFloating;

  /// Pinned header.
  final bool headerPinned;

  /// Make copy of this object
  DataGridOptions copyWith({
    double? newHeaderHeight,
    double? newRowHeight,
    bool? newHeaderFloating,
    bool? newHeaderPinned,
  }) =>
      DataGridOptions(
        headerHeight: newHeaderHeight ?? headerHeight,
        rowHeight: newRowHeight ?? rowHeight,
        headerFloating: newHeaderFloating ?? headerFloating,
        headerPinned: newHeaderPinned ?? headerPinned,
      );
} // DataGridOptions
