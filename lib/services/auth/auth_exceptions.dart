// From LoginView
class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

//From RegisterView
class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

// Generic Exceptions
class GenericAuthException implements Exception {}

class UserNoLoggedInAuthException implements Exception {}