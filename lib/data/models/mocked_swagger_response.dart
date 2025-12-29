import '../../domain/entities/mocked_swagger_entity.dart';

class MockedSwaggerResponse {
  String? message;
  ApiInfo? info;
  PaginationInfo? pagination;
  List<EndpointsResponse>? endpoints;
  String? mockBaseUrl;
  Map<String, dynamic>? securitySchemes;
  List<dynamic>? servers;

  MockedSwaggerResponse({
    this.message,
    this.info,
    this.pagination,
    this.endpoints,
    this.mockBaseUrl,
    this.securitySchemes,
    this.servers,
  });

  MockedSwaggerResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    info = json['info'] != null ? ApiInfo.fromJson(json['info']) : null;
    pagination = json['pagination'] != null
        ? PaginationInfo.fromJson(json['pagination'])
        : null;
    if (json['endpoints'] != null) {
      endpoints = <EndpointsResponse>[];
      json['endpoints'].forEach((v) {
        endpoints!.add(EndpointsResponse.fromJson(v));
      });
    }
    mockBaseUrl = json['mockBaseUrl'];
    securitySchemes = json['securitySchemes'];
    servers = json['servers'];
  }

  MockedSwaggerEntity toEntity() => MockedSwaggerEntity(
        mockedBaseUrl: mockBaseUrl ?? '',
        mockedEndpoints: endpoints?.map((e) => e.toEntity()).toList() ?? [],
        info: info?.toEntity(),
        pagination: pagination?.toEntity(),
      );
}

class ApiInfo {
  String? title;
  String? description;
  String? version;

  ApiInfo({this.title, this.description, this.version});

  ApiInfo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    version = json['version'];
  }

  ApiInfoEntity toEntity() => ApiInfoEntity(
        title: title ?? '',
        description: description ?? '',
        version: version ?? '',
      );
}

class PaginationInfo {
  int? page;
  int? limit;
  int? total;
  int? totalPages;
  bool? hasNextPage;
  bool? hasPreviousPage;

  PaginationInfo({
    this.page,
    this.limit,
    this.total,
    this.totalPages,
    this.hasNextPage,
    this.hasPreviousPage,
  });

  PaginationInfo.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    totalPages = json['totalPages'];
    hasNextPage = json['hasNextPage'];
    hasPreviousPage = json['hasPreviousPage'];
  }

  PaginationEntity toEntity() => PaginationEntity(
        page: page ?? 0,
        limit: limit ?? 0,
        total: total ?? 0,
        totalPages: totalPages ?? 0,
        hasNextPage: hasNextPage ?? false,
        hasPreviousPage: hasPreviousPage ?? false,
      );
}

class EndpointsResponse {
  String? path;
  String? method;
  SummaryInfo? summary;
  String? description;
  String? operationId;
  List<String>? tags;
  ParametersObject? parameters;
  RequestBodyResponse? requestBody;
  Map<String, dynamic>? responses;
  List<dynamic>? security;

  EndpointsResponse({
    this.path,
    this.method,
    this.summary,
    this.description,
    this.operationId,
    this.tags,
    this.parameters,
    this.requestBody,
    this.responses,
    this.security,
  });

  EndpointsResponse.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    method = json['method'];
    summary =
        json['summary'] != null ? SummaryInfo.fromJson(json['summary']) : null;
    description = json['description'];
    operationId = json['operationId'];
    if (json['tags'] != null) {
      tags = <String>[];
      json['tags'].forEach((v) {
        tags!.add(v);
      });
    }
    parameters = json['parameters'] != null
        ? ParametersObject.fromJson(json['parameters'])
        : null;
    requestBody = json['requestBody'] != null
        ? RequestBodyResponse.fromJson(json['requestBody'])
        : null;
    responses = json['responses'];
    security = json['security'];
  }

  MockedEndpointsEntity toEntity() => MockedEndpointsEntity(
        path: path ?? '',
        method: method ?? '',
        summary: summary?.toEntity() ??
            SummaryEntity(
              hasParameters: false,
              hasRequestBody: false,
              parameterCount: ParameterCountEntity(
                path: 0,
                query: 0,
                header: 0,
                cookie: 0,
                total: 0,
              ),
              requiredParameters: [],
              requestBodyRequired: false,
              requestBodyContentTypes: [],
              responseStatusCodes: [],
            ),
        description: description ?? '',
        operationId: operationId ?? '',
        tags: tags ?? [],
        parameters: parameters?.toEntity() ??
            ParametersObjectEntity(
              path: [],
              query: [],
              header: [],
              cookie: [],
              all: [],
            ),
        requestBody: requestBody?.toEntity() ??
            RequestBodyEntity(
              required: false,
              description: '',
              contentTypes: {},
              example: null,
            ),
        responses: responses ?? {},
        security: security ?? [],
      );
}

class SummaryInfo {
  bool? hasParameters;
  bool? hasRequestBody;
  ParameterCount? parameterCount;
  List<RequiredParameterInfo>? requiredParameters;
  bool? requestBodyRequired;
  List<String>? requestBodyContentTypes;
  List<String>? responseStatusCodes;

  SummaryInfo({
    this.hasParameters,
    this.hasRequestBody,
    this.parameterCount,
    this.requiredParameters,
    this.requestBodyRequired,
    this.requestBodyContentTypes,
    this.responseStatusCodes,
  });

  SummaryInfo.fromJson(Map<String, dynamic> json) {
    hasParameters = json['hasParameters'];
    hasRequestBody = json['hasRequestBody'];
    parameterCount = json['parameterCount'] != null
        ? ParameterCount.fromJson(json['parameterCount'])
        : null;
    final requiredParamsJson = json['requiredParameters'];
    if (requiredParamsJson is List) {
      requiredParameters = <RequiredParameterInfo>[];
      for (final v in requiredParamsJson) {
        if (v is Map<String, dynamic>) {
          requiredParameters!.add(RequiredParameterInfo.fromJson(v));
        } else if (v is String) {
          // Backwards-compatible: some responses may return ["petId", ...]
          requiredParameters!.add(
            RequiredParameterInfo(name: v, inType: '', type: ''),
          );
        }
      }
    }
    requestBodyRequired = json['requestBodyRequired'];
    if (json['requestBodyContentTypes'] != null) {
      requestBodyContentTypes = <String>[];
      json['requestBodyContentTypes'].forEach((v) {
        requestBodyContentTypes!.add(v);
      });
    }
    if (json['responseStatusCodes'] != null) {
      responseStatusCodes = <String>[];
      json['responseStatusCodes'].forEach((v) {
        responseStatusCodes!.add(v);
      });
    }
  }

  SummaryEntity toEntity() => SummaryEntity(
        hasParameters: hasParameters ?? false,
        hasRequestBody: hasRequestBody ?? false,
        parameterCount: parameterCount?.toEntity() ??
            ParameterCountEntity(
              path: 0,
              query: 0,
              header: 0,
              cookie: 0,
              total: 0,
            ),
        requiredParameters: requiredParameters?.map((e) => e.toEntity()).toList() ?? [],
        requestBodyRequired: requestBodyRequired ?? false,
        requestBodyContentTypes: requestBodyContentTypes ?? [],
        responseStatusCodes: responseStatusCodes ?? [],
      );
}

class RequiredParameterInfo {
  String? name;
  String? inType;
  String? type;

  RequiredParameterInfo({this.name, this.inType, this.type});

  RequiredParameterInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    inType = json['in'];
    type = json['type'];
  }

  RequiredParameterEntity toEntity() => RequiredParameterEntity(
        name: name ?? '',
        inType: inType ?? '',
        type: type ?? '',
      );
}

class ParameterCount {
  int? path;
  int? query;
  int? header;
  int? cookie;
  int? total;

  ParameterCount({this.path, this.query, this.header, this.cookie, this.total});

  ParameterCount.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    query = json['query'];
    header = json['header'];
    cookie = json['cookie'];
    total = json['total'];
  }

  ParameterCountEntity toEntity() => ParameterCountEntity(
        path: path ?? 0,
        query: query ?? 0,
        header: header ?? 0,
        cookie: cookie ?? 0,
        total: total ?? 0,
      );
}

class ParametersObject {
  List<ParametersResponse>? path;
  List<ParametersResponse>? query;
  List<ParametersResponse>? header;
  List<ParametersResponse>? cookie;
  List<ParametersResponse>? all;

  ParametersObject({
    this.path,
    this.query,
    this.header,
    this.cookie,
    this.all,
  });

  ParametersObject.fromJson(Map<String, dynamic> json) {
    if (json['path'] != null) {
      path = <ParametersResponse>[];
      json['path'].forEach((v) {
        path!.add(ParametersResponse.fromJson(v));
      });
    }
    if (json['query'] != null) {
      query = <ParametersResponse>[];
      json['query'].forEach((v) {
        query!.add(ParametersResponse.fromJson(v));
      });
    }
    if (json['header'] != null) {
      header = <ParametersResponse>[];
      json['header'].forEach((v) {
        header!.add(ParametersResponse.fromJson(v));
      });
    }
    if (json['cookie'] != null) {
      cookie = <ParametersResponse>[];
      json['cookie'].forEach((v) {
        cookie!.add(ParametersResponse.fromJson(v));
      });
    }
    if (json['all'] != null) {
      all = <ParametersResponse>[];
      json['all'].forEach((v) {
        all!.add(ParametersResponse.fromJson(v));
      });
    }
  }

  ParametersObjectEntity toEntity() => ParametersObjectEntity(
        path: path?.map((e) => e.toEntity()).toList() ?? [],
        query: query?.map((e) => e.toEntity()).toList() ?? [],
        header: header?.map((e) => e.toEntity()).toList() ?? [],
        cookie: cookie?.map((e) => e.toEntity()).toList() ?? [],
        all: all?.map((e) => e.toEntity()).toList() ?? [],
      );
}

class ParametersResponse {
  String? name;
  String? inType;
  bool? required;
  String? description;
  bool? deprecated;
  SchemaResponse? schema;
  String? type;
  String? format;

  ParametersResponse({
    this.name,
    this.inType,
    this.required,
    this.description,
    this.deprecated,
    this.schema,
    this.type,
    this.format,
  });

  ParametersResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    inType = json['in'];
    required = json['required'];
    description = json['description'];
    deprecated = json['deprecated'];
    schema =
        json['schema'] != null ? SchemaResponse.fromJson(json['schema']) : null;
    type = json['type'];
    format = json['format'];
  }

  ParametersEntity toEntity() => ParametersEntity(
        name: name ?? '',
        inType: inType ?? '',
        required: required ?? false,
        description: description ?? '',
        deprecated: deprecated ?? false,
        type: type ?? '',
        format: format ?? '',
        schema: schema?.toEntity() ??
            SchemaEntity(
              type: '',
              format: '',
              properties: {},
              required: [],
              items: null,
              enumValues: [],
            ),
      );
}

class SchemaResponse {
  String? type;
  String? format;
  Map<String, dynamic>? properties;
  List<String>? required;
  dynamic items;
  List<dynamic>? enumValues;

  SchemaResponse({
    this.type,
    this.format,
    this.properties,
    this.required,
    this.items,
    this.enumValues,
  });

  SchemaResponse.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    format = json['format'];
    properties = json['properties'];
    if (json['required'] != null) {
      required = <String>[];
      json['required'].forEach((v) {
        required!.add(v);
      });
    }
    items = json['items'];
    enumValues = json['enum'];
  }

  SchemaEntity toEntity() => SchemaEntity(
        type: type ?? '',
        format: format ?? '',
        properties: properties ?? {},
        required: required ?? [],
        items: items,
        enumValues: enumValues ?? [],
      );
}

class RequestBodyResponse {
  bool? required;
  String? description;
  Map<String, ContentTypeInfo>? contentTypes;
  dynamic example;

  RequestBodyResponse({
    this.required,
    this.description,
    this.contentTypes,
    this.example,
  });

  RequestBodyResponse.fromJson(Map<String, dynamic> json) {
    required = json['required'];
    description = json['description'];
    if (json['contentTypes'] != null) {
      contentTypes = <String, ContentTypeInfo>{};
      json['contentTypes'].forEach((key, value) {
        if (value is Map<String, dynamic>) {
          contentTypes![key] = ContentTypeInfo.fromJson(value);
        }
      });
    }
    example = json['example'];
  }

  RequestBodyEntity toEntity() => RequestBodyEntity(
        required: required ?? false,
        description: description ?? '',
        contentTypes: contentTypes?.map((key, value) =>
                MapEntry(key, value.toEntity())) ??
            {},
        example: example,
      );
}

class ContentTypeInfo {
  SchemaResponse? schema;
  dynamic generatedExample;

  ContentTypeInfo({this.schema, this.generatedExample});

  ContentTypeInfo.fromJson(Map<String, dynamic> json) {
    schema =
        json['schema'] != null ? SchemaResponse.fromJson(json['schema']) : null;
    generatedExample = json['generatedExample'];
  }

  ContentTypeEntity toEntity() => ContentTypeEntity(
        schema: schema?.toEntity() ??
            SchemaEntity(
              type: '',
              format: '',
              properties: {},
              required: [],
              items: null,
              enumValues: [],
            ),
        generatedExample: generatedExample,
      );
}
