import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iverson/application/bloc.dart';
import 'package:iverson/presentation/shared/extensions/media_query_extensions.dart';

class ClearAll extends StatefulWidget {
  const ClearAll({Key? key}) : super(key: key);

  @override
  State<ClearAll> createState() => _ClearAllState();
}

class _ClearAllState extends State<ClearAll> {
  String? _itemToClear;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final items = [
      'products',
    ];
    return AlertDialog(
      title: const Text('Clear All'),
      content: SizedBox(
        width: MediaQuery.of(context).getWidthForDialogs(),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (ctx, index) {
            final item = items.elementAt(index);
            return ListTile(
              key: Key('$index'),
              title: Text(item, overflow: TextOverflow.ellipsis),
              selectedTileColor: theme.colorScheme.secondary.withOpacity(0.2),
              selected: _itemToClear == item,
              onTap: () {
                setState(() {
                  _itemToClear = item;
                });
              },
            );
          },
        ),
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: TextStyle(color: theme.primaryColor)),
        ),
        ElevatedButton(
          onPressed: () => _clearAll(context),
          child: const Text('Okay'),
        )
      ],
    );
  }

  void _clearAll(BuildContext context) {
    if (_itemToClear == 'products') {
      context.read<CartBloc>().add(const CartEvent.clearAllProducts());
    }

    Navigator.pop(context);
  }
}
