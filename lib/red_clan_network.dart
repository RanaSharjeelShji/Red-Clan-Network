import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  /// Sends an HTTP request and returns an [ApiResponse] containing the result.
  ///
  /// The [url] parameter specifies the endpoint to which the request will be sent.
  /// The [method] parameter determines the HTTP method to be used (GET, POST, PUT, PATCH, DELETE).
  /// The [modelFromJson] function is optional and is used to convert the JSON response into a model object.
  /// The [successStatusCodes] parameter is a list of HTTP status codes that are considered successful.
  /// Optional [headers] can be provided to include additional information in the request.
  /// The [body] parameter contains the data to be sent in the request (e.g., in POST or PUT requests).
  /// Optional [queryParameters] can be provided to append to the URL.
  /// The [files] parameter is reserved for future use, for sending files in requests.

  Future<ApiResponse<T>> request<T>({
    required String url,
    required String method,
    T Function(dynamic)? modelFromJson, // Optional function to parse JSON into a model
    required List<int> successStatusCodes,
    Map<String, String>? headers,
    dynamic body,
    Map<String, String>? queryParameters,
    dynamic files,
  }) async {
    Uri uri = Uri.parse(url);

    // If query parameters are provided, append them to the URL
    if (queryParameters != null) {
      uri = uri.replace(queryParameters: queryParameters);
    }

    http.Response response;
    try {
      // Determine which HTTP method to use and make the request
      switch (method.toUpperCase()) {
        case 'POST':
          response = await http.post(uri, headers: headers, body: jsonEncode(body));
          break;
        case 'PUT':
          response = await http.put(uri, headers: headers, body: jsonEncode(body));
          break;
        case 'PATCH':
          response = await http.patch(uri, headers: headers, body: jsonEncode(body));
          break;
        case 'DELETE':
          response = await http.delete(uri, headers: headers, body: jsonEncode(body));
          break;
        case 'GET':
        default:
          response = await http.get(uri, headers: headers);
          break;
      }
    } catch (e) {
      // Handle any exceptions that occur during the HTTP request
      return ApiResponse.failure(response: e, code: 500);
    }



    // Check if the status code is in the list of success status codes
    if (successStatusCodes.contains(response.statusCode)) {
      try {
        // If the response body is empty, return a success with an empty response
        if (response.body.isEmpty || modelFromJson == null) {
          return ApiResponse.success(response: null, code: response.statusCode);
        }

        final decodedResponse = jsonDecode(response.body);

        // Handle cases where the response is a list
        if (decodedResponse is List) {
          final List<T> dataList = decodedResponse.map((e) => modelFromJson(e)).toList();
          return ApiResponse.success(response: dataList, code: response.statusCode);
        }
        // Handle cases where the response is a single object
        else if (decodedResponse is Map<String, dynamic>) {
          final T data = modelFromJson(decodedResponse);
          return ApiResponse.success(response: [data], code: response.statusCode);
        }
      } catch (e) {
        // Handle errors that occur during JSON decoding
        return ApiResponse.failure(response: 'Update your model according to response: $e', code: response.statusCode);
      }
    } else {
      // Return a failure response if the status code is not in the success list
      return ApiResponse.failure(response: response.body, code: response.statusCode);
    }

    // Return a failure response if an unexpected status code is received
    return ApiResponse.failure(response: 'Unexpected status code', code: response.statusCode);
  }
}

class ApiResponse<T> {
  final int code; // The HTTP status code returned by the server
  final dynamic response; // The actual response from the server (parsed JSON or null)
  final bool isSuccess; // Whether the request was successful or not

  // Constructor for successful responses
  ApiResponse.success({required this.response, required this.code})
      : isSuccess = true;

  // Constructor for failure responses
  ApiResponse.failure({required this.response, required this.code})
      : isSuccess = false;
}
