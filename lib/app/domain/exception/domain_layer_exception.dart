class DomainLayerException implements Exception {
  final String cause;

  DomainLayerException({this.cause});

  @override
  String toString() {
    return cause;
  }
}
