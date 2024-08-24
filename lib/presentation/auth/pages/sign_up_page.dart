import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_clone/common/helpers/check_theme_mode.dart';
import 'package:spotify_clone/common/helpers/show_snack_bar.dart';
import 'package:spotify_clone/common/widgets/app_bar/basic_app_bar.dart';
import 'package:spotify_clone/common/widgets/button/basic_app_button.dart';
import 'package:spotify_clone/common/widgets/loading.dart';
import 'package:spotify_clone/core/configs/assets/app_vectors.dart';
import 'package:spotify_clone/core/configs/theme/app_colors.dart';
import 'package:spotify_clone/presentation/auth/bloc/auth_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController _fullNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();

    _initAllControllers();
  }

  @override
  void dispose() {
    _disposeAllControllers();
    super.dispose();
  }

  void _initAllControllers() {
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  void _disposeAllControllers() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void _signUpButtonOnPressed() {
    if (formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            AuthSignUp(
              fullName: _fullNameController.text.trim(),
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            ),
          );
    }
  }

  void _navigateToSignInPage() =>
      Navigator.pushReplacementNamed(context, '/sign_in_page');

  void _navigateToHomePage() =>
      Navigator.pushReplacementNamed(context, '/home_page');

  void _unFocusTextFormField() => FocusScope.of(context).unfocus();

  @override
  Widget build(BuildContext context) {
    final phonePadding = MediaQuery.of(context).padding;

    return GestureDetector(
      onTap: _unFocusTextFormField,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: BasicAppBar(
          title: SvgPicture.asset(
            AppVectors.spotifyLogo,
            width: 40,
            height: 40,
          ),
        ),
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(context, state.message);
            } else if (state is AuthSignUpSuccess) {
              _navigateToHomePage();
            }
          },
          builder: (_, state) {
            if (state is AuthLoading) {
              return const Loading();
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  /// #register text
                  const Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 50),

                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        /// #full name text field
                        TextField(
                          controller: _fullNameController,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            hintText: 'Full Name',
                          ).applyDefaults(
                            Theme.of(context).inputDecorationTheme,
                          ),
                        ),
                        const SizedBox(height: 20),

                        /// #email text field
                        TextField(
                          controller: _emailController,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            hintText: 'Enter Email',
                          ).applyDefaults(
                            Theme.of(context).inputDecorationTheme,
                          ),
                        ),
                        const SizedBox(height: 20),

                        /// #password text field
                        TextField(
                          controller: _passwordController,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            hintText: 'Password',
                          ).applyDefaults(
                            Theme.of(context).inputDecorationTheme,
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),

                  /// #sign up button
                  BasicAppButton(
                    onPressed: _signUpButtonOnPressed,
                    text: 'Create Account',
                    textFontWeight: FontWeight.bold,
                  ),
                  const Spacer(),

                  /// #
                  Padding(
                    padding: EdgeInsets.all(
                      phonePadding.bottom > 0 ? phonePadding.bottom : 30,
                    ),
                    child: RichText(
                      text: TextSpan(
                        text: 'Do You Have An Account? ',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: context.isDarkMode
                              ? FontWeight.bold
                              : FontWeight.w500,
                          color: context.isDarkMode
                              ? AppColors.ffdbdbdb
                              : AppColors.ff383838,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            recognizer: TapGestureRecognizer()
                              ..onTap = _navigateToSignInPage,
                            style: const TextStyle(color: AppColors.ff288CE9),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
