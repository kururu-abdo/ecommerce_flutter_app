class Result<S , E extends Exception>   {

Result();
}
class Success<S , E extends Exception> extends Result<S,E>{

  Success(this.value);
  final S value;
}
class Failure<S, E extends Exception> extends Result<S,E> {
  

  Failure(this.exception);
  final E exception;
}