import 'package:e_commerce/model/categories_model.dart';
import 'package:e_commerce/modules/shop_layout/layout/cubit/shop_cubit.dart';
import 'package:e_commerce/modules/shop_layout/layout/cubit/shop_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => buildCatItem(
                ShopCubit.get(context).categoriesModel!.data!.data[index]),
            separatorBuilder: (context, index) => const Divider(),
            itemCount:
                ShopCubit.get(context).categoriesModel!.data!.data.length);
      },
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(
                '${model.image}',
              ),
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              '${model.name}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios_outlined))
          ],
        ),
      );
}
