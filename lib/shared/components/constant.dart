//
// https://newsapi.org/v2/everything?q=bitcoin&apiKey=ddd33db03eb742ec88168214054067aa

import 'package:shop_app/modules/shop_app/shopp_app_login/login_screen.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';

import 'copmponents.dart';


void signOut(context){
  CasheHelper.removeData(key: 'token').then((value) =>
  {
    navigateAndFinish(context, ShopLoginScreen()),
  }
  );



}
dynamic? tokens = '';
String uId = '';


void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
