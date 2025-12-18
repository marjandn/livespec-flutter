import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mock_api_generator/domain/usecases/generate_swagger_mock_usecase.dart';

import '../../core/result/result.dart';
import '../../domain/entities/mocked_swagger_entity.dart';
import '../../injectable_config.dart';
import '../endpoint_details/endpoint_detail_page.dart';
import '../shared/services/endpoint_test_service.dart';
import 'widgets/swagger_input_card.dart';
import 'widgets/error_message_card.dart';
import 'widgets/base_url_card.dart';
import 'widgets/api_info_card.dart';
 
import 'widgets/endpoint_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final GenerateSwaggerMockUsecase _getSwaggerJsonUseCase =
      getIt<GenerateSwaggerMockUsecase>();
  final TextEditingController _textController = TextEditingController();
  final EndpointTestService _endpointTestService = const EndpointTestService();
  bool _isLoading = false;
  MockedSwaggerEntity? _mockedData;
  String? _errorMessage;
  Map<String, bool> _testingEndpoints = {};

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _generateMock() async {
    if (_textController.text.trim().isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a Swagger link';
        _mockedData = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _mockedData = null;
    });

    final result = await _getSwaggerJsonUseCase.call(
      _textController.text.trim(),
    );

    setState(() {
      _isLoading = false;
      if (result is Success<MockedSwaggerEntity>) {
        _mockedData = result.data;
        _errorMessage = null;
      } else if (result is Failure<MockedSwaggerEntity>) {
        _errorMessage = result.message ?? 'An error occurred';
        _mockedData = null;
      } else {
        _errorMessage = 'Unknown error occurred';
        _mockedData = null;
      }
    });
  }

  Future<void> _testEndpoint(String endpointPath) async {
    if (_mockedData == null) return;

    // Find the endpoint from the list
    final endpoint = _mockedData!.mockedEndpoints.firstWhere(
      (e) => e.path == endpointPath,
      orElse: () => _mockedData!.mockedEndpoints.first,
    );

    setState(() {
      _testingEndpoints[endpointPath] = true;
    });

    try {
      final result = await _endpointTestService.testEndpoint(
        baseUrl: _mockedData!.mockedBaseUrl,
        endpoint: endpoint,
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
                const SizedBox(height: 4),
                Text(
                  'URL: ${uri.toString()}',
                  style: const TextStyle(fontSize: 11),
                ),
                const SizedBox(height: 8),
                Container(
                  constraints: const BoxConstraints(maxHeight: 100),
                  child: SingleChildScrollView(
                    child: Text(
                      response.body.length > 200
                          ? '${response.body.substring(0, 200)}...'
                          : response.body,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            duration: const Duration(seconds: 6),
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
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _testingEndpoints[endpointPath] = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mock API Generator',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input Section
            SwaggerInputCard(
              controller: _textController,
              onGenerate: _generateMock,
              isLoading: _isLoading,
            ),

            const SizedBox(height: 24),

            // Error Message
            if (_errorMessage != null) ...[
              ErrorMessageCard(message: _errorMessage!),
              const SizedBox(height: 24),
            ],

            // Mocked Base URL
            if (_mockedData != null) ...[
              BaseUrlCard(baseUrl: _mockedData!.mockedBaseUrl),

              const SizedBox(height: 24),

              // API Info
              if (_mockedData!.info != null) ...[
                ApiInfoCard(info: _mockedData!.info!),
                const SizedBox(height: 24),
              ],
 

              // Endpoints Table
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.list_alt,
                            color: Colors.green[700],
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Mocked Endpoints (${_mockedData!.mockedEndpoints.length})',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    if (_mockedData!.mockedEndpoints.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Center(
                          child: Text(
                            'No endpoints found',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                      )
                    else
                      ..._mockedData!.mockedEndpoints.map((endpoint) {
                        return EndpointListItem(
                          endpoint: endpoint,
                          isTesting: _testingEndpoints[endpoint.path] ?? false,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EndpointDetailPage(
                                  endpoint: endpoint,
                                  baseUrl: _mockedData!.mockedBaseUrl,
                                ),
                              ),
                            );
                          },
                          onTest: () => _testEndpoint(endpoint.path),
                        );
                      }),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
