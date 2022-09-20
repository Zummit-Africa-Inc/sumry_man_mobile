class Result<T> {
  final T? data;
  final String? message;

  Result._({this.data, this.message});

  static Result<T> success<T>(T data) => Result._(data: data);
  static Result<T> failure<T>(String message) => Result._(message: message);

  bool get isSuccess => data != null;
}
