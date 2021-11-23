import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/model/home_model.dart';
import 'package:e_commerce/modules/shop_layout/layout/cubit/shop_cubit.dart';
import 'package:e_commerce/modules/shop_layout/layout/cubit/shop_states.dart';
import 'package:e_commerce/modules/shop_layout/products_details/products_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../components.dart';
import '../../../model/categories_model.dart';

class ProductsScreen extends StatelessWidget {
  static const routeName = 'product_screen';
  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoritesStates) {
          if (state.model.status!) {
            Fluttertoast.showToast(
                msg: '${state.model.message}',
                backgroundColor: Colors.green,
                fontSize: 15);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
            condition: cubit.homeModel != null && cubit.categoriesModel != null,
            builder: (context) =>
                buildHomeItems(cubit.homeModel!, cubit.categoriesModel!),
            fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }

  Widget buildHomeItems(HomeModel model, CategoriesModel categoriesModel) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data!.banners
                  .map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                initialPage: 0,
                viewportFraction: 1,
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                reverse: false,
                scrollDirection: Axis.horizontal,
                autoPlayInterval: const Duration(seconds: 3),
                height: 250,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(fontSize: 30),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildCategoriesItems(
                            categoriesModel.data!.data[index]),
                        separatorBuilder: (context, index) => const SizedBox(
                              width: 10,
                            ),
                        itemCount: categoriesModel.data!.data.length),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'New Products',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 3,
                mainAxisSpacing: 5,
                childAspectRatio: 1 / 1.628,
              ),
              itemBuilder: (context, index) =>
                  buildPrdouctsItems(model.data!.products[index], context),
              itemCount: model.data!.products.length,
            )
          ],
        ),
      );

  Widget buildCategoriesItems(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage('${model.image}'),
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: 150,
            color: Colors.black.withOpacity(0.5),
            child: Text(
              '${model.name}',
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          )
        ],
      );

  Widget buildPrdouctsItems(ProductModel model, context) => InkWell(
        onTap: () {
          navigatTo(context, ProductsDetails(model));
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.grey[200]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage('${model.image}'),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  ),
                  if (model.discount != 0)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        color: Colors.red,
                        child: const Text(
                          ' DISCOUNT ',
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ),
                    )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.name}',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text('${model.price}',
                            style: const TextStyle(
                                fontSize: 18, color: Colors.blue)),
                        const SizedBox(
                          width: 10,
                        ),
                        if (model.discount != 0)
                          Text(
                            '${model.oldPrice}',
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context).ChangeFav(model.id);
                          },
                          icon: CircleAvatar(
                            child: const Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ),
                            backgroundColor:
                                ShopCubit.get(context).favorites[model.id]
                                    ? Colors.blue
                                    : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
