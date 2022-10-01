import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_steps_tracker/features/auth/presentation/pages/register_screen.dart';
import '../../../../core/localization/get_os.dart';
import '../../../../core/localization/get_translate.dart';
import '../../../../core/routing/navigate_and_finish.dart';
import '../../../../core/routing/navigate_to.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/widgets/adaptive/adaptive_button.dart';
import '../../../../core/widgets/adaptive/adaptive_indicator.dart';
import '../../../../core/widgets/adaptive/adaptive_text_field.dart';
import '../../../../core/widgets/show_toast.dart';
import '../../../steps_tracker/presentation/cubit/steps_tracker_cubit.dart';
import '../../../steps_tracker/presentation/pages/home_page.dart';
import '../cubit/user_cubit.dart';
import '../../../../core/injection_container.dart' as di;

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => di.sl<UserCubit>(),
      child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is LogInErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.error,
            );
          }
          if (state is LogInSuccessState) {
            StepsTrackerCubit.get(context).getUser();
            navigateAndFinish(context, const HomePage());
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: state is LogInSuccessState
                ? Center(
                    child: AdaptiveIndicator(
                    os: getOs(),
                  ))
                : Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 50),
                               SizedBox(
                                height: MediaQuery.of(context).size.height*0.5,
                                child: const Image(
                                  image: NetworkImage(
                                      'https://img.freepik.com/free-vector/sign-page-abstract-concept-illustration_335657-3875.jpg?t=st=1645145165~exp=1645145765~hmac=dd14710b06ae123c5b44548e67ac2010039152565d0f5fbad0b036c23726ddf0&w=740'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                color: Colors.white,
                                child: AdaptiveTextField(
                                  os: getOs(),
                                  label: getTranslated(
                                      context, 'Add_user_label_name'),
                                  controller: nameController,
                                  type: TextInputType.emailAddress,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return getTranslated(context,
                                          'Add_user_validate_name');
                                    }
                                  },
                                  prefix: Icons.email,
                                  textInputAction: TextInputAction.next,
                                  inputBorder: const UnderlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 20),
                              (state is! LogInLoadingState)
                                  ? AdaptiveButton(
                                      os: getOs(),
                                      background: Colors.black87,
                                      function: () {
                                        if (formKey.currentState!.validate()) {
                                          UserCubit.get(context).logInCubit(
                                            name: nameController.text,
                                          );
                                        }
                                      },
                                      text: getTranslated(
                                          context, 'LogIn_button_text'),
                                      isUpperCase: true,
                                      radius: 20,
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator()),
                              const SizedBox(height: 23),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    getTranslated(
                                        context, 'LogIn_text_register'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Colors.grey,
                                        ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      navigateTo(context, RegisterScreen());
                                    },
                                    child: Text(
                                      getTranslated(context,
                                          'LogIn_text_button_register'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: Colors.blue,
                                          ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
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
