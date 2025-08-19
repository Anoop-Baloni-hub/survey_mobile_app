
class Helper {
  static final Helper helper = Helper._();

  Helper._();
  static bool isDebug = true;
  static String get apiBaseUrl => isDebug ? 'https://api.example.com' : 'https://api.example.com';
}
