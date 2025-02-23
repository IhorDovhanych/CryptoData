import 'package:dio/dio.dart';

import 'error_codes.dart';

class BaseException implements Exception {
  BaseException({
    this.error,
    this.message,
    this.stack,
    this.code,
  });

  factory BaseException.fromException(final Object e) => BaseException(
        error: e,
        message: e.toString(),
        code: ecNonDio,
      );

  final Object? error;
  final String? message;
  final StackTrace? stack;

  final String? code;

  @override
  String toString() => message ?? error?.toString() ?? '';
}

BaseException parseException({
  required final Object exception,
  required final StackTrace stackTrace,
  required final String defaultMessage,
  final String? code,
}) {
  if (exception is DioError) {
    final String errorMessage = (exception.response != null && exception.response!.data is Map)
        ? 'Something went wrong!'
        : (exception.message);

    return BaseException(
      error: exception,
      message: errorMessage,
      stack: stackTrace,
      code: code ?? ecNonDio,
    );
  }

  return BaseException(
    error: exception,
    message: defaultMessage,
    stack: stackTrace,
    code: code,
  );
}
