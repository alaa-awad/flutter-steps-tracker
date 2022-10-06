import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/presentation/cubit/steps_tracker_cubit.dart';
import '../../../../core/localization/get_os.dart';
import '../../../../core/localization/get_translate.dart';
import '../../../../core/routing/navigate_and_finish.dart';
import '../../../../core/widgets/adaptive/adaptive_button.dart';
import '../../../../core/widgets/adaptive/adaptive_indicator.dart';
import '../../../../core/widgets/adaptive/adaptive_text_field.dart';
import '../../../../core/widgets/show_toast.dart';
import '../../../steps_tracker/presentation/pages/home_page.dart';
import '../cubit/user_cubit.dart';
import '../../../../core/injection_container.dart' as di;

class RegisterScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => di.sl<UserCubit>(),
      child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is SignUpErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.error,
            );
          }
          if (state is SignUpSuccessState) {
            StepsTrackerCubit.get(context).getUser();
            navigateAndFinish(context, const HomePage());
          }
        },
        builder: (context, state) {
          UserCubit userCubit = UserCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
            ),
            body: state is SignUpLoadingState
                ? Center(
                    child: AdaptiveIndicator(
                    os: getOs(),
                  ))
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: const Image(
                                image: NetworkImage(
                                    'https://img.freepik.com/free-vector/sign-page-abstract-concept-illustration_335657-3875.jpg?t=st=1645145165~exp=1645145765~hmac=dd14710b06ae123c5b44548e67ac2010039152565d0f5fbad0b036c23726ddf0&w=740'),
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            AdaptiveTextField(
                              os: getOs(),
                              label:
                                  getTranslated(context, 'Add_user_label_name'),
                              controller: nameController,
                              type: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return getTranslated(
                                      context, 'Add_user_validate_name');
                                }
                              },
                              prefix: Icons.person,
                              inputBorder: const UnderlineInputBorder(),
                              boxDecoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black87,
                                  width: 1,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            state is! SignUpLoadingState ||
                                    state is SignUpErrorState
                                ? AdaptiveButton(
                                    radius: 20,
                                    function: () {
                                      if (formKey.currentState!.validate()) {
                                        userCubit.signUpCubit(
                                          name: nameController.text,
                                        );
                                      }
                                    },
                                    text: getTranslated(
                                        context, 'Add_user_text_button'),
                                    isUpperCase: true,
                                    background: Colors.black87,
                                    os: getOs(),
                                  )
                                : const Center(
                                    child: CircularProgressIndicator()),
                            const SizedBox(height: 23),
                          ],
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
