class NotificationException implements Exception {
  String notificationPermissionDenied() {
    return 'Permissão de notificação negada';
  }
}
