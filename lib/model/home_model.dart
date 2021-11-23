// class HomeModel
// {
//   bool? status;
//   HomeDataModel? data;
//
//   HomeModel.fromJson(Map<String, dynamic> json)
//   {
//     status = json['status'];
//     data = HomeDataModel.fromJson(json['data']);
//   }
// }
//
// class HomeDataModel
// {
//   List<BannerModel>? banners = [];
//   List<ProductModel>? products = [];
//
//   HomeDataModel.fromJson(Map<String, dynamic> json)
//   {
//     json['banners'].forEach((element)
//     {
//       banners!.add(BannerModel.fromJson(element));
//     });
//
//     json['products'].forEach((element)
//     {
//       products!.add(ProductModel.fromJson(element));
//     });
//   }
// }
//
// class BannerModel
// {
//   int? id;
//   String? image;
//
//   BannerModel.fromJson(Map<String, dynamic> json)
//   {
//     id = json['id'];
//     image = json['image'];
//   }
// }
//
// class ProductModel
// {
//   var id;
//   dynamic price;
//   dynamic oldPrice;
//   dynamic discount;
//   String? image;
//   String? name;
//   bool ? inFavorites;
//   bool? inCart;
//   String? description;
//
//   ProductModel.fromJson(Map<String, dynamic> json)
//   {
//     id = json['id'];
//     price = json['price'];
//     oldPrice = json['old_price'];
//     discount = json['discount'];
//     image = json['image'];
//     name = json['name'];
//     inFavorites = json['in_favorites'];
//     inCart = json['in_cart'];
//     description = json['description'];
//   }
// }
class HomeModel {
  bool? status;
  Null message;
  Data? data;



  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Banners> banners =[];
  List<ProductModel> products = [];
  String? ad;



  Data.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners =  <Banners>[];
      json['banners'].forEach((v) {
        banners.add(new Banners.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <ProductModel>[];
      json['products'].forEach((v) {
        products.add(new ProductModel.fromJson(v));
      });
    }
    ad = json['ad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.banners != null) {
      data['banners'] = this.banners.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    data['ad'] = this.ad;
    return data;
  }
}

class Banners {
  int? id;
  String? image;
  Null category;
  Null product;

  Banners({this.id, this.image, this.category, this.product});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    category = json['category'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['category'] = this.category;
    data['product'] = this.product;
    return data;
  }
}

class ProductModel {
  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  List<String> images=[];
  bool? inFavorites;
  bool? inCart;



  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['discount'] = this.discount;
    data['image'] = this.image;
    data['name'] = this.name;
    data['description'] = this.description;
    data['images'] = this.images;
    data['in_favorites'] = this.inFavorites;
    data['in_cart'] = this.inCart;
    return data;
  }
}
