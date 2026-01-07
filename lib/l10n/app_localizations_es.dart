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

  @override
  String get registerTitle => 'Crear Cuenta';

  @override
  String get registerSubtitle => 'Regístrate para comenzar';

  @override
  String get registerButton => 'REGISTRARSE';

  @override
  String get registerLink => '¿No tienes cuenta? Regístrate';

  @override
  String get haveAccountLink => '¿Ya tienes cuenta? Inicia sesión';

  @override
  String get registerSuccess => '¡Registro exitoso!';

  @override
  String registerFailed(Object statusCode) {
    return 'Fallo el registro: $statusCode';
  }

  @override
  String get homeTitle => 'Inicio';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get profileTitle => 'Perfil';

  @override
  String get languageLabel => 'Idioma';

  @override
  String get logoutLabel => 'Cerrar Sesión';

  @override
  String welcomeUser(Object username) {
    return 'Bienvenido, $username';
  }

  @override
  String get galleryLabel => 'Galería';

  @override
  String get addLabel => 'Agregar';

  @override
  String get fileLabel => 'Archivo';

  @override
  String get cameraLabel => 'Cámara';

  @override
  String get pickImageLabel => 'Seleccionar Imagen';

  @override
  String get switchCamera => 'Cambiar Cámara';

  @override
  String cameraError(Object error) {
    return 'Error de cámara: $error';
  }

  @override
  String get searchHint => 'Buscar...';

  @override
  String get filterLabel => 'Filtrar';

  @override
  String get categoryAll => 'Todas';

  @override
  String get categoryAnimals => 'Animales';

  @override
  String get categoryCars => 'Autos';

  @override
  String get categoryFood => 'Comida';

  @override
  String get categoryPlants => 'Plantas';

  @override
  String get categoryClothes => 'Ropa';

  @override
  String get categoryMotorcycles => 'Motos';

  @override
  String get sendLabel => 'Enviar';

  @override
  String get retakeLabel => 'Volver a tomar';

  @override
  String get uploadSuccess => '¡Imagen subida con éxito!';

  @override
  String uploadFailed(Object error) {
    return 'Fallo la subida: $error';
  }

  @override
  String get uploadingLabel => 'Subiendo...';

  @override
  String get imageTooLarge =>
      'La imagen es demasiado grande. El máximo es 10MB.';

  @override
  String get downloadButton => 'Descargar';

  @override
  String get correctButton => 'Corregir Clasificación';

  @override
  String get correctClassification => 'Corregir Clasificación';

  @override
  String get cancelButton => 'Cancelar';

  @override
  String get confirmButton => 'Confirmar';

  @override
  String get classificationUpdated => '¡Clasificación actualizada con éxito!';

  @override
  String get downloadStarted => 'Descarga iniciada...';

  @override
  String get deleteButton => 'Eliminar';

  @override
  String get deleteConfirmTitle => 'Eliminar Imagen';

  @override
  String get deleteConfirmContent =>
      '¿Estás seguro de que deseas eliminar esta imagen?';

  @override
  String get deleteSuccess => 'Imagen eliminada con éxito';

  @override
  String deleteFailed(Object error) {
    return 'Fallo al eliminar la imagen: $error';
  }

  @override
  String get aboutTitle => 'Acerca de';

  @override
  String get aboutDescription =>
      'Esta aplicación es una galería inteligente que, haciendo uso de IA, puede clasificar imágenes y almacenarlas en una base de datos para su futura consulta.';
}
