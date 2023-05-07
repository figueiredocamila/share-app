class AuthException implements Exception {
  String emailAlreadyInUse() {
    return 'Este e-mail já está em uso.';
  }

  String userNotFound() {
    return 'Usuário não encontrado';
  }

  String wrongPassword() {
    return 'Senha incorreta';
  }

  String unableSignUp() {
    return 'Não foi possível cadastrar este usuário';
  }

  String unableSignIn() {
    return 'Não foi possível realizar o login';
  }

  String userSignedOut() {
    return 'Usuário deslogado';
  }
}
