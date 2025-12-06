import 'package:flutter/material.dart';

import '../../domain/usecases/get_swagger_json_usecase.dart';
import '../../injectable_config.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  late final GetSwaggerJsonUseCase _getSwaggerJsonUseCase = getIt<GetSwaggerJsonUseCase>();
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
