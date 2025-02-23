import 'package:logger/logger.dart';

final _logger = Logger(printer: PrettyPrinter(methodCount: 0));
final _errorLogger = Logger(printer: PrettyPrinter(methodCount: 1));

void printKeyValue(final String key, final dynamic value) =>
    _logger.i('$key: $value');

void printMessage(final String message) => _logger.i(message);

void printError(final String message, [final dynamic e, final StackTrace? st]) =>
    _errorLogger.e(message, error: e, stackTrace: st);