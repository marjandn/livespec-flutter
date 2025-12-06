import 'package:mock_api_generator/domain/entities/mocked_swagger_entity.dart';

class MockedSwaggerResponse {
  String? mockedBaseUrl;
  List<String>? mockedEndpoints;

  MockedSwaggerResponse.fromJson(Map<String, dynamic> json)
    : mockedBaseUrl = json[''],
      mockedEndpoints = json[''];

  MockedSwaggerEntity toEntity() =>
      MockedSwaggerEntity(mockedBaseUrl: mockedBaseUrl ?? '', mockedEndpoints: mockedEndpoints ?? []);
}
