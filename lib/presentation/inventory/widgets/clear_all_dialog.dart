import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iverson/application/bloc.dart';
import 'package:iverson/presentation/shared/extensions/media_query_extensions.dart';

class ClearAllDialog extends StatefulWidget {
  const ClearAllDialog({Key? key}) : super(key: key);

  @override
  State<ClearAllDialog> createState() => _ClearAllDialogState();
}

class _ClearAllDialogState extends State<ClearAllDialog> {
  String? _itemToClear;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final items = [
      'products',
    ];
    return AlertDialog(
      title: Text('Clear All', style: theme.textTheme.titleMedium),
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
      context.read<InventoryBloc>().add(const InventoryEvent.clearAllProducts());
    }

    Navigator.pop(context);
  }
}
