///Classe que representa um erro na comunicação com o firebase
class AuthException implements Exception {
  static const Map<String, String> _erros = {
    'EMAIL_EXISTS': 'Esse e-mail já possui uma conta!',
    'OPERATION_NOT_ALLOWED': 'Operação não permitida.',
    'TOO_MANY_ATTEMPTS_TRY_LATER':
        // ignore: lines_longer_than_80_chars
        'Você tentou fazer o login muitas vezes, tente mais tarde!',
    // ignore: lines_longer_than_80_chars
    'EMAIL_NOT_FOUND': 'Não existe uma conta com esse e-mail.',
    'INVALID_PASSWORD': 'Senha inválida.',
    'USER_DISABLED': 'Usuário desativado.',
  };
  final String? _key;

  ///A messagem será apresentada através do construtor
  const AuthException(this._key);

  @override
  String toString() {
    if (_erros.containsKey(_key)) {
      return _erros[_key!]!;
    } else {
      return 'There a error!';
    }
  }
}
