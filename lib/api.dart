import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://api.example.com'; // Replace with your base URL
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
  };

  /// GET request
  static Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    final mergedHeaders = _mergeHeaders(headers);
    try {
      final response = await http.get(Uri.parse('$baseUrl$endpoint'), headers: mergedHeaders);
      return _handleResponse(response);
    } catch (e) {
      _logError(endpoint, 'GET', e);
      rethrow;
    }
  }

  /// POST request
  static Future<dynamic> post(String endpoint, Map<String, dynamic> body,
      {Map<String, String>? headers}) async {
    final mergedHeaders = _mergeHeaders(headers);
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: mergedHeaders,
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      _logError(endpoint, 'POST', e);
      rethrow;
    }
  }

  /// PUT request
  static Future<dynamic> put(String endpoint, Map<String, dynamic> body,
      {Map<String, String>? headers}) async {
    final mergedHeaders = _mergeHeaders(headers);
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: mergedHeaders,
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      _logError(endpoint, 'PUT', e);
      rethrow;
    }
  }

  /// DELETE request
  static Future<dynamic> delete(String endpoint, {Map<String, String>? headers}) async {
    final mergedHeaders = _mergeHeaders(headers);
    try {
      final response = await http.delete(Uri.parse('$baseUrl$endpoint'), headers: mergedHeaders);
      return _handleResponse(response);
    } catch (e) {
      _logError(endpoint, 'DELETE', e);
      rethrow;
    }
  }

  /// Merge headers with default headers
  static Map<String, String> _mergeHeaders(Map<String, String>? headers) {
    return {...defaultHeaders, if (headers != null) ...headers};
  }

  /// Handle HTTP responses
  static dynamic _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    final responseBody = response.body;

    // Log response for debugging
    print('Response [${response.request?.method}] ${response.request?.url}: '
        'Status: $statusCode, Body: $responseBody');

    // Handle success responses
    if (statusCode >= 200 && statusCode < 300) {
      return responseBody.isNotEmpty ? jsonDecode(responseBody) : null;
    }

    // Handle error responses
    final errorBody = responseBody.isNotEmpty ? jsonDecode(responseBody) : null;
    switch (statusCode) {
      case 400:
        throw BadRequestException(errorBody);
      case 401:
        throw UnauthorizedException(errorBody);
      case 403:
        throw ForbiddenException(errorBody);
      case 404:
        throw NotFoundException(errorBody);
      case 500:
        throw InternalServerErrorException(errorBody);
      default:
        throw ApiException('Unexpected error: $statusCode', statusCode, errorBody);
    }
  }

  /// Log errors for debugging
  static void _logError(String endpoint, String method, dynamic error) {
    print('Error [$method] $baseUrl$endpoint: $error');
  }
}


/*******************************************************
* Exceptions
 *******************************************************/

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiException(this.message, [this.statusCode, this.data]);

  @override
  String toString() {
    return 'ApiException: $message (Status code: $statusCode, Data: $data)';
  }
}

class BadRequestException extends ApiException {
  BadRequestException(dynamic data) : super('Bad Request', 400, data);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(dynamic data) : super('Unauthorized', 401, data);
}

class ForbiddenException extends ApiException {
  ForbiddenException(dynamic data) : super('Forbidden', 403, data);
}

class NotFoundException extends ApiException {
  NotFoundException(dynamic data) : super('Not Found', 404, data);
}

class InternalServerErrorException extends ApiException {
  InternalServerErrorException(dynamic data) : super('Internal Server Error', 500, data);
}

/*******************************************************
 * Usage example
 *******************************************************/

void fetchData() async {
  try {
    final response = await ApiService.get('/users');
    print('Data fetched: $response');
  } catch (e) {
    print('Error: $e');
  }
}

