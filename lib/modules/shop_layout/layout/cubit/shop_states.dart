
import 'package:e_commerce/model/change_fav_model.dart';
import 'package:e_commerce/model/delete_cart.dart';

abstract class ShopStates{}
class ShopInitialStates extends ShopStates{}
class ShopChangeNag extends ShopStates{}
class ShopLoadingHomeDataStates extends ShopStates{}
class ShopSuccessHomeDataStates extends ShopStates{}
class ShopErrorHomeDataStates extends ShopStates{}
class ShopLoadingCategoryStates extends ShopStates{}
class ShopLoadingProductStates extends ShopStates{}
class ShopSuccessProductStates extends ShopStates{}
class ShopErrorProductStates extends ShopStates{}
class ShopSuccessCategoryStates extends ShopStates{}
class ShopErrorCategoryStates extends ShopStates{}
class ShopLoadingFavoritesStates extends ShopStates{}
class ShopSuccessFavoritesStates extends ShopStates{}
class ShopErrorFavoritesStates extends ShopStates{}
class ShopLoadingChangeFavoritesStates extends ShopStates{}
class ShopSuccessChangeFavoritesStates extends ShopStates{
  ChangeFavModel model;

  ShopSuccessChangeFavoritesStates(this.model);
}
class ShopErrorChangeFavoritesStates extends ShopStates{}
class ShopLoadingCartStates extends ShopStates{}
class ShopSuccessCartStates extends ShopStates{}
class ShopErrorCartStates extends ShopStates{}
class ShopLoadingAddCartStates extends ShopStates{}
class ShopSuccessAddCartStates extends ShopStates{
  AddOrDeleteModel model;

  ShopSuccessAddCartStates(this.model);
}
class ShopErrorAddCartStates extends ShopStates{}
class ShopLoadingUpdateCartStates extends ShopStates{}
class ShopSuccessUpdateCartStates extends ShopStates{}
class ShopErrorUpdateCartStates extends ShopStates{}
class ShopLoadingDeleteCartStates extends ShopStates{}
class ShopSuccessDeleteCartStates extends ShopStates{
   final AddOrDeleteModel model;

   ShopSuccessDeleteCartStates(this.model);
}
class ShopErrorDeleteCartStates extends ShopStates{}



class ShopLoadingUserDataStates extends ShopStates{}
class ShopSuccessUserDataStates extends ShopStates{}
class ShopErrorUserDataStates extends ShopStates{}
class AppChangeCartLocalState extends ShopStates{}
