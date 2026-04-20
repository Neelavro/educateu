
class ApiConstants {
  static const String authBaseUrl = 'http://18.171.208.170:4040/'; // production
}


// Student endpoints

String studentEndpoint = 'student-auth/';
String loginEndpoint = 'login/';
String sendOtpPending = loginEndpoint+ 'with-otp/';
String securityQuestionEndpoint = studentEndpoint + "security-questions";
