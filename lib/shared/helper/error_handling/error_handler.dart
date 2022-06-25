import 'package:dio/dio.dart';
import 'package:moody_app/shared/helper/error_handling/extentions.dart';
import 'package:moody_app/shared/helper/error_handling/response_code.dart';

import 'data_source_enum.dart';
import 'failure_model.dart';

abstract class HandlingErrors {
  Failure handleDioError(DioError error);
}

class ErrorHandler implements Exception,HandlingErrors {
  @override
  Failure handleDioError(DioError error) 
  {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return DataSource.connectTimeout.getFailureResponse();
      case DioErrorType.sendTimeout:
        return DataSource.sendTimeout.getFailureResponse();
      case DioErrorType.receiveTimeout:
        return DataSource.recieveTimeout.getFailureResponse();
      case DioErrorType.response:
        if (error.response != null &&
            error.response?.statusCode != null &&
            error.response?.statusMessage != null) {
          return Failure(
              code: error.response!.statusCode ??
                  ResponseCode.internalServerError,
              message: error.response?.statusMessage ??
                  ResponseMessage.internalServerError);
        } else {
          return DataSource.defaultError.getFailureResponse();
        }
      case DioErrorType.cancel:
        return DataSource.cancel.getFailureResponse();
      case DioErrorType.other:
        return DataSource.defaultError.getFailureResponse();
    }
  }

  Failure getErrorHappen(dynamic error) 
  {
    if (error is DioError) 
    {
      return handleDioError(error);
    } else {
      return DataSource.defaultError.getFailureResponse();
    }
  }
}
