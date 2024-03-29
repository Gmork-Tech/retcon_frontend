import 'package:flutter/material.dart';

extension DialogExtension on BuildContext {

  Future<void> showErrorDialog(dynamic exception) => showDialog<void>(
    context: this,
    builder: (ctx) => AlertDialog(
      title: const Text('Error'),
      content: Text(exception.toString()),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text('OK'),
        )
      ],
    ),
  );

  Future<bool?> showDisconnectDialog() => showDialog<bool>(
    context: this,
    builder: (ctx) => AlertDialog(
      title: const Text('Disconnect'),
      content: const Text('Are you sure to disconnect?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('Disconnect'),
        ),
      ],
    ),
  );

  Future<bool?> showReconnectDialog() => showDialog<bool>(
    context: this,
    builder: (ctx) => AlertDialog(
      title: const Text('Reconnect'),
      content: const Text('This will force a reconnection'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('Reconnect'),
        ),
      ],
    ),
  );

  Future<bool?> showSendDataDialog() => showDialog<bool>(
    context: this,
    builder: (ctx) => AlertDialog(
      title: const Text('Send data'),
      content: const Text(
          'This will send a sample data to all participants in the room'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('Send'),
        ),
      ],
    ),
  );

  Future<bool?> showDataReceivedDialog(String data) => showDialog<bool>(
    context: this,
    builder: (ctx) => AlertDialog(
      title: const Text('Received data'),
      content: Text(data),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}