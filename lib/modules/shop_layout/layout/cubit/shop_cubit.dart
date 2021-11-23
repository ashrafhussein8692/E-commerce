import 'package:bloc/bloc.dart';
import 'package:e_commerce/model/cart_model.dart';
import 'package:e_commerce/model/change_fav_model.dart';
import 'package:e_commerce/model/delete_cart.dart';
import 'package:e_commerce/model/favorites_model.dart';
import 'package:e_commerce/model/home_model.dart';
import 'package:e_commerce/model/user_model.dart';
import 'package:e_commerce/modules/shop_layout/cart/cart_screen.dart';
import 'package:e_commerce/modules/shop_layout/categories/categories_screen.dart';
import 'package:e_commerce/modules/shop_layout/favorites/favorites_screen.dart';
import 'package:e_commerce/modules/shop_layout/layout/cubit/shop_states.dart';
import 'package:e_commerce/modules/shop_layout/products/products_screen.dart';
import 'package:e_commerce/network/dio_helper.dart';
import 'package:e_commerce/shared/constants.dart';
import 'package:e_commerce/shared/end_point.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../model/categories_model.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> BottomScreen = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    CartScreen(),

  ];

  void ChangeNav(int index) {
    currentIndex = index;
    emit(ShopChangeNag());
  }

  int cartProductsNumber =0 ;
  Map favorites = {};
  Map cart = {};

  HomeModel? homeModel;

  void getHomeData() {
    emit(ShopLoadingHomeDataStates());
    DioHelper.getData(url: HOME_DATA, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((e) {
        favorites.addAll({e.id: e.inFavorites});
        cart.addAll({e.id: e.inCart});

        if (e.inCart ==true ) {
          cartProductsNumber++;
        }
        // else {
        //   quantity--;
        // }


      });

      print(cart);
      emit(ShopSuccessHomeDataStates());
    }).catchError((error) {
      print(error);
      emit(ShopErrorHomeDataStates());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    emit(ShopLoadingCategoryStates());
    DioHelper.getData(url: CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      // print(value.data);
      emit(ShopSuccessCategoryStates());
    }).catchError((error) {
      print(error);
      emit(ShopErrorCategoryStates());
    });
  }

  ChangeFavModel? changeFavModel;

  void ChangeFav(int? productId) {
    favorites[productId] = !favorites[productId];
    emit(ShopLoadingChangeFavoritesStates());
    DioHelper.postData(
            url: FAVORITES, data: {'product_id': productId}, token: token)
        .then((value) {
      changeFavModel = ChangeFavModel.fromJson(value.data);
      if (!changeFavModel!.status!) {
        favorites[productId] = !favorites[productId];
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesStates(changeFavModel!));
      // print(value.data);
    }).catchError((error) {
      favorites[productId] = !favorites[productId];
      emit(ShopErrorChangeFavoritesStates());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopLoadingFavoritesStates());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      // print(value.data);
      emit(ShopSuccessFavoritesStates());
    }).catchError((error) {
      // print(error);
      emit(ShopErrorFavoritesStates());
    });
  }

  AddOrDeleteModel? addOrDeleteModel;

  void addOrdelete(int productId) {

    changeLocalCart(productId);

     // cart[productId] = ! cart[productId];
    emit(ShopLoadingAddCartStates());
    DioHelper.postData(url: CART, token: token, data: {
      'product_id': productId,
    }).then((value) {
      addOrDeleteModel = AddOrDeleteModel.fromJson(value.data);

      // if (!addOrDeleteModel!.status!) {
      // cart[productId] = !cart[productId];
      if (addOrDeleteModel!.status == false) {
        changeLocalCart(productId);
      }
      emit(ShopSuccessAddCartStates(addOrDeleteModel!));
        getCart();


    }).catchError((error) {
      changeLocalCart(productId);
      // cart[productId] = !cart[productId];
      emit(ShopErrorAddCartStates());
    });
  }

  CartModel? cartModel;
 var totalAmont =0;

  void getCart() {
    emit(ShopLoadingUpdateCartStates());
    DioHelper.getData(url: CART, token: token).then((value) {
      cartModel = CartModel.fromJson(value.data);
      cartModel!.data!.cartItems.forEach((e) {
        cart.addAll({e.product!.id : e.product!.inCart});
        totalAmont = cartModel!.data!.total!;


        // if (e.product!.inCart ==true ) {
        //   cartProductsNumber++;
        //   }else {
        //   cartProductsNumber--;
        // }


      });

      emit(ShopSuccessCartStates());
    }).catchError((error) {
      // print(error);
      emit(ShopErrorCartStates());
    });
  }
  // int get totalPrice{
  //   cartModel!.data!.cartItems.forEach((element) {
  //     cart.addAll({element.id : element.product!.price});
  //     totalAmont+= element.product!.;
  //   });
  //   return totalAmont;
  // }

  UserModel? userModel;

  void getUserData() {
    emit(ShopLoadingUserDataStates());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      userModel = UserModel.fromJson(value.data);
      // print(value.data);
      emit(ShopSuccessUserDataStates());
    }).catchError((error) {
      // print(error);
      emit(ShopErrorUserDataStates());
    });
  }

  void upDateCart(int? id, int? quantity) {
    emit(ShopLoadingUpdateCartStates());
    DioHelper.updateData(
        url: UPDATE_CART,
        token: token,
        data: {'id': id, 'quantity': quantity}).then((value) {
      getCart();
    }).catchError((error) {
      emit(ShopErrorUpdateCartStates());
    });
  }


  void changeLocalCart(id) {
    cart[id] = !cart[id] ;

    if (cart[id]) {
      cartProductsNumber++;
    }
    else {
      cartProductsNumber--;
    }

    emit(AppChangeCartLocalState());
  }
}
