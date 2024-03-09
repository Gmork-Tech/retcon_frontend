import 'package:flutter/material.dart';

class PaddedChipWithTip extends StatelessWidget {
  final String label;
  final bool selected;
  final String tipMessage;
  final EdgeInsets padding;

  const PaddedChipWithTip({
    super.key,
    required this.label,
    required this.selected,
    required this.tipMessage,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        width: 400,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ChoiceChip(
              label: Text(label),
              selected: selected,
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
      ),
    );
  }
}
