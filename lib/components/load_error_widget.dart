import 'package:flutter/material.dart';

class LoadErrorWidget extends StatelessWidget {
  const LoadErrorWidget({
    super.key,
    required this.title,
    required this.onRetry,
    this.message,
  });

  final String title;
  final String? message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              message ?? 'Неизвестная ошибка',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onRetry,
              child: const Text('Повторить'),
            ),
          ],
        ),
      ),
    );
  }
}
