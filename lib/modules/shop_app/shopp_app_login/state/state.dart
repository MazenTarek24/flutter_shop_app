import 'package:shop_app/models/shop_app_model/shop_login_model.dart';

abstract class ShopLoginState {}

class ShopLoginInitialState extends ShopLoginState {}
class ShopLoginSuccessfulState extends ShopLoginState {
  final ShopLoginModel loginModel;

  ShopLoginSuccessfulState(this.loginModel);


}
class ShopLoadingState extends ShopLoginState {}
class ShopErrorState extends ShopLoginState {
  final String error;

  ShopErrorState(this.error);
}
class ShopChangePasswordVisibilityState extends ShopLoginState {}
