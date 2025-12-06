import 'package:mock_api_generator/domain/entities/mocked_swagger_entity.dart';

class MockedSwaggerResponse {
  String? mockedBaseUrl;
  List<String>? mockedEndpoints;

  MockedSwaggerResponse({this.mockedBaseUrl, this.mockedEndpoints});

  MockedSwaggerResponse.fromJson(Map<String, dynamic> json)
    : mockedBaseUrl = json['mockedBaseUrl'],
      mockedEndpoints = json['mockedEndpoints'];

  MockedSwaggerEntity toEntity() =>
      MockedSwaggerEntity(mockedBaseUrl: mockedBaseUrl ?? '', mockedEndpoints: mockedEndpoints ?? []);
}
