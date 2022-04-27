import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:table/table.dart';

/// {@template data_grid.data_grid}
/// DataGrid
/// {@endtemplate}
class DataGrid extends StatefulWidget {
  /// {@macro data_grid.data_grid}
  const DataGrid({
    this.controller,
    Key? key,
  }) : super(key: key);

  /// Controller of the DataGrid.
  final DataGridController? controller;

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
    with _DataGridControllerLifecycleMixin {
  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    _updateController();
  }

  @override
  void didUpdateWidget(DataGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Изменилась конфигурация InheritedWidget'ов
    // Также вызывается после initState, но до build'а
  }

  @override
  void dispose() {
    _closeController();
    super.dispose();
  }
  /* #endregion */

  @override
  Widget build(BuildContext context) => RepaintBoundary(
        child: Placeholder(),
      );
} // _DataGridState

mixin _DataGridControllerLifecycleMixin on State<DataGrid> {
  late DataGridController _controller;
  DataGridController get controller => _controller;
  bool _internal = false;

  /// Controller created by the widget, internal
  bool get internalController => _internal;

  /// Controller received from outside, external
  bool get externalController => !_internal;

  void _updateController() {
    final newController = widget.controller;
    if (identical(_controller, newController)) return;
    _closeController();
    if (newController == null) {
      _controller = DataGridController();
      _internal = true;
    } else {
      _controller = newController;
      _internal = false;
    }
  }

  void _closeController() {
    if (!_internal) return;
    final oldController = _controller;
    scheduleMicrotask(oldController.dispose);
  }
}
