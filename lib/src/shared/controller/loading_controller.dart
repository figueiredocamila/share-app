class LoadingController {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void startLoading() {
    _isLoading = true;
  }

  void stopLoading() {
    _isLoading = false;
  }

  void dispose() {
    _isLoading = false;
  }
}
