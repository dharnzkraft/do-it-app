import 'package:do_it_fixed_fixed/app-themes/MarkTextStyle.dart';
import 'package:do_it_fixed_fixed/app-themes/theme.dart';
import 'package:do_it_fixed_fixed/main/bloc/auth/auth_bloc.dart';
import 'package:do_it_fixed_fixed/main/bloc/auth/auth_event.dart';
import 'package:do_it_fixed_fixed/main/bloc/auth/auth_state.dart';
import 'package:do_it_fixed_fixed/main/widgets/button.dart';
import 'package:do_it_fixed_fixed/main/widgets/custom_appbar.dart';
import 'package:do_it_fixed_fixed/main/widgets/input_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


 
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _onLoginPressed() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      context.read<AuthBloc>().add(LoginRequested(email: email, password: password));
    }
  }

  @override
  Widget build(BuildContext context) {
     final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(title: '',),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              
              SnackBar(content: Text('Welcome Back!')),
            );
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * .1,
                  ),
                   Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: size.width * .15,
                    height: 100,
                  ),
                  Text(
                    'DO',
                    style: MarkTextStyles.headingBold32.copyWith(
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '-IT',
                        style: MarkTextStyles.headingBold32.copyWith(
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Container(
                        width: 40,
                        height: 3,
                        color: AppTheme.primaryColor,
                      ),
                    ],
                  ),
                ],
              ),
              
              Text(
                'Welcome Back!',
                style: MarkTextStyles.headingSemiBold24,
              ),
              SizedBox(height: size.height * .05),
                  BorderedCustomInputField(
                    controller: _emailController,
                    validator: (value) => value!.isEmpty ? "Enter your email" : null, 
                    label: 'Email', hint: 'Enter email', 
                    isMultiline: true, obscureText: false,
                  ),
                  SizedBox(height: size.height * .02),
                  BorderedCustomInputField(
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) => value!.isEmpty ? "Enter your password" : null, 
                    label: 'Password', 
                    hint: '******', isMultiline: false,
                  ),
                  SizedBox(height: size.height * .02),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: state is AuthLoading
                      ? const CircularProgressIndicator()
                      : CustomButton(
                          onPressed: _onLoginPressed,
                          label: 'Sign in',
                          text: 'Sign in',
                        ),),
                        SizedBox(
                          width: size.width * .02,
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: (){
                              context.read<AuthBloc>().add(BiometricLoginRequested());
                            },
                            child: Image.asset(
                              'assets/images/biometric.png',
                                                    width: size.width * .7,
                            ),
                          ))
                    ],
                  ),
                  const SizedBox(height: 10),
                  
                  
                  RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account? ',
                        style: MarkTextStyles.bodyRegular16.copyWith(
                          color: AppTheme.black,
                          
                        ),
                        children: [
                          TextSpan(
                            text: 'Create Account',
                            style: MarkTextStyles.bodyRegular16.copyWith(
                              color: AppTheme.primaryColor
                            ),
                            recognizer: TapGestureRecognizer()
                            ..onTap = () {
                               Navigator.pushNamed(context, '/register');
                            },
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
