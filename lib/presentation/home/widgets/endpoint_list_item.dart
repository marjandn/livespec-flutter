import 'package:flutter/material.dart';
import '../../../domain/entities/mocked_swagger_entity.dart';
import '../../shared/widgets/method_badge.dart';
import '../../shared/widgets/tag_chip.dart';
import '../../shared/widgets/badge_chip.dart';

/// Widget for displaying a single endpoint in the list
class EndpointListItem extends StatelessWidget {
  final MockedEndpointsEntity endpoint;
  final bool isTesting;
  final VoidCallback onTap;
  final VoidCallback onTest;

  const EndpointListItem({
    super.key,
    required this.endpoint,
    required this.isTesting,
    required this.onTap,
    required this.onTest,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        onTap: onTap,
        leading: MethodBadge(
          method: endpoint.method,
          showIcon: false,
          fontSize: 11,
        ),
        title: SelectableText(
          endpoint.path,
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (endpoint.tags.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: endpoint.tags
                      .map((tag) => TagChip(tag: tag))
                      .toList(),
                ),
              ),
            if (endpoint.summary.hasParameters ||
                endpoint.summary.hasRequestBody)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: [
                    if (endpoint.summary.hasParameters)
                      BadgeChip(
                        label:
                            '${endpoint.summary.parameterCount.total} Param${endpoint.summary.parameterCount.total != 1 ? 's' : ''}',
                        backgroundColor: Colors.deepPurple[50]!,
                        borderColor: Colors.deepPurple[200]!,
                        textColor: Colors.deepPurple[700]!,
                      ),
                    if (endpoint.summary.hasRequestBody)
                      BadgeChip(
                        label: 'Req Body',
                        backgroundColor: Colors.teal[50]!,
                        borderColor: Colors.teal[200]!,
                        textColor: Colors.teal[700]!,
                      ),
                  ],
                ),
              ),
          ],
        ),
        trailing: SizedBox(
          width: 100,
          child: ElevatedButton.icon(
            onPressed: isTesting ? null : onTest,
            icon: isTesting
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : const Icon(Icons.play_arrow, size: 18),
            label: Text(isTesting ? 'Testing...' : 'Test'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

