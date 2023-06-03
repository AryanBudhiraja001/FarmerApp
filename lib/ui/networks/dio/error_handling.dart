import 'package:dio/dio.dart';

import '../../common_widgets/widgets.dart';

class DioException implements Exception {

  static String? errorMessage;

  DioException.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        errorMessage = 'Request to the server was cancelled.';
        break;
      case DioErrorType.connectionTimeout:
        errorMessage = 'Connection timed out.';
        break;
      case DioErrorType.receiveTimeout:
        errorMessage = 'Receiving timeout occurred.';
        break;
      case DioErrorType.sendTimeout:
        errorMessage = 'Request send timeout.';
        break;
      case DioErrorType.badResponse:
        errorMessage = handleStatusCode(dioError.response?.statusCode);
        break;
      // case DioErrorType.unknown:
      //   if (dioError.message?.contains('SocketException')) {
      //     errorMessage = 'No Internet.';
      //     break;
      //   }
        errorMessage = 'Unexpected error occurred.';
        break;
      default:
        errorMessage = 'Something went wrong';
        break;
    }
    // toast(errorMessage);
  }

 static String handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request.';
      case 401:
        return 'Authentication failed.';
      case 403:
        return 'The authenticated user is not allowed to access the specified API endpoint.';
      case 404:
        return '404 Not Found';
      case 405:
        return 'Method not allowed. Please check the Allow header for the allowed HTTP methods.';
      case 413:
        return 'The request was larger than the server is able to handle, either due to physical constraints or to settings';
      case 415:
        return 'Unsupported media type. The requested content type or version number is invalid.';
      case 422:
        return 'Data validation failed.';
      case 429:
        return 'Too many requests.';
      case 500:
        return 'Internal server error.';
      default:
        return 'Oops something went wrong!';
    }
  }

  @override
  String toString() => errorMessage!;
}