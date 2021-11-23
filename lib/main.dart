import 'package:bloc/bloc.dart';
import 'package:e_commerce/shared/constants.dart';
import 'package:e_commerce/splash_dcreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'modules/boarding/onboarding_screen.dart';
import 'modules/login/login_screen.dart';
import 'modules/shop_layout/cart/cart_screen.dart';
import 'modules/shop_layout/layout/cubit/shop_cubit.dart';
import 'modules/shop_layout/layout/shop_layout.dart';
import 'modules/shop_layout/products/products_screen.dart';

import 'network/dio_helper.dart';
import 'network/shared_preference.dart';
import 'shared/bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;

  dynamic onBoarding = CacheHelper.getData(key: 'onBoarding');
  print(onBoarding);
  token = CacheHelper.getData(key: 'token');
  print(token);
  if (onBoarding != null) {
    if (token != null) {
      widget = ShopLayOut();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()
        ..getHomeData()
        ..getCategories()
        ..getFavorites()
        ..getCart(),
      child: MaterialApp(
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
                color: Colors.white,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black)),
            fontFamily: 'ZillaSlab2'),
        home: SplashPage(),

      ),
    );
  }
}
