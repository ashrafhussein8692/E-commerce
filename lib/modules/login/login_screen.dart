import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/modules/register/register_screen.dart';
import 'package:e_commerce/modules/shop_layout/layout/shop_layout.dart';
import 'package:e_commerce/network/shared_preference.dart';
import 'package:e_commerce/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components.dart';
import 'cubit/login_cubit.dart';
import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessStates) {
            if (state.userModel.status = true) {
              CacheHelper.saveData(
                  key: 'token', value: state.userModel.data!.token)
                  .then((value) {
                token = state.userModel.data!.token!;
                navigatTo(context, ShopLayOut());
              });
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Login now to our hot offers',
                          style: TextStyle(fontSize: 25, color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value.isEmpty) {
                                return ' Email Address is required';
                              } else {
                                return null;
                              }
                            },
                            label: 'Email Address',
                            prefix: Icons.email),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Password Address is required';
                              } else {
                                return null;
                              }
                            },
                            onSubmit: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            isPassword: true,
                            label: 'Password',
                            prefix: Icons.lock_outlined,
                            suffix: Icons.visibility),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition:  state  !=LoginLoadingStates(),
                          builder: (context) =>
                              defaultButton(
                                  text: 'login',
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      LoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  }),
                          fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),

                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(fontSize: 15),
                            ),
                            defaultTextButton(
                                function: () {
                                  navigatTo(context, const RegisterScreen());
                                },
                                text: 'register')
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
