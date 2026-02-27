/// Classe genérica para representar resultados de operações
/// Segue o princípio de não lançar exceções, mas retornar estados
sealed class Result<T> {
  const Result();

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T? get data => switch (this) {
        Success<T>(:final data) => data,
        Failure<T>() => null,
      };

  String? get errorMessage => switch (this) {
        Success<T>() => null,
        Failure<T>(:final message) => message,
      };

  R when<R>({
    required R Function(T data) success,
    required R Function(String message) failure,
  }) {
    return switch (this) {
      Success<T>(:final data) => success(data),
      Failure<T>(:final message) => failure(message),
    };
  }
}

final class Success<T> extends Result<T> {
  @override
  final T data;
  const Success(this.data);
}

final class Failure<T> extends Result<T> {
  final String message;
  const Failure(this.message);
}
