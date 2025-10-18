sealed class Exception {
  final String message;

  Exception({required this.message});
}

class JsonParsingException extends Exception {
  JsonParsingException({required super.message});
}

class RequestExceptions extends Exception {
  RequestExceptions({required super.message});
}
