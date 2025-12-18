import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../domain/entities/mocked_swagger_entity.dart';
import '../shared/services/endpoint_test_service.dart';
import '../shared/widgets/section_card.dart';
import '../shared/widgets/tag_chip.dart';
import 'widgets/endpoint_header_card.dart';
import 'widgets/summary_section.dart';
import 'widgets/parameters_section.dart';
import 'widgets/request_body_section.dart';

class EndpointDetailPage extends StatefulWidget {
  final MockedEndpointsEntity endpoint;
  final String baseUrl;

  const EndpointDetailPage({
    super.key,
    required this.endpoint,
    required this.baseUrl,
  });

  @override
  State<EndpointDetailPage> createState() => _EndpointDetailPageState();
}

class _EndpointDetailPageState extends State<EndpointDetailPage> {
  bool _isTesting = false;
  final EndpointTestService _endpointTestService = const EndpointTestService();

  Future<void> _testEndpoint() async {
    setState(() {
      _isTesting = true;
    });

    try {
      final result = await _endpointTestService.testEndpoint(
        baseUrl: widget.baseUrl,
        endpoint: widget.endpoint,
      );
      final uri = result.uri;
      final method = result.method;
      final response = result.response;

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Status: ${response.statusCode}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      method,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                if (uri.queryParameters.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    'URL: ${uri.toString()}',
                    style: const TextStyle(fontSize: 11),
                  ),
                ],
                const SizedBox(height: 8),
                Container(
                  constraints: const BoxConstraints(maxHeight: 150),
                  child: SingleChildScrollView(
                    child: SelectableText(
                      response.body.isEmpty
                          ? '(Empty response)'
                          : response.body.length > 500
                              ? '${response.body.substring(0, 500)}...'
                              : response.body,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            duration: const Duration(seconds: 8),
            backgroundColor: response.statusCode >= 200 &&
                    response.statusCode < 300
                ? Colors.green
                : response.statusCode >= 400
                    ? Colors.red
                    : Colors.orange,
            action: SnackBarAction(
              label: 'Copy',
              textColor: Colors.white,
              onPressed: () {
                Clipboard.setData(ClipboardData(text: response.body));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Response copied to clipboard'),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.green,
                  ),
                );
              },
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Error occurred:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  e.toString(),
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isTesting = false;
        });
      }
    }
  }

  void _copyToClipboard(String text, String label) {
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
    final fullUrl = '${widget.baseUrl}${widget.endpoint.path}';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Endpoint Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Method and Path Header
            EndpointHeaderCard(
              endpoint: widget.endpoint,
              baseUrl: widget.baseUrl,
              isTesting: _isTesting,
              onTest: _testEndpoint,
              onCopyUrl: () => _copyToClipboard(fullUrl, 'URL'),
            ),

            const SizedBox(height: 20),

            // Tags
            if (widget.endpoint.tags.isNotEmpty) ...[
              SectionCard(
                title: 'Tags',
                icon: Icons.label,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: widget.endpoint.tags
                      .map((tag) => TagChip(tag: tag))
                      .toList(),
                ),
              ),
              const SizedBox(height: 20),
            ],

            // Summary Information
            SummarySection(summary: widget.endpoint.summary),

            const SizedBox(height: 20),

            // Description
            if (widget.endpoint.description.isNotEmpty) ...[
              SectionCard(
                title: 'Description',
                icon: Icons.description,
                child: Text(
                  widget.endpoint.description,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],

            // Parameters by Category
            if (widget.endpoint.summary.hasParameters) ...[
              ParametersSection(
                parameters: widget.endpoint.parameters,
                totalCount: widget.endpoint.summary.parameterCount.total,
              ),
              const SizedBox(height: 20),
            ],

            // Request Body
            if (widget.endpoint.summary.hasRequestBody) ...[
              RequestBodySection(
                requestBody: widget.endpoint.requestBody,
                onCopy: _copyToClipboard,
              ),
              const SizedBox(height: 20),
            ],

            // Security
            if (widget.endpoint.security.isNotEmpty) ...[
              SectionCard(
                title: 'Security',
                icon: Icons.security,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.endpoint.security.map((sec) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.amber[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.amber[200]!),
                      ),
                      child: Text(
                        sec.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'monospace',
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
