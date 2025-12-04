// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get loginTitle => 'Welcome Back';

  @override
  String get loginSubtitle => 'Please sign in to continue';

  @override
  String get usernameLabel => 'Username';

  @override
  String get usernameHint => 'Please enter your username';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHint => 'Please enter your password';

  @override
  String get loginButton => 'LOGIN';

  @override
  String get loginSuccess => 'Login Successful!';

  @override
  String loginFailed(Object statusCode) {
    return 'Login Failed: $statusCode';
  }

  @override
  String errorOccurred(Object error) {
    return 'Error: $error';
  }

  @override
  String get registerTitle => 'Create Account';

  @override
  String get registerSubtitle => 'Sign up to get started';

  @override
  String get registerButton => 'REGISTER';

  @override
  String get registerLink => 'Don\'t have an account? Sign up';

  @override
  String get haveAccountLink => 'Already have an account? Login';

  @override
  String get registerSuccess => 'Registration Successful!';

  @override
  String registerFailed(Object statusCode) {
    return 'Registration Failed: $statusCode';
  }
}
