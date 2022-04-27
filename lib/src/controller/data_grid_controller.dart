import 'package:flutter/foundation.dart';

/// {@template data_grid_controller.data_grid_controller}
/// DataGridController
/// {@endtemplate}
class DataGridController extends ValueNotifier<String> {
  /// {@macro data_grid_controller.data_grid_controller}
  DataGridController() : super('');

  @override
  set value(String value) => throw UnimplementedError();
}
