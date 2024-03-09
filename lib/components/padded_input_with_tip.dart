import 'package:flutter/material.dart';

class PaddedInputWithTip extends StatelessWidget {

  final String label;
  final String initialValue;
  final IconData? suffixIcon;
  final double? width;
  final TextInputType? inputType;
  final VoidCallback? onSuffixIconPressed;
  final void Function(String)? onChanged;
  final VoidCallback? onEditingComplete;
  final void Function(String?)? onSaved;
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function(String)? onFieldSubmitted;
  final String tipMessage;
  final EdgeInsets padding;
  final String? Function(String?)? validator;

  const PaddedInputWithTip({
    super.key,
    required this.initialValue,
    required this.label,
    required this.tipMessage,
    required this.padding,
    this.width,
    this.inputType,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.onChanged,
    this.onEditingComplete,
    this.onSaved,
    this.onTapOutside,
    this.onFieldSubmitted,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: width ?? 400,
            child: TextFormField(
              onChanged: onChanged,
              onEditingComplete: onEditingComplete,
              onTapOutside: onTapOutside,
              onSaved: onSaved,
              onFieldSubmitted: onFieldSubmitted,
              keyboardType: inputType,
              initialValue: initialValue,
              decoration: InputDecoration(
                labelText: label,
                suffixIcon: suffixIcon != null ? IconButton(
                  icon: Icon(suffixIcon),
                  onPressed: onSuffixIconPressed,
                ) : null,
              ),
              validator: validator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
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
