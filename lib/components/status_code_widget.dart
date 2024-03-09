import 'package:flutter/material.dart';

class StatusCodeWidget extends StatelessWidget {
  final Object err;
  final StackTrace? stackTrace;
  const StatusCodeWidget({required Key key, required this.err, this.stackTrace}) : super(key: key);

  InlineSpan generateTextBody(Object err, BuildContext ctx) {
    List<TextSpan> details = [];
    details.add(const TextSpan(text: 'Woops! \n', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26)));
    details.add(TextSpan(text: 'Error details: $err'));
    details.add(TextSpan(text: 'Stacktrace: $stackTrace'));
    return TextSpan(style: DefaultTextStyle.of(ctx).style, children: details);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Card(
          key: UniqueKey(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              softWrap: true,
              text: generateTextBody(err, context)
            ),
          ),
        ),
      ),
    );
  }
}
