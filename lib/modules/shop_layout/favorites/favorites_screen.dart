import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/model/favorites_model.dart';
import 'package:e_commerce/modules/shop_layout/layout/cubit/shop_cubit.dart';
import 'package:e_commerce/modules/shop_layout/layout/cubit/shop_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: state is! ShopLoadingChangeFavoritesStates,
            builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildFavItem(
                    ShopCubit.get(context).favoritesModel!.data!.data[index],
                    context),
                separatorBuilder: (context, index) => const Divider(),
                itemCount:
                    ShopCubit.get(context).favoritesModel!.data!.data.length),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget buildFavItem(FavoritesData model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 150,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage('${model.product!.image}'),
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  if (model.product!.discount != 0)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      color: Colors.red,
                      child: const Text(
                        'DISCOUNT',
                        style: TextStyle(fontSize: 8, color: Colors.white),
                      ),
                    )
                ],
              ),
              const SizedBox(
                width: 25,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.product!.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model.product!.price}',
                          style:
                              const TextStyle(fontSize: 18, color: Colors.blue),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (model.product!.discount != 0)
                          Text(
                            '${model.product!.oldPrice}',
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context).ChangeFav(model.product!.id);
                            // print(model.id);
                          },
                          icon: CircleAvatar(
                              child: const Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              ),
                              backgroundColor: ShopCubit.get(context)
                                      .favorites[model.product!.id]
                                  ? Colors.blue
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
