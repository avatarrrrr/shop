enum AuthenticationsMethods {
  emailAndPassword,
}

abstract class AuthInterface {
  abstract bool isLogged;
  abstract AuthenticationsMethods method;

  Future<void> create({required String emailTyped, required String passwordTyped});
  Future<void> login({required String emailTyped, required String passwordTyped});
  Future<void> logout();
}
