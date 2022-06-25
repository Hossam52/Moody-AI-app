
import 'package:moody_app/shared/helper/error_handling/response_code.dart';

import 'data_source_enum.dart';
import 'failure_model.dart';

extension DatasourceExtention on DataSource
{
  Failure getFailureResponse()
  {
    switch (this) {
      
      case DataSource.noContetn:
        return Failure(code: ResponseCode.noContetn, message: ResponseMessage.noContetn);
        case DataSource.badRequest:
        return Failure(code: ResponseCode.badRequest, message: ResponseMessage.badRequest);
        case DataSource.forbidden:
        return Failure(code: ResponseCode.forbidden, message: ResponseMessage.forbidden);
        case DataSource.unauthorized:
        return Failure(code: ResponseCode.unauthorized, message: ResponseMessage.unauthorized);
        case DataSource.connectTimeout:
        return Failure(code: ResponseCode.connectTimeout, message: ResponseMessage.connectTimeout);
        case DataSource.recieveTimeout:
        return Failure(code: ResponseCode.recieveTimeout, message: ResponseMessage.recieveTimeout);
        case DataSource.sendTimeout:
        return Failure(code: ResponseCode.sendTimeout, message: ResponseMessage.sendTimeout);
        case DataSource.noInternetConnecation:
        return Failure(code: ResponseCode.noInternetConnecation, message: ResponseMessage.noInternetConnecation);
        case DataSource.cancel:
        return Failure(code: ResponseCode.cancel, message: ResponseMessage.cancel);
        case DataSource.notFound:
        return Failure(code: ResponseCode.notFound, message: ResponseMessage.notFound);
      default:
        return Failure(code: ResponseCode.defaultError, message: ResponseMessage.defaultError);

    }
  }
}