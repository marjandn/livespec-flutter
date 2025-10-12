abstract class UseCase<T, Parameter> {
  Future<T> call(Parameter parameter);
}
