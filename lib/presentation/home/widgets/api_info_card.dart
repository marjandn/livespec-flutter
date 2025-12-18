import 'package:flutter/material.dart';
import '../../../domain/entities/mocked_swagger_entity.dart';

/// Widget for displaying API information
class ApiInfoCard extends StatelessWidget {
  final ApiInfoEntity info;

  const ApiInfoCard({
    super.key,
    required this.info,
  });

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            '$label:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.green[50],
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info, color: Colors.green[700], size: 24),
                const SizedBox(width: 12),
                const Text(
                  'API Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (info.title.isNotEmpty) _buildInfoRow('Title', info.title),
            if (info.description.isNotEmpty) ...[
              const SizedBox(height: 8),
              _buildInfoRow('Description', info.description),
            ],
            if (info.version.isNotEmpty) ...[
              const SizedBox(height: 8),
              _buildInfoRow('Version', info.version),
            ],
          ],
        ),
      ),
    );
  }
}

