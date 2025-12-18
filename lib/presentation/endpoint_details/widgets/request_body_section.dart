import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../domain/entities/mocked_swagger_entity.dart';
import '../../shared/widgets/section_card.dart';
import '../../shared/widgets/info_chip.dart';
import '../../shared/utils/json_formatter.dart';

/// Widget for displaying request body section
class RequestBodySection extends StatelessWidget {
  final RequestBodyEntity requestBody;
  final Function(String, String) onCopy;

  const RequestBodySection({
    super.key,
    required this.requestBody,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Request Body',
      icon: Icons.code,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (requestBody.required)
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.red[100],
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'REQUIRED',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
          if (requestBody.description.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                requestBody.description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          ...requestBody.contentTypes.entries.map((entry) {
            final contentType = entry.key;
            final contentTypeInfo = entry.value;
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
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
                      contentType,
                      style: TextStyle(
                        color: Colors.teal[700],
                        fontSize: 14,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (contentTypeInfo.schema.type.isNotEmpty ||
                      contentTypeInfo.schema.format.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      children: [
                        if (contentTypeInfo.schema.type.isNotEmpty)
                          InfoChip(
                            label: 'Schema Type',
                            value: contentTypeInfo.schema.type,
                          ),
                        if (contentTypeInfo.schema.format.isNotEmpty)
                          InfoChip(
                            label: 'Format',
                            value: contentTypeInfo.schema.format,
                          ),
                      ],
                    ),
                  ],
                  if (contentTypeInfo.generatedExample != null) ...[
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Example:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.copy, size: 18),
                          onPressed: () {
                            final exampleJson =
                                jsonEncode(contentTypeInfo.generatedExample);
                            onCopy(exampleJson, 'Example');
                          },
                          tooltip: 'Copy example',
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: SelectableText(
                        JsonFormatter.formatJson(contentTypeInfo.generatedExample),
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          }).toList(),
          if (requestBody.example != null) ...[
            const SizedBox(height: 16),
            const Text(
              'General Example:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: SelectableText(
                JsonFormatter.formatJson(requestBody.example),
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

