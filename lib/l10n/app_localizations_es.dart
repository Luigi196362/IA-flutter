// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get loginTitle => 'Bienvenido de nuevo';

  @override
  String get loginSubtitle => 'Por favor inicia sesión para continuar';

  @override
  String get usernameLabel => 'Usuario';

  @override
  String get usernameHint => 'Por favor ingresa tu usuario';

  @override
  String get passwordLabel => 'Contraseña';

  @override
  String get passwordHint => 'Por favor ingresa tu contraseña';

  @override
  String get loginButton => 'INICIAR SESIÓN';

  @override
  String get loginSuccess => '¡Inicio de sesión exitoso!';

  @override
  String loginFailed(Object statusCode) {
    return 'Fallo el inicio de sesión: $statusCode';
  }

  @override
  String errorOccurred(Object error) {
    return 'Error: $error';
  }
}
