import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../shared/widgets/copyable_text_field.dart';

/// Widget for displaying the mocked base URL
class BaseUrlCard extends StatelessWidget {
  final String baseUrl;

  const BaseUrlCard({
    super.key,
    required this.baseUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.api, color: Colors.blue[700], size: 28),
                const SizedBox(width: 12),
                const Text(
                  'Mocked Base URL',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            CopyableTextField(
              text: baseUrl,
              label: 'Base URL',
            ),
          ],
        ),
      ),
    );
  }
}

