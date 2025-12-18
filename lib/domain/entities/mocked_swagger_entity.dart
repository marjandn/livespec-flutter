class MockedSwaggerEntity {
  final String mockedBaseUrl;
  final List<MockedEndpointsEntity> mockedEndpoints;
  final ApiInfoEntity? info;
  final PaginationEntity? pagination;

  MockedSwaggerEntity({
    required this.mockedBaseUrl,
    required this.mockedEndpoints,
    this.info,
    this.pagination,
  });
}

class ApiInfoEntity {
  final String title;
  final String description;
  final String version;

  ApiInfoEntity({
    required this.title,
    required this.description,
    required this.version,
  });
}

class PaginationEntity {
  final int page;
  final int limit;
  final int total;
  final int totalPages;
  final bool hasNextPage;
  final bool hasPreviousPage;

  PaginationEntity({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });
}

class MockedEndpointsEntity {
  final String path;
  final String method;
  final SummaryEntity summary;
  final String description;
  final String operationId;
  final List<String> tags;
  final ParametersObjectEntity parameters;
  final RequestBodyEntity requestBody;
  final Map<String, dynamic> responses;
  final List<dynamic> security;

  MockedEndpointsEntity({
    required this.path,
    required this.method,
    required this.summary,
    required this.description,
    required this.operationId,
    required this.tags,
    required this.parameters,
    required this.requestBody,
    required this.responses,
    required this.security,
  });
}

class SummaryEntity {
  final bool hasParameters;
  final bool hasRequestBody;
  final ParameterCountEntity parameterCount;
  final List<String> requiredParameters;
  final bool requestBodyRequired;
  final List<String> requestBodyContentTypes;
  final List<String> responseStatusCodes;

  SummaryEntity({
    required this.hasParameters,
    required this.hasRequestBody,
    required this.parameterCount,
    required this.requiredParameters,
    required this.requestBodyRequired,
    required this.requestBodyContentTypes,
    required this.responseStatusCodes,
  });
}

class ParameterCountEntity {
  final int path;
  final int query;
  final int header;
  final int cookie;
  final int total;

  ParameterCountEntity({
    required this.path,
    required this.query,
    required this.header,
    required this.cookie,
    required this.total,
  });
}

class ParametersObjectEntity {
  final List<ParametersEntity> path;
  final List<ParametersEntity> query;
  final List<ParametersEntity> header;
  final List<ParametersEntity> cookie;
  final List<ParametersEntity> all;

  ParametersObjectEntity({
    required this.path,
    required this.query,
    required this.header,
    required this.cookie,
    required this.all,
  });
}

class ParametersEntity {
  final String name;
  final String inType;
  final bool required;
  final String description;
  final bool deprecated;
  final String type;
  final String format;
  final SchemaEntity schema;

  ParametersEntity({
    required this.name,
    required this.inType,
    required this.required,
    required this.description,
    required this.deprecated,
    required this.type,
    required this.format,
    required this.schema,
  });
}

class RequestBodyEntity {
  final bool required;
  final String description;
  final Map<String, ContentTypeEntity> contentTypes;
  final Map<String, dynamic>? example;

  RequestBodyEntity({
    required this.required,
    required this.description,
    required this.contentTypes,
    this.example,
  });
}

class ContentTypeEntity {
  final SchemaEntity schema;
  final Map<String, dynamic>? generatedExample;

  ContentTypeEntity({
    required this.schema,
    this.generatedExample,
  });
}

class SchemaEntity {
  final String type;
  final String format;
  final Map<String, dynamic> properties;
  final List<String> required;
  final dynamic items;
  final List<dynamic> enumValues;

  SchemaEntity({
    required this.type,
    required this.format,
    required this.properties,
    required this.required,
    required this.items,
    required this.enumValues,
  });
}
