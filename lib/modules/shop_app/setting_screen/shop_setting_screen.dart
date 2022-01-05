import 'package:conditional_builder/conditional_builder.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/shop_cupit/cubit.dart';
import 'package:shop_app/layout/shop_app/shop_cupit/state.dart';
import 'package:shop_app/modules/shop_app/shopp_app_login/login_screen.dart';
import 'package:shop_app/shared/components/copmponents.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()..getUserData(),

      child:BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        if(state is ShopSuccessGetProfileState)
          {
            print(state.loginModel?.data?.name);
            print(state.loginModel?.data?.phone);
            print(state.loginModel?.data?.email);

            nameController.text = state.loginModel?.data?.name as String;
            emailController.text = state.loginModel?.data?.email as String;
            phoneController.text = state.loginModel?.data?.phone as String;
          }
      },
      builder: (context, state) {
        //var model = ShopCubit.get(context).loginModel;

        nameController.text = ShopCubit.get(context).loginModel?.data?.name as String;
        emailController.text = ShopCubit.get(context).loginModel?.data?.email as String;
        phoneController.text = ShopCubit.get(context).loginModel?.data?.phone as String;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).loginModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:
                    [
                      if(state is ShopLoadingUpdateUserState)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultTextField(
                        controller: nameController,
                        type: TextInputType.name,
                       validate: (String value) {
                          if (value.isEmpty) {
                            return 'name must not be empty';
                          }

                          return null;
                        },
                        prefix: Icons.person,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                  defaultTextField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        // validate: (String value) {
                        //   if (value.isEmpty) {
                        //     return 'email must not be empty';
                        //   }
                        //
                        //   return null;
                        // },
                        prefix: Icons.email,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                  defaultTextField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        // validate: (String value) {
                        //   if (value.isEmpty) {
                        //     return 'phone must not be empty';
                        //   }
                        //   return null;
                        // },
                        prefix: Icons.phone,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultButton(
                          function:(){
                            navigateAndFinish(
                                context,
                                ShopLoginScreen(),
                            );
                          },
                          text: 'Log Out',
                        color: Colors.deepOrange,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultButton(
                          function:(){
                            if(formKey.currentState!.validate())
                            ShopCubit.get(context).updateUser(
                              name: nameController.text,
                              email: emailController.text,
                                phone: phoneController.text,
                            );
                          },
                          text: 'Update User',
                        color: Colors.deepOrange,

                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
            ),
                ),
              ),
          ),
        fallback: (context) => Center(child: CircularProgressIndicator()),
        );

      },
      ),
    );
  }
}
