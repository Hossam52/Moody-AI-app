
  
  //200-299=>success
  //300-399=>redirect to api
  //400-499=>client error response
  //500-599=> internal error server
class ResponseCode {
  static const int success = 200; // success with data
  static const int noContetn = 201; // success with no data (no content)
  static const int badRequest = 400; // failure, API rejected request
  static const int unauthorized = 401; // failure, user is not authorised
  static const int forbidden = 403; //  failure, API rejected request
  static const int internalServerError = 500; // failure, crash in server side
  static const int notFound = 404; // failure, not found

  // local status code
  static const int connectTimeout = -1;
  static const int cancel = -2;
  static const int recieveTimeout = -3;
  static const int sendTimeout = -4;
  static const int cacheError = -5;
  static const int noInternetConnecation = -6;
  static const int defaultError = -7;
}

class ResponseMessage {
  static const String success = "success"; // success with data
  static const String noContetn =
      "success"; // success with no data (no content)
  static const String badRequest =
      "Bad request, Try again later"; // failure, API rejected request
  static const String unauthorized =
      "User is unauthorised, Try again later"; // failure, user is not authorised
  static const String forbidden =
      "Forbidden request, Try again later"; //  failure, API rejected request
  static const String internalServerError =
      "Some thing went wrong, Try again later"; // failure, crash in server side
  static const String notFound =
      "Some thing went wrong, Try again later"; // failure, crash in server side

  // local status code
  static const String connectTimeout = "Time out error, Try again later";
  static const String cancel = "Request was cancelled, Try again later";
  static const String recieveTimeout = "Time out error, Try again later";
  static const String sendTimeout = "Time out error, Try again later";
  static const String cacheError = "Cache error, Try again later";
  static const String noInternetConnecation =
      "Please check your internet connection";
  static const String defaultError = "Some thing went wrong, Try again later";
}