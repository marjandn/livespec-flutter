import 'package:flutter/material.dart';
import 'package:mock_api_generator/domain/usecases/generate_swagger_mock_usecase.dart';

import '../../injectable_config.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  late final GenerateSwaggerMockUsecase _getSwaggerJsonUseCase = getIt<GenerateSwaggerMockUsecase>();
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: .center,
        children: [
          TextField(
            decoration: InputDecoration(hintText: 'Enter a link'),
            controller: _textController,
          ),
          ElevatedButton(
            onPressed: () {
              _getSwaggerJsonUseCase.call(_textController.text);
            },
            child: Text('Generate'),
          ),
        ],
      ),
    );
  }
}
