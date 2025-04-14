
class StateGeneral<T, V> {
  String? code;
  String? message;
  T state;
  V? data;

  StateGeneral({
    this.code,
    this.message,
    this.data,
    required this.state
  });
}