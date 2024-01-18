abstract class Failure {
  final String message;

  const Failure({
    required this.message,
  });
}

class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
  });
}

class OtherFailure extends Failure {
  const OtherFailure({
    required super.message,
  });
}