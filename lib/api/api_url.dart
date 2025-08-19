class ApiUrl {
  const ApiUrl._();

  static String domain = 'https://example.com/';
  static String imageBaseUrl = 'https://example.com/';
  static String midUrl = 'api/';

  static String get baseUrl => domain + midUrl;

  static createAPIUrl(String endPoint) => baseUrl + endPoint;

  static String get create => createAPIUrl('example/example');
}
