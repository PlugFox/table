// ignore_for_file: public_member_api_docs

import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';
import 'package:table/src/entity/options.dart';

/// {@template header.data_grid_header}
/// DataGridHeader
/// {@endtemplate}
@internal
class DataGridHeader extends StatelessWidget {
  /// {@macro header.data_grid_header}
  const DataGridHeader({
    required this.options,
    Key? key,
  }) : super(key: key);

  final DataGridOptions options;

  @override
  Widget build(BuildContext context) => SliverPersistentHeader(
        pinned: options.headerPinned,
        floating: options.headerFloating,
        delegate: DataGridHeaderDelegate(
          height: options.headerHeight,
        ),
      );
} // DataGridHeader

/// {@template header.data_grid_header_delegate}
/// DataGridHeader
/// {@endtemplate}
@internal
class DataGridHeaderDelegate extends SliverPersistentHeaderDelegate {
  /// {@macro header.data_grid_header_delegate}
  const DataGridHeaderDelegate({
    required this.height,
  });

  final double height;

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) =>
      PreferredSize(
        preferredSize: Size.fromHeight(height),
        child: const Placeholder(),
      );
} // DataGridHeaderDelegate
