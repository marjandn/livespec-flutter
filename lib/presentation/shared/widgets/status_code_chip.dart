import 'package:flutter/material.dart';
import '../utils/http_method_utils.dart';

/// Reusable widget for displaying status code chips
class StatusCodeChip extends StatelessWidget {
  final String code;

  const StatusCodeChip({
    super.key,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    final color = HttpMethodUtils.getStatusCodeColor(code);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color),
      ),
      child: Text(
        code,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

