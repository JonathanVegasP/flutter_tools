class AppValidators {
  AppValidators._();

  static bool isNull(Object object) => object == null;

  static bool isNotNull(Object object) => !isNull(object);

  static bool isNullOrEmpty(String input) =>
      input == null || input.trim().isEmpty;

  static bool isNotNullOrNotEmpty(String input) => !isNullOrEmpty(input);

  static bool isEmail(String email) {
    if (isNullOrEmpty(email)) {
      return false;
    }
    final pattern =
        r'^[\w-_]+(\.[\w-_]+)*@[a-z0-9]{2,}(\.[a-z]{2,6})*(\.[a-z]{2,6})$';
    final regexp = RegExp(pattern);
    return regexp.hasMatch(email);
  }

  static bool isFullName(String input) {
    if (isNullOrEmpty(input)) {
      return false;
    }
    return input.trim().split(' ').length > 1;
  }

  static String Function(String event) fieldValidation(
      bool validation(String input),
      [String message = "Campo inválido"]) {
    return (event) {
      if (!validation(event)) {
        return message;
      }
      return null;
    };
  }
}
