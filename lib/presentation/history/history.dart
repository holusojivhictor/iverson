import 'package:flutter/material.dart';
import 'package:iverson/presentation/shared/nothing_found_column.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const NothingFoundColumn(msg: "In Progress");
  }
}
