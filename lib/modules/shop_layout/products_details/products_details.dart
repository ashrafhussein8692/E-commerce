
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/model/home_model.dart';
import 'package:e_commerce/modules/shop_layout/cart/cart_screen.dart';
import 'package:e_commerce/modules/shop_layout/layout/cubit/shop_cubit.dart';
import 'package:e_commerce/modules/shop_layout/layout/cubit/shop_states.dart';
import 'package:e_commerce/modules/shop_layout/layout/shop_layout.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../components.dart';

class ProductsDetails extends StatelessWidget {
  static const routeName = 'products_details';

  ProductModel model;

  ProductsDetails(this.model);

  var pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          if(state is ShopSuccessCartStates){
            showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                context: context,
                builder: (context) {
                  return SizedBox(
                      height: 150,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.green[800],
                                      child: const Icon(
                                        Icons.check_rounded,
                                        size: 35,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            model.name.toString(),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                            overflow:
                                            TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          Text(
                                            'In Cart',
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.grey[600]),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Column(
                                      children: [
                                        Text(
                                          'Total Cart',
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.grey[600]),
                                        ),
                                        Text(
                                          '${cubit.totalAmont}',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 160,
                                        height: 45,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(8),
                                            color: Colors.white,
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Colors.blue,
                                                  spreadRadius: 1)
                                            ]),
                                        child: Center(
                                          child: InkWell(
                                            child: const Center(
                                              child: Text(
                                                'Continue Shopping',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.blue),
                                              ),
                                            ),
                                            onTap: () {
                                              // Navigator.pop(context);

                                              navigatAndFinish(context,ShopLayOut() );


                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        width: 170,
                                        height: 45,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(8),
                                            color: Colors.blue),
                                        child: Center(
                                          child: InkWell(
                                            child: const Text(
                                              'Check Out',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white),
                                            ),
                                            onTap: () {

                                              // Navigator.pop(context);
                                              Navigator.pop(context);
                                              navigatAndFinish(context,ShopLayOut() );
                                              ShopCubit.get(context).ChangeNav(3);

                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ));
                });
          }
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: ConditionalBuilder(
                condition: cubit.homeModel != null,
                builder: (context) => buildProductData(context),
                fallback: (context) =>
                    const Center(child: CircularProgressIndicator()),
              ),


              bottomNavigationBar: ConditionalBuilder(
                condition: state is !ShopLoadingCartStates ,
                builder: (context)=> MaterialButton(
                  child: const Text(
                    'Add To Cart',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  onPressed: () {
                    cubit.addOrdelete(model.id!.toInt());


                  },
                  clipBehavior: Clip.hardEdge,
                  color: Colors.blue,
                  height: 50,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                  ),
                ),
                fallback:(context)=> Center(child: CircularProgressIndicator()) ,

              ));
        });
  }

  Widget buildProductData(context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name!.toString(),
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    child: PageView.builder(
                      itemBuilder: (context, index) => Image(
                        image: NetworkImage(model.images[index]),
                        // fit: BoxFit.cover,
                      ),
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: model.images.length,
                      controller: pageController,
                    ),
                  ),
                  if (model.discount != 0)
                    Container(
                        color: Colors.red,
                        child: const Text(
                          'DISCOUNT',
                          style: TextStyle(color: Colors.white),
                        )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                  child: SmoothPageIndicator(
                      effect: WormEffect(
                          dotColor: Colors.grey.shade300,
                          activeDotColor: Colors.grey),
                      controller: pageController,
                      count: model.images.length)),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    '${model.price}',
                    style: const TextStyle(fontSize: 25, color: Colors.blue),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  if (model.discount != 0)
                    Text(
                      '${model.oldPrice}',
                      style: const TextStyle(
                          fontSize: 25,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                  Spacer(),
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
              ExpandableText(
                model.description.toString(),
                expandText: 'show more',
                collapseText: 'show less',
                maxLines: 3,
                linkColor: Colors.blue,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      );
}
