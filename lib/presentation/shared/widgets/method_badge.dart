import 'package:flutter/material.dart';
import '../utils/http_method_utils.dart';

/// Reusable widget for displaying HTTP method badges
class MethodBadge extends StatelessWidget {
  final String method;
  final bool showIcon;
  final double? fontSize;

  const MethodBadge({
    super.key,
    required this.method,
    this.showIcon = true,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final methodColor = HttpMethodUtils.getMethodColor(method);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: methodColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: methodColor,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            Icon(
              HttpMethodUtils.getMethodIcon(method),
              size: fontSize != null ? fontSize! - 4 : 14,
              color: methodColor,
            ),
            const SizedBox(width: 6),
          ],
          Text(
            method.toUpperCase(),
            style: TextStyle(
              color: methodColor,
              fontWeight: FontWeight.bold,
              fontSize: fontSize ?? 11,
            ),
          ),
        ],
      ),
    );
  }
}

