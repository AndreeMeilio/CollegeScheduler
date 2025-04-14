
class ResponseGeneral<T> {
  String code;
  String message;
  T data;

  ResponseGeneral({
    required this.code,
    required this.message,
    required this.data
  });
}