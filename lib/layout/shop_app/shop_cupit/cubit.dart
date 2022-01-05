import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/shop_cupit/state.dart';
import 'package:shop_app/models/shop_app_model/shop_category_model.dart';
import 'package:shop_app/models/shop_app_model/shop_change_favourite_model.dart';
import 'package:shop_app/models/shop_app_model/shop_favourite_model.dart';
import 'package:shop_app/models/shop_app_model/shop_login_model.dart';
import 'package:shop_app/models/shop_app_model/shop_model.dart';
import 'package:shop_app/modules/shop_app/category_screen/shop_category_screen.dart';
import 'package:shop_app/modules/shop_app/favourite_screen/shop_favourite_screen.dart';
import 'package:shop_app/modules/shop_app/product_screen/shop_product_screen.dart';
import 'package:shop_app/modules/shop_app/setting_screen/shop_setting_screen.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/network/end_point/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeBottom(index) {
    currentIndex = index;
    emit(ShopBottomNavBarState());
  }

  List<Widget> bottomNavBarScreen = [
    ProductScreen(),
    CategoryScreen(),
    FavoritesScreen(),
    SettingsScreen(),

  ];


 // String token = '';

  HomeModel? homeModel;


  var productsMap = {};


  void getHomeData() {
    emit(ShopLoadingState());

    DioHelper.getData(
      url: Home,
      token: tokens,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

    //  print(homeModel?.data?.banners[0].image);
      var i = 0;
      homeModel!.data.products.forEach((element) {
        productsMap[element.id] = i++;
        favorites[element.id] = element.inFavorites;
      });
      emit(ShopSuccessState());
    }).catchError((error) {
      //print(error.toString());
      emit(ShopErrorState(error.toString()));
    });
  }

  CategoryModel? categoryModel;

  void getCategoryData() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: tokens,
    ).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);

      //print(categoryModel?.data?.dataModel[0].image);


      emit(ShopCategorySuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopCategoryErrorState(error.toString()));
    });
  }

  Map<dynamic, dynamic> favorites = {};

  var itemsInFavorites = 0;

  ChangeFavouriteModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId];

    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVOURITES,
      data: {
        'product_id': productId,
      },
      token: tokens,
    ).then((value) {
      changeFavoritesModel = ChangeFavouriteModel.fromJson(value?.data);
      print(value?.data.toString());
      if (!changeFavoritesModel!.status) {
        favorites[productId] = !favorites[productId]!;
      }
      else {
        getFavorites();
      }

      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritesState(error.toString()));
      print(error.toString());
    });
  }


  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
        url: FAVOURITES,
        token: tokens
    ).then((favorites) {
      favoritesModel = FavoritesModel.fromJson(favorites.data);
      itemsInFavorites = favoritesModel!.data.favData.length;
      //print(favorites.toString()+"jjjjjjjjjjj");
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      emit(ShopErrorGetFavoritesState());
      print('Get Favorites Error ${error.toString()}');
    });
  }

  ShopLoginModel? loginModel;
  Future getUserData() async {
    emit(ShopLoadingGetProfileState());

   await DioHelper.getData(
      url: PROFILE,
      token: tokens,

    ).then((value) {
     loginModel = ShopLoginModel.fromJson(value.data);
  //    printFullText(loginModel?.data?.name as String);
     // print("vvvvvvhhhhhhhhhhhhhhhhhhhhhhhhhhhhjzvxcbssjcn slkznc;lszclmncs");


      emit(ShopSuccessGetProfileState(loginModel));
    }).catchError((error) {
      print("ki;;;;;;;;;;;;;;;"+error.toString());
      emit(ShopErrorGetProfileState());
    });
  }

  void registerUser({
    required String email,
    required String password,
    required String name,
    required String phone,
})
  {
  emit(ShopRegisterLoadingState());

  DioHelper.postData(
  url: REGISTER,
  data:
  {
    'name' : name,
    'phone' : phone,
  'email': email,
  'password': password,
  },
  ).then((value)
  {
 // print(value?.data);
  loginModel = ShopLoginModel.fromJson(value?.data);
  emit(ShopRegisterSuccessfulState(loginModel));

  }).catchError((error)
  {
  print(error.toString());
  emit(ShopErrorState(error.toString()));
  });
  }

  void updateUser({
    required String name,
    required String email,
    required String phone,
  })
  {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
      url: UPDATE,
      token: tokens,
      data:
      {
        'name' : name,
        'email': email,
        'phone' : phone,
      },
    ).then((value)
    {
    //  print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserState());

    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(ShopRegisterChangePasswordVisibilityState());
  }

  }

