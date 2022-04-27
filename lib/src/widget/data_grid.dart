import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:table/src/widget/header.dart';
import 'package:table/table.dart';

/// {@template data_grid.data_grid}
/// DataGrid table
/// {@endtemplate}
class DataGrid extends StatefulWidget {
  /// {@macro data_grid.data_grid}
  const DataGrid({
    required DataGridController? controller,
    required List<DataGridColumn> columns,
    this.options = const DataGridOptions(),
    Key? key,
  })  : _columns = columns,
        _controller = controller,
        _data = null,
        super(key: key);

  /// {@macro data_grid.data_grid}
  ///
  /// [value] must contain toJson method.
  const DataGrid.value({
    required Object value,
    required List<DataGridColumn> columns,
    this.options = const DataGridOptions(),
    Key? key,
  })  : _columns = columns,
        _controller = null,
        _data = value,
        super(key: key);

  /// Columns of the table.
  final List<DataGridColumn> _columns;

  /// Controller of the table.
  final DataGridController? _controller;

  /// Data of the table.
  final Object? _data;

  /// Options
  final DataGridOptions options;

  /// The controller from the closest instance of this class
  /// that encloses the given context, if any.
  @internal
  static DataGridController? maybeOf(BuildContext context) =>
      context.findAncestorStateOfType<_DataGridState>()?.controller;

  @override
  State<DataGrid> createState() => _DataGridState();
} // DataGrid

/// State for widget DataGrid
class _DataGridState extends State<DataGrid>
    with _DataGridColumnsOwnerMixin, _DataGridControllerLifecycleMixin {
  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    _updateColumns();
    _updateController();
  }

  @override
  void didUpdateWidget(DataGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateColumns();
    _updateController();
  }

  @override
  void dispose() {
    _closeController();
    super.dispose();
  }
  /* #endregion */

  @override
  Widget build(BuildContext context) => Directionality(
        textDirection: Directionality.maybeOf(context) ?? TextDirection.ltr,
        child: CustomScrollView(
          slivers: <Widget>[
            DataGridHeader(
              options: widget.options,
            ),
            SliverFixedExtentList(
              itemExtent: 50,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) => Container(
                  alignment: Alignment.center,
                  color: Color(100 * (index % 9)),
                  child: Text('list item $index'),
                ),
              ),
            ),
          ],
        ),
      );
} // _DataGridState

mixin _DataGridControllerLifecycleMixin
    on State<DataGrid>, _DataGridColumnsOwnerMixin {
  /// Controller of the table.
  DataGridController? _controller;
  DataGridController get controller => _controller!;
  bool _internal = false;

  /// Controller created by the widget, internal
  bool get internalController => _internal;

  /// Controller received from outside, external
  bool get externalController => !_internal;

  void _updateController() {
    final newController = widget._controller;
    if (identical(_controller, newController)) return;
    _closeController();
    if (newController == null) {
      final data = widget._data;
      assert(data != null, 'DataGrid.data must not be null');
      _controller = DataGridController.convert(data!);
      _internal = true;
    } else {
      _controller = newController;
      _internal = false;
    }
  }

  void _closeController() {
    if (!_internal) return;
    final oldController = _controller;
    scheduleMicrotask(oldController!.dispose);
  }
}

mixin _DataGridColumnsOwnerMixin on State<DataGrid> {
  List<DataGridColumn>? _columns;
  List<DataGridColumn> get columns => _columns!;

  void _updateColumns() {
    final newColumns = widget._columns;
    if (listEquals(_columns, newColumns)) return;
    _columns = List<DataGridColumn>.of(
      newColumns,
      growable: false,
    );
  }
}
