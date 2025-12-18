import 'package:flutter/material.dart';
import '../../../domain/entities/mocked_swagger_entity.dart';
import '../../shared/widgets/section_card.dart';
import '../../shared/widgets/status_code_chip.dart';

/// Widget for displaying summary information
class SummarySection extends StatelessWidget {
  final SummaryEntity summary;

  const SummarySection({
    super.key,
    required this.summary,
  });

  Widget _buildSummaryRow(String label, String value, bool isPositive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: isPositive ? Colors.green[50] : Colors.grey[200],
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: isPositive ? Colors.green[300]! : Colors.grey[400]!,
            ),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isPositive ? Colors.green[700] : Colors.grey[700],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCountChip(String label, int count, {bool isTotal = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isTotal ? Colors.blue[50] : Colors.grey[50],
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isTotal ? Colors.blue[300]! : Colors.grey[300]!,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isTotal ? Colors.blue[700] : Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isTotal ? Colors.blue[900] : Colors.grey[900],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Summary',
      icon: Icons.info_outline,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryRow(
            'Has Parameters',
            summary.hasParameters ? 'Yes' : 'No',
            summary.hasParameters,
          ),
          const SizedBox(height: 8),
          _buildSummaryRow(
            'Has Request Body',
            summary.hasRequestBody ? 'Yes' : 'No',
            summary.hasRequestBody,
          ),
          if (summary.hasParameters) ...[
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            const Text(
              'Parameter Count:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                _buildCountChip('Path', summary.parameterCount.path),
                _buildCountChip('Query', summary.parameterCount.query),
                _buildCountChip('Header', summary.parameterCount.header),
                _buildCountChip('Cookie', summary.parameterCount.cookie),
                _buildCountChip('Total', summary.parameterCount.total, isTotal: true),
              ],
            ),
          ],
          if (summary.requestBodyContentTypes.isNotEmpty) ...[
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            const Text(
              'Request Body Content Types:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: summary.requestBodyContentTypes.map((type) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.teal[50],
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.teal[200]!),
                  ),
                  child: Text(
                    type,
                    style: TextStyle(
                      color: Colors.teal[700],
                      fontSize: 12,
                      fontFamily: 'monospace',
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
          if (summary.responseStatusCodes.isNotEmpty) ...[
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            const Text(
              'Response Status Codes:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: summary.responseStatusCodes
                  .map((code) => StatusCodeChip(code: code))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}

