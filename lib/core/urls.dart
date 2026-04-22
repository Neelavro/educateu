
class ApiConstants {
  static const String authBaseUrl = 'http://18.171.208.170:4040/'; // production
}

String studentPortalEndpoint  = 'student-portal/';

// Student endpoints

String studentEndpoint = 'student-auth/';
String loginEndpoint = 'login/';
String sendOtpEndPoint= studentEndpoint+loginEndpoint+ 'with-otp/';
String securityQuestionEndpoint = studentEndpoint + "security-questions";
String  changePasswordEndpoint = studentEndpoint + "change-password";

// Profile endpoints

String profileEndpoint = studentEndpoint + 'profile';
