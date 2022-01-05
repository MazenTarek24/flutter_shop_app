import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/Theme.dart';

import 'layout/shop_app/shop_app.dart';
import 'layout/shop_app/shop_cupit/cubit.dart';
import 'layout/shop_app/shop_cupit/state.dart';
import 'modules/shop_app/on_boarding/onBoardingScreen.dart';
import 'modules/shop_app/shopp_app_login/login_screen.dart';



Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();


  Bloc.observer = MyBlocObserver();
  DioHelper.dioInit();

  await CasheHelper.init();

  Widget widget;



  bool onBoarding = CasheHelper.getData(key : 'onBoarding') ;
  tokens = CasheHelper.getData(key: 'token') != null ? CasheHelper.getData(key: 'token') :null;

  uId = CasheHelper.getData(key: 'uId');



  if(onBoarding != null)
  {
    if(tokens != null) {
      widget = ShopLayout();
    }
    else widget = ShopLoginScreen();
  }else
  {
    widget = OnBoardingScreen();
  }


  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {



  final Widget startWidget;

  MyApp({
    required this.startWidget
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ShopCubit()
            ..getHomeData()
            ..getCategoryData()
            ..getFavorites()
            ..getUserData(),
        ),
      ],
      child: BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );
  }
}