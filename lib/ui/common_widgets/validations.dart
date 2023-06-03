import '../constants/strings.dart';

class Validations {

  String phonePattern="\d{5}([- ]*)\d{6}";
  String phonePattern2="^(?:[+0]9)?[0-9]{10}";


  bool isPasswordValid(String password) => password.length == 8;

  bool isEmailValid(String email) {
    String pattern ="^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]";
    RegExp regex =  RegExp(pattern);
    return regex.hasMatch(email);
  }

  bool isPhoneValid(String phone) {

    RegExp regex =  RegExp(phonePattern2);
    return regex.hasMatch(phone);
  }


   emailValidations(value){
    if (isEmailValid(value)) {
      return null;
    } else {
      return validEmailStr;
  }
  }

  bool validateMobile(String mobile) => mobile.length == 10;





  passwordValidations(value){
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }
    else if (value.length < 8) {
      return "Password must be atleast 8 characters long";
    }
    else {
      return null;
    }
  }


  emptyFieldValidator(value){
    if (value == null || value.isEmpty) {
      return 'Field Cannot be Empty';
    }
    else {
      return null;
    }

  }
}