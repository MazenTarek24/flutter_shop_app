

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/shop_app.dart';
import 'package:shop_app/modules/shop_app/register_screen/shop_register_screen.dart';
import 'package:shop_app/modules/shop_app/shopp_app_login/state/state.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/components/copmponents.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';

import 'cubit/cubit.dart';

class ShopLoginScreen extends StatelessWidget {

   var formKey = GlobalKey<FormState>();

  var email = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer< ShopLoginCubit, ShopLoginState>(
        listener: (context, state) {
          if (state is ShopLoginSuccessfulState) {
            if (state.loginModel.status == true) {

              print(state.loginModel.message);
              print(state.loginModel.data?.token);

              CasheHelper.saveData
                (
                  key: 'token',
                  value: state.loginModel.data?.token)
                  .then((value) => {

                tokens = state.loginModel.data?.token,

                NavigateTo(context, ShopLayout()),
              });

            } else {
              print(state.loginModel.message);

              showToast(
                  message: state.loginModel.message!,
                  state: ToastState.Error,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              // actions: [
              //   defaultTextButton(
              //       function: (){
              //         NavigateTo(
              //             context,
              //             ShopLayout()
              //         );
              //       },
              //       text: 'skip',
              //   )
              // ],
            ),
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
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Login now to browse our hot offers',
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
                            controller: email,
                            type: TextInputType.emailAddress,
                            text: 'Username',
                            prefix: Icons.alternate_email),

                        SizedBox(
                          height: 15.0,
                        ),
                    defaultTextField(
                        onSubmit: (value) {
                          if (formKey.currentState?.validate() == true) {
                            ShopLoginCubit.get(context).userLogin(
                                email: email.text,
                                password: password.text);
                          }
                        },
                        onTap: () {},
                    //    textForUnValid: 'Enter you password',
                        controller: password,
                        type: TextInputType.visiblePassword,
                        text: 'Password',
                        prefix: Icons.lock,
                        isPassword: ShopLoginCubit.get(context).isPassword,
                        suffix: ShopLoginCubit.get(context).suffix,
                        suffixFunction: () {
                          ShopLoginCubit.get(context).changePasswordVisibility();
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
                              ShopLoginCubit.get(context).userLogin(
                                  email: email.text,
                                  password: password.text);
                             } else {
                              print('else button');
                             }
                          },
                          text: 'Login',
                          color: Colors.indigo,
                        )
                            : Center(
                          child: CircularProgressIndicator(
                            color: Colors.indigo,
                          ),
                        ),

                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                            ),
                            TextButton(
                              onPressed: () {
                                   NavigateTo(context, ShopRegisterScreen());
                              },
                              child: Text(
                                  'Register Now'
                              ),

                            ),

                          ],
                        ),
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
