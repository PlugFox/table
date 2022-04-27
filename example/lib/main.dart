// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:table/table.dart';

void main() => runZonedGuarded<void>(
      () => runApp(const App()),
      (error, stackTrace) => print('error: $error'),
    );

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Table Demo',
      home: Scaffold(
        body: SafeArea(
          child: HomePage(),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = DataGridController.empty();

  @override
  Widget build(BuildContext context) => Center(
        child: SizedBox(
          height: 400,
          width: 250,
          child: ColoredBox(
            color: Colors.red,
            child: DataGrid(
              columns: [],
              controller: controller,
              options: DataGridOptions(
                headerPinned: true,
              ),
            ),
          ),
        ),
      );
}
