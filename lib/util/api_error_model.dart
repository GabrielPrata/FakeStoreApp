class ApiErrorException implements Exception {
  final int statusCode;
  final String errorDescription;
  
  ApiErrorException({
    required this.statusCode,
    required this.errorDescription,
  });
  
  @override
  String toString() {
    return "Erro $statusCode: $errorDescription";
  }
}