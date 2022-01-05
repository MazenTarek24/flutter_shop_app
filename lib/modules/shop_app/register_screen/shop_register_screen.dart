
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/shop_cupit/cubit.dart';
import 'package:shop_app/layout/shop_app/shop_cupit/state.dart';
import 'package:shop_app/modules/shop_app/shopp_app_login/login_screen.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/components/copmponents.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';

class ShopRegisterScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopState>(
        listener: (context,state) {
          if (state is ShopRegisterSuccessfulState) {
            if (state.loginModel?.status == true) {

              print(state.loginModel?.message);
              print(state.loginModel?.data?.token);

              CasheHelper.saveData
                (
                  key: 'token',
                  value: state.loginModel?.data?.token)
                  .then((value) => {

                tokens = state.loginModel?.data?.token,

                //NavigateTo(context, ShopLoginScreen()),
              });

            } else {
              print(state.loginModel?.message);
              showToast(
                message: state.loginModel?.message,
                state: ToastState.Error,
              );
            }
          }
        },
      builder: (context,state) =>
          Scaffold(
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
                          'Register',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultTextField(
                            onSubmit: (value) {
                              print(value);
                            },
                            onTap: () {},
                            // textForUnValid: 'Enter your username',
                            controller: nameController,
                            type: TextInputType.name,
                            text: 'Username',
                            prefix: Icons.person),

                        SizedBox(
                          height: 15.0,
                        ),
                    defaultTextField(
                        onSubmit: (value) {
                          print(value);
                        },
                        onTap: () {},
                        // textForUnValid: 'Enter your username',
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        text: 'Email',
                        prefix: Icons.alternate_email),

                    SizedBox(
                      height: 15.0,
                    ),
                    defaultTextField(
                        onSubmit: (value) {
                          print(value);
                        },
                        onTap: () {},
                        // textForUnValid: 'Enter your username',
                        controller: phoneController,
                        type: TextInputType.phone,
                        text: 'Phone',
                        prefix: Icons.phone),

                    SizedBox(
                      height: 15.0,
                    ),
                        defaultTextField(
                            onSubmit: (value) {
                            },
                            onTap: () {},
                            //    textForUnValid: 'Enter you password',
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            text: 'Password',
                            prefix: Icons.lock,
                            isPassword: ShopCubit.get(context).isPassword,
                            suffix: ShopCubit.get(context).suffix,
                            suffixFunction: () {
                              ShopCubit.get(context).changePasswordVisibility();
                            }),

                        SizedBox(
                          height: 30.0,
                        ),

                        state is! ShopLoadingState
                            ? defaultButton(
                          function: () {
                            print('button taped');
                            if (formKey.currentState?.validate() ==
                                true) {
                              ShopCubit.get(context).registerUser(
                                  email: emailController.text,
                                  password: passwordController.text,
                                phone: phoneController.text,
                                name: nameController.text,
                              );
                              NavigateTo(context, ShopLoginScreen());

                            } else {
                              print('else button');
                            }
                          },
                          text: 'Register',
                          color: Colors.indigo,
                        ) : Center(
                          child: CircularProgressIndicator(
                            color: Colors.indigo,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
    );
}
}