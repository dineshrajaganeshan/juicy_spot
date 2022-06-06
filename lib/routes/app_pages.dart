import 'package:get/get.dart';
import 'package:juicy_spot/routes/app_routes.dart';
import 'package:juicy_spot/screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:juicy_spot/screens/home_screen/home_screen.dart';
import 'package:juicy_spot/screens/login_screen/login_screen.dart';
import 'package:juicy_spot/screens/my_account/my_account_screen.dart';
import 'package:juicy_spot/screens/my_cart_screen/my_cart_screen.dart';
import 'package:juicy_spot/screens/order_history_screen/order_history_screen.dart';
import 'package:juicy_spot/screens/otp_verify_screen/otp_verify_screen.dart';
import 'package:juicy_spot/screens/product_screen/product_screen.dart';
import 'package:juicy_spot/screens/profile_screen/profile_screen.dart';
import 'package:juicy_spot/screens/register_screen/register_screen.dart';
import 'package:juicy_spot/screens/set_new_password_screen/set_new_password_screen.dart';
import 'package:juicy_spot/screens/splash_screen/splash_screen.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.SPLASHSCREEN, page: () => SplashScreen()),
    GetPage(name: AppRoutes.LOGIN, page: () => LoginScreen()),
    GetPage(name: AppRoutes.OTPVERIFY, page: () => OTPVerifyScreen()),
    GetPage(name: AppRoutes.REGISTERSCREEN, page: () => RegisterScreen()),
    GetPage(name: AppRoutes.EDITACCOUNT, page: () => ProfileScreen()),
    GetPage(name: AppRoutes.MYACCOUNT, page: () => MyAccountScreen()),
    GetPage(name: AppRoutes.HOMESCREEN, page: () => HomeScreen()),
    GetPage(name: AppRoutes.PRODUCTSCREEN, page: () => ProductScreen()),
    GetPage(name: AppRoutes.MYCART, page: () => MyCart()),
    GetPage(name: AppRoutes.ORDERHISTORY, page: () => OrderHistoryScreen()),
    GetPage(
        name: AppRoutes.SETPASSWORDSCREEN, page: () => SetNewPasswordScreen()),
    GetPage(
        name: AppRoutes.FORGOTPASSWORDSCREEN,
        page: () => ForgotPasswordScreen()),
  ];
}
