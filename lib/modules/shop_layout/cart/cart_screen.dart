import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/model/cart_model.dart';
import 'package:e_commerce/modules/shop_layout/layout/cubit/shop_cubit.dart';
import 'package:e_commerce/modules/shop_layout/layout/cubit/shop_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../../../components.dart';


class CartScreen extends StatelessWidget {
     static const routeName ='cart_screen';
  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessAddCartStates) {
          if (state.model.status!) {
            Fluttertoast.showToast(
                msg: '${state.model.message}',
                backgroundColor: Colors.green,
                fontSize: 15);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: ConditionalBuilder(
            condition: cubit.cartModel != null,
            builder: (context) => Column(
              children: [
                if (state is ShopLoadingUpdateCartStates)
                  LinearProgressIndicator(
                    backgroundColor: Colors.grey[300],
                  ),
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => cartItem(
                     cubit.cartModel!.data!.cartItems[index],
                      context,
                    ),
                    separatorBuilder: (context, index) => Container(
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.grey[300],
                    ),
                    itemCount:cubit.cartModel!.data!.cartItems.length,
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.grey[100],
                  padding: const EdgeInsets.all(
                    10.0,
                  ),
                  child: Column(
                    children: [
                      Text(
                        ' total : ${ cubit.cartModel!.data!.total!.round()} ',
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  Widget cartItem(
    CartItems model,
    context,
  ) =>
      Card(
        elevation: 5,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 120.0,
                child: Row(
                  children: [
                    Container(
                      height: 120.0,
                      width: 130.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          2.0,
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                            '${model.product!.image}',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (model.product!.discount != 0)
                            const Padding(
                              padding: EdgeInsetsDirectional.only(
                                bottom: 10.0,
                              ),
                            ),
                          Text(
                            model.product!.name.toString(),
                            maxLines: 2,
                            style: const TextStyle(
                              // height: 1.4,
                              fontSize: 20
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Spacer(),
                          Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '${model.product!.price!.round()}',
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.blue),
                                            ),
                                            const SizedBox(
                                              width: 5.0,
                                            ),
                                          ],
                                        ),
                                        if (model.product!.discount != 0)
                                          Row(
                                            children: [
                                              Text(
                                                '${model.product!.oldPrice!.round()}',
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  decoration:
                                                      TextDecoration.lineThrough,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 5.0,
                                                ),
                                                child: Container(
                                                  width: 1.0,
                                                  height: 10.0,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Text(
                                                '${model.product!.discount}%',
                                                style: const TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                          ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          ShopCubit.get(context).upDateCart(
                                            model.id!.toInt(),
                                            model.quantity--,
                                          );
                                        },
                                        icon: const CircleAvatar(
                                          child: Icon(
                                            Icons.remove,
                                            size: 14.0,
                                          ),
                                          radius: 15.0,
                                        ),
                                      ),
                                      Text(
                                        '${model.quantity}',
                                        style: const TextStyle(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          ShopCubit.get(context).upDateCart(
                                            model.id!.toInt(),
                                            model.quantity++,
                                          );
                                          // ShopCubit.get(context).AddToCart(model.id!.toInt());
                                        },
                                        icon: const CircleAvatar(
                                          child: Icon(
                                            Icons.add,
                                            size: 14.0,
                                          ),
                                          radius: 15.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),

              ),
            ),

            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                    onPressed: () {
                      ShopCubit.get(context).addOrdelete(model.product!.id!.toInt());

                    },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,


                    children: const [
                      Icon(Icons.delete_outline,color: Colors.grey,size: 25,),
                      SizedBox(width: 5,),
                      Text('remove',style: TextStyle(fontSize: 20,color: Colors.grey),)
                    ],
                  ),
                   ),

              ],
            )
          ],
        ),
      );
}
