import 'package:mock_api_generator/domain/entities/swagger_entity.dart';

class SwaggerJsonResponse {
  String? openapi;
  String? title;

  SwaggerJsonResponse({this.openapi, this.title});

  SwaggerJsonResponse.fromJson(Map<String, dynamic> json) : openapi = json['openapi'], title = json['title'];

  SwaggerEntity toEntity() => SwaggerEntity(openapi: openapi ?? '', title: title ?? '');
}
