import 'package:flutter_test/flutter_test.dart';
import 'package:mock_api_generator/domain/entities/swagger_entity.dart';
import 'package:mock_api_generator/domain/repositories/swagger_repository.dart';
import 'package:mock_api_generator/domain/usecases/get_swagger_json_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_swagger_json_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SwaggerRepository>()])
void main() {
  late MockSwaggerRepository mockSwaggerRepository;
  late GetSwaggerJsonUseCase swaggerJsonUseCase;

  setUp(() {
    mockSwaggerRepository = MockSwaggerRepository();
    swaggerJsonUseCase = GetSwaggerJsonUseCase(mockSwaggerRepository);
  });

  test('Should reutrn Swagger entity when call getSwaggerJsonUseCase with a valid link', () async {
    const String link = 'http://swagger/v7/swagger.json';
    final swaggerEntity = SwaggerEntity(openapi: "3.0.1", title: "apy API");
    when(mockSwaggerRepository.getSwaggerLinkJsonData(link)).thenAnswer((_) async => swaggerEntity);

    final result = await swaggerJsonUseCase(link);

    expect(result, swaggerEntity);
  });
}
