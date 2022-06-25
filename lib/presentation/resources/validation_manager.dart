import 'package:email_validator/email_validator.dart';
class ValidationManager {
 static String? passwordValidation(String? value) {
    if (value!.isEmpty) {
      return 'Please Enter Your Password';
    } else if (value.length < 6) {
      return 'Your Password Is Short';
    } else {
      return null;
    }
  }
 static String? emailValidation(String? value) 
  {
    if (value!.isEmpty) {
      return 'Please Enter Your E-mail';
    } else if (!EmailValidator.validate(value)) {
      return 'Please Enter Valid E-mail';
    } else 
    {
      return null;
    }
  }
}
