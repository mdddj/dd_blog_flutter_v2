
class BizError implements Exception {
  final String msg;
  BizError(this.msg):super();

  @override
  String toString() {
    return msg;
  }
}