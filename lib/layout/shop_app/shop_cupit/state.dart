

import 'package:shop_app/models/shop_app_model/shop_change_favourite_model.dart';
import 'package:shop_app/models/shop_app_model/shop_login_model.dart';

abstract class ShopState{}

class ShopInitialState extends ShopState {}

class ShopBottomNavBarState extends ShopState {}

class ShopSuccessState extends ShopState {}
class ShopLoadingState extends ShopState {}
class ShopErrorState extends ShopState {
  String errorApi;
  ShopErrorState(this.errorApi);
}

class ShopCategorySuccessState extends ShopState {}
class ShopCategoryErrorState extends ShopState {
  String errorCategoryData;
  ShopCategoryErrorState(this.errorCategoryData);
}

class ShopChangeFavoritesState extends ShopState {}

class ShopSuccessChangeFavoritesState extends ShopState
{
  final ChangeFavouriteModel? model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopState {
  final String onError;

  ShopErrorChangeFavoritesState(this.onError);
}

class ShopLoadingGetFavoritesState extends ShopState {}

class ShopSuccessGetFavoritesState extends ShopState {}

class ShopErrorGetFavoritesState extends ShopState {}

class ShopLoadingGetProfileState extends ShopState {}
class ShopSuccessGetProfileState extends ShopState {
  ShopLoginModel? loginModel;

  ShopSuccessGetProfileState(this.loginModel);
}
class ShopErrorGetProfileState extends ShopState {
  //final String onError;

  //ShopErrorGetProfileState(this.onError);

}

class ShopLoadingProfileState extends ShopState {}


class ShopRegisterSuccessfulState extends ShopState {
   ShopLoginModel? loginModel;

  ShopRegisterSuccessfulState(this.loginModel);


}
class ShopRegisterLoadingState extends ShopState {}
class ShopRegisterErrorState extends ShopState {
  final String error;

  ShopRegisterErrorState(this.error);
}
class ShopRegisterChangePasswordVisibilityState extends ShopState {}

class ShopLoadingUpdateUserState extends ShopState {}

class ShopSuccessUpdateUserState extends ShopState
{
  //final ShopLoginModel loginModel;

  ShopSuccessUpdateUserState();
}

class ShopErrorUpdateUserState extends ShopState {}