class ErrorController {
  static String errorMessage = '';

  static void setError(String error) {
    errorMessage = error;
  }

  static void clearError() {
    errorMessage = '';
  }
}
