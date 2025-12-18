import 'package:flutter/material.dart';

/// Reusable widget for displaying tags
class TagChip extends StatelessWidget {
  final String tag;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final double? fontSize;

  const TagChip({
    super.key,
    required this.tag,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.blue[50],
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: borderColor ?? Colors.blue[200]!,
          width: 0.5,
        ),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: textColor ?? Colors.blue[700],
          fontSize: fontSize ?? 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

