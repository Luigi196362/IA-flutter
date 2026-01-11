import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../l10n/app_localizations.dart';

class ApiErrorHandler {
  static String getErrorMessage(Object error, AppLocalizations l10n) {
    if (error is SocketException || error is http.ClientException) {
      return l10n.serverConnectionError;
    } else if (error is TimeoutException) {
      return l10n.connectionTimeout;
    } else {
      return l10n.errorOccurred(error.toString());
    }
  }
}
