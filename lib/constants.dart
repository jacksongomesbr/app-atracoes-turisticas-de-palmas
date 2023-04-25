abstract class Constants {
  static const String API_HOST = String.fromEnvironment(
    'API_HOST',
    defaultValue: '',
  );
  static const String MEDIA_HOST = String.fromEnvironment(
    'MEDIA_HOST',
    defaultValue: '',
  );
}