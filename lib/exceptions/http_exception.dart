///Classe que representa um erro na comunicação com um servidor remoto
class HttpException implements Exception {
  ///Mensagem que será passada ao usuário
  final String _message;

  ///A messagem será apresentada através do construtor
  const HttpException(this._message);

  @override
  String toString() => _message;
}
