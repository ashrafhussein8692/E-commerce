import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'cubit/shop_cubit.dart';
import 'cubit/shop_states.dart';

class ShopLayOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Salla',
                style: TextStyle(fontSize: 30, color: Colors.black)),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ))
            ],
          ),
          body: cubit.BottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 20.0,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.grey,
            iconSize: 27,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.ChangeNav(index);
            },
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.category_rounded),
                label: 'Categories',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(
                          Icons.shopping_cart,
                        )
                      ],
                    ),
                    if (state is! ShopLoadingHomeDataStates &&
                        cubit.cartProductsNumber != 0)
                      CircleAvatar(
                        child: Text(
                          ShopCubit.get(context).cartProductsNumber.toString(),
                          style: const TextStyle(
                              fontSize: 16, color: Colors.orange, height: 0),
                        ),
                        maxRadius: 0,
                      ),
                  ],
                ),
                label: 'Cart',
              ),
            ],
          ),
        );
      },
    );
  }
}
