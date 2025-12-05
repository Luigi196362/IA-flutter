import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @loginTitle.
  ///
  /// In es, this message translates to:
  /// **'Bienvenido de nuevo'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Por favor inicia sesión para continuar'**
  String get loginSubtitle;

  /// No description provided for @usernameLabel.
  ///
  /// In es, this message translates to:
  /// **'Usuario'**
  String get usernameLabel;

  /// No description provided for @usernameHint.
  ///
  /// In es, this message translates to:
  /// **'Por favor ingresa tu usuario'**
  String get usernameHint;

  /// No description provided for @passwordLabel.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get passwordLabel;

  /// No description provided for @passwordHint.
  ///
  /// In es, this message translates to:
  /// **'Por favor ingresa tu contraseña'**
  String get passwordHint;

  /// No description provided for @loginButton.
  ///
  /// In es, this message translates to:
  /// **'INICIAR SESIÓN'**
  String get loginButton;

  /// No description provided for @loginSuccess.
  ///
  /// In es, this message translates to:
  /// **'¡Inicio de sesión exitoso!'**
  String get loginSuccess;

  /// No description provided for @loginFailed.
  ///
  /// In es, this message translates to:
  /// **'Fallo el inicio de sesión: {statusCode}'**
  String loginFailed(Object statusCode);

  /// No description provided for @errorOccurred.
  ///
  /// In es, this message translates to:
  /// **'Error: {error}'**
  String errorOccurred(Object error);

  /// No description provided for @registerTitle.
  ///
  /// In es, this message translates to:
  /// **'Crear Cuenta'**
  String get registerTitle;

  /// No description provided for @registerSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Regístrate para comenzar'**
  String get registerSubtitle;

  /// No description provided for @registerButton.
  ///
  /// In es, this message translates to:
  /// **'REGISTRARSE'**
  String get registerButton;

  /// No description provided for @registerLink.
  ///
  /// In es, this message translates to:
  /// **'¿No tienes cuenta? Regístrate'**
  String get registerLink;

  /// No description provided for @haveAccountLink.
  ///
  /// In es, this message translates to:
  /// **'¿Ya tienes cuenta? Inicia sesión'**
  String get haveAccountLink;

  /// No description provided for @registerSuccess.
  ///
  /// In es, this message translates to:
  /// **'¡Registro exitoso!'**
  String get registerSuccess;

  /// No description provided for @registerFailed.
  ///
  /// In es, this message translates to:
  /// **'Fallo el registro: {statusCode}'**
  String registerFailed(Object statusCode);

  /// No description provided for @homeTitle.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get homeTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In es, this message translates to:
  /// **'Configuración'**
  String get settingsTitle;

  /// No description provided for @profileTitle.
  ///
  /// In es, this message translates to:
  /// **'Perfil'**
  String get profileTitle;

  /// No description provided for @languageLabel.
  ///
  /// In es, this message translates to:
  /// **'Idioma'**
  String get languageLabel;

  /// No description provided for @logoutLabel.
  ///
  /// In es, this message translates to:
  /// **'Cerrar Sesión'**
  String get logoutLabel;

  /// No description provided for @welcomeUser.
  ///
  /// In es, this message translates to:
  /// **'Bienvenido, {username}'**
  String welcomeUser(Object username);

  /// No description provided for @galleryLabel.
  ///
  /// In es, this message translates to:
  /// **'Galería'**
  String get galleryLabel;

  /// No description provided for @addLabel.
  ///
  /// In es, this message translates to:
  /// **'Agregar'**
  String get addLabel;

  /// No description provided for @fileLabel.
  ///
  /// In es, this message translates to:
  /// **'Archivo'**
  String get fileLabel;

  /// No description provided for @cameraLabel.
  ///
  /// In es, this message translates to:
  /// **'Cámara'**
  String get cameraLabel;

  /// No description provided for @pickImageLabel.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar Imagen'**
  String get pickImageLabel;

  /// No description provided for @switchCamera.
  ///
  /// In es, this message translates to:
  /// **'Cambiar Cámara'**
  String get switchCamera;

  /// No description provided for @cameraError.
  ///
  /// In es, this message translates to:
  /// **'Error de cámara: {error}'**
  String cameraError(Object error);

  /// No description provided for @searchHint.
  ///
  /// In es, this message translates to:
  /// **'Buscar...'**
  String get searchHint;

  /// No description provided for @filterLabel.
  ///
  /// In es, this message translates to:
  /// **'Filtrar'**
  String get filterLabel;

  /// No description provided for @categoryAll.
  ///
  /// In es, this message translates to:
  /// **'Todas'**
  String get categoryAll;

  /// No description provided for @categoryAnimals.
  ///
  /// In es, this message translates to:
  /// **'Animales'**
  String get categoryAnimals;

  /// No description provided for @categoryCars.
  ///
  /// In es, this message translates to:
  /// **'Autos'**
  String get categoryCars;

  /// No description provided for @categoryFood.
  ///
  /// In es, this message translates to:
  /// **'Comida'**
  String get categoryFood;

  /// No description provided for @categoryPlants.
  ///
  /// In es, this message translates to:
  /// **'Plantas'**
  String get categoryPlants;

  /// No description provided for @categoryClothes.
  ///
  /// In es, this message translates to:
  /// **'Ropa'**
  String get categoryClothes;

  /// No description provided for @categoryMotorcycles.
  ///
  /// In es, this message translates to:
  /// **'Motos'**
  String get categoryMotorcycles;

  /// No description provided for @sendLabel.
  ///
  /// In es, this message translates to:
  /// **'Enviar'**
  String get sendLabel;

  /// No description provided for @retakeLabel.
  ///
  /// In es, this message translates to:
  /// **'Volver a tomar'**
  String get retakeLabel;

  /// No description provided for @uploadSuccess.
  ///
  /// In es, this message translates to:
  /// **'¡Imagen subida con éxito!'**
  String get uploadSuccess;

  /// No description provided for @uploadFailed.
  ///
  /// In es, this message translates to:
  /// **'Fallo la subida: {error}'**
  String uploadFailed(Object error);

  /// No description provided for @uploadingLabel.
  ///
  /// In es, this message translates to:
  /// **'Subiendo...'**
  String get uploadingLabel;

  /// No description provided for @imageTooLarge.
  ///
  /// In es, this message translates to:
  /// **'La imagen es demasiado grande. El máximo es 10MB.'**
  String get imageTooLarge;

  /// No description provided for @downloadButton.
  ///
  /// In es, this message translates to:
  /// **'Descargar'**
  String get downloadButton;

  /// No description provided for @correctButton.
  ///
  /// In es, this message translates to:
  /// **'Corregir Clasificación'**
  String get correctButton;

  /// No description provided for @correctClassification.
  ///
  /// In es, this message translates to:
  /// **'Corregir Clasificación'**
  String get correctClassification;

  /// No description provided for @cancelButton.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancelButton;

  /// No description provided for @confirmButton.
  ///
  /// In es, this message translates to:
  /// **'Confirmar'**
  String get confirmButton;

  /// No description provided for @classificationUpdated.
  ///
  /// In es, this message translates to:
  /// **'¡Clasificación actualizada con éxito!'**
  String get classificationUpdated;

  /// No description provided for @downloadStarted.
  ///
  /// In es, this message translates to:
  /// **'Descarga iniciada...'**
  String get downloadStarted;

  /// No description provided for @deleteButton.
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get deleteButton;

  /// No description provided for @deleteConfirmTitle.
  ///
  /// In es, this message translates to:
  /// **'Eliminar Imagen'**
  String get deleteConfirmTitle;

  /// No description provided for @deleteConfirmContent.
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro de que deseas eliminar esta imagen?'**
  String get deleteConfirmContent;

  /// No description provided for @deleteSuccess.
  ///
  /// In es, this message translates to:
  /// **'Imagen eliminada con éxito'**
  String get deleteSuccess;

  /// No description provided for @deleteFailed.
  ///
  /// In es, this message translates to:
  /// **'Fallo al eliminar la imagen: {error}'**
  String deleteFailed(Object error);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
