import 'package:flutter/material.dart';
import '../../../domain/entities/mocked_swagger_entity.dart';
import '../../shared/widgets/method_badge.dart';
import '../../shared/widgets/copyable_text_field.dart';
import '../../shared/utils/http_method_utils.dart';

/// Widget for displaying endpoint header with method, URL, and test button
class EndpointHeaderCard extends StatelessWidget {
  final MockedEndpointsEntity endpoint;
  final String baseUrl;
  final bool isTesting;
  final VoidCallback onTest;
  final VoidCallback onCopyUrl;

  const EndpointHeaderCard({
    super.key,
    required this.endpoint,
    required this.baseUrl,
    required this.isTesting,
    required this.onTest,
    required this.onCopyUrl,
  });

  @override
  Widget build(BuildContext context) {
    final methodColor = HttpMethodUtils.getMethodColor(endpoint.method);
    final fullUrl = '$baseUrl${endpoint.path}';

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                MethodBadge(
                  method: endpoint.method,
                  showIcon: true,
                  fontSize: 14,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: onCopyUrl,
                  tooltip: 'Copy URL',
                ),
              ],
            ),
            const SizedBox(height: 16),
            CopyableTextField(
              text: fullUrl,
              label: 'URL',
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: isTesting ? null : onTest,
                icon: isTesting
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Icon(Icons.play_arrow),
                label: Text(isTesting ? 'Testing...' : 'Test Endpoint'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: methodColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

