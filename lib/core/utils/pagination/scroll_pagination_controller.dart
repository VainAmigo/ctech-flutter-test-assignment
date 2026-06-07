import 'package:flutter/material.dart';

class ScrollPaginationController {
  ScrollPaginationController({
    required this.onLoadMore,
    this.threshold = 200,
  });

  final VoidCallback onLoadMore;
  final double threshold;

  final ScrollController controller = ScrollController();

  void attach() => controller.addListener(_onScroll);

  void dispose() {
    controller.removeListener(_onScroll);
    controller.dispose();
  }

  void _onScroll() {
    if (!controller.hasClients) return;

    final position = controller.position;
    if (position.pixels >= position.maxScrollExtent - threshold) {
      onLoadMore();
    }
  }
}
