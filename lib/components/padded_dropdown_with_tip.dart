import 'package:flutter/material.dart';

class PaddedDropdownWithTip<T> extends StatelessWidget {

  final String tipMessage;
  final EdgeInsets padding;
  final String label;
  final ValueChanged<T?>? onSelected;
  final T? initialValue;
  final List<DropdownMenuEntry<T>> values;
  const PaddedDropdownWithTip({
    super.key,
    required this.padding,
    required this.label,
    required this.tipMessage,
    required this.onSelected,
    required this.values,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownMenu(
            onSelected: onSelected,
            label: Text(label),
            initialSelection: initialValue,
            dropdownMenuEntries: values,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Tooltip(
                message: tipMessage,
                child: const Icon(
                  IconData(0xf816, fontFamily: 'MaterialIcons'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
