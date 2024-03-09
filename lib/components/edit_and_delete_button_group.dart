import 'package:flutter/material.dart';

class EditAndDeleteButtonGroup extends StatelessWidget {

  final VoidCallback onEdit;

  final VoidCallback onDelete;

  const EditAndDeleteButtonGroup({
    super.key,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      mainAxisSize: MainAxisSize.max,
      alignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: onEdit,
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onDelete,
        ),
      ],
    );
  }
}
