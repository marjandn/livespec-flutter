import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Reusable widget for displaying copyable text with copy button
class CopyableTextField extends StatelessWidget {
  final String text;
  final String? label;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool showCopyButton;

  const CopyableTextField({
    super.key,
    required this.text,
    this.label,
    this.textStyle,
    this.backgroundColor,
    this.borderColor,
    this.showCopyButton = true,
  });

  void _copyToClipboard(BuildContext context, String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label copied to clipboard'),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor ?? Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Expanded(
            child: SelectableText(
              text,
              style: textStyle ??
                  const TextStyle(
                    fontSize: 14,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          if (showCopyButton)
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () => _copyToClipboard(
                context,
                text,
                label ?? 'Text',
              ),
              tooltip: 'Copy ${label ?? 'text'}',
            ),
        ],
      ),
    );
  }
}

