class NotificationException implements Exception {
  String notificationPermissionDenied() {
    return 'Permissão de notificação negada';
  }

  String notificationNotFount() {
    return 'Notificação não encontrada';
  }
}
