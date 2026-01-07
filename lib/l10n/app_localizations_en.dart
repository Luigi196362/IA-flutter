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

  @override
  String get homeTitle => 'Home';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get profileTitle => 'Profile';

  @override
  String get languageLabel => 'Language';

  @override
  String get logoutLabel => 'Logout';

  @override
  String welcomeUser(Object username) {
    return 'Welcome, $username';
  }

  @override
  String get galleryLabel => 'Gallery';

  @override
  String get addLabel => 'Add';

  @override
  String get fileLabel => 'File';

  @override
  String get cameraLabel => 'Camera';

  @override
  String get pickImageLabel => 'Pick Image';

  @override
  String get switchCamera => 'Switch Camera';

  @override
  String cameraError(Object error) {
    return 'Camera Error: $error';
  }

  @override
  String get searchHint => 'Search...';

  @override
  String get filterLabel => 'Filter';

  @override
  String get categoryAll => 'All';

  @override
  String get categoryAnimals => 'Animals';

  @override
  String get categoryCars => 'Cars';

  @override
  String get categoryFood => 'Food';

  @override
  String get categoryPlants => 'Plants';

  @override
  String get categoryClothes => 'Clothes';

  @override
  String get categoryMotorcycles => 'Motorcycles';

  @override
  String get sendLabel => 'Send';

  @override
  String get retakeLabel => 'Retake';

  @override
  String get uploadSuccess => 'Image uploaded successfully!';

  @override
  String uploadFailed(Object error) {
    return 'Upload failed: $error';
  }

  @override
  String get uploadingLabel => 'Uploading...';

  @override
  String get imageTooLarge => 'Image is too large. Maximum is 10MB.';

  @override
  String get downloadButton => 'Download';

  @override
  String get correctButton => 'Correct Classification';

  @override
  String get correctClassification => 'Correct Classification';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get confirmButton => 'Confirm';

  @override
  String get classificationUpdated => 'Classification updated successfully!';

  @override
  String get downloadStarted => 'Download started...';

  @override
  String get deleteButton => 'Delete';

  @override
  String get deleteConfirmTitle => 'Delete Image';

  @override
  String get deleteConfirmContent =>
      'Are you sure you want to delete this image?';

  @override
  String get deleteSuccess => 'Image deleted successfully';

  @override
  String deleteFailed(Object error) {
    return 'Failed to delete image: $error';
  }

  @override
  String get aboutTitle => 'About';

  @override
  String get aboutDescription =>
      'This app is a smart gallery that uses AI to classify images and stores them in a database for future reference.';

  @override
  String get activityLogTitle => 'Activity Logs';

  @override
  String get noLogsFound => 'No logs found.';

  @override
  String errorLoadingLogs(Object error) {
    return 'Error loading logs: $error';
  }
}
