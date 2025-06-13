import 'package:do_it_fixed_fixed/app-themes/MarkTextStyle.dart';
import 'package:do_it_fixed_fixed/app-themes/textStyle.dart';
import 'package:do_it_fixed_fixed/app-themes/theme.dart';
import 'package:do_it_fixed_fixed/main/bloc/auth/auth_bloc.dart';
import 'package:do_it_fixed_fixed/main/bloc/auth/auth_event.dart';
import 'package:do_it_fixed_fixed/main/bloc/auth/auth_state.dart';
import 'package:do_it_fixed_fixed/main/widgets/button.dart';
import 'package:do_it_fixed_fixed/main/widgets/custom_appbar.dart';
import 'package:do_it_fixed_fixed/main/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  void _onRegisterPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            RegisterRequested(
              email: _emailController.text,
              password: _passwordController.text,
              name: _nameController.text,
              mobile: _phoneController.text
            ),
          );
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
              SnackBar(content: Text('Registration Successful')),
            );
            Navigator.pushReplacementNamed(context, '/login');
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Create\nAccount',
                      style: SfProAppTextStyles.heading26Bold.copyWith(
                        color: AppTheme.black
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .03,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        text: 'Please fill the details below to\ncreate a ',
                        style: MarkTextStyles.bodyRegular16.copyWith(
                          color: AppTheme.black,
                          
                        ),
                        children: [
                          TextSpan(
                            text: 'DO_IT',
                            style: MarkTextStyles.bodyRegular16.copyWith(
                              color: AppTheme.primaryColor
                            )
                          ),
                          TextSpan(
                            text: ' account',
                            style:  MarkTextStyles.bodyRegular16.copyWith(
                          color: AppTheme.black
                        ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .03,
                  ),
                  BorderedCustomInputField(
                    controller: _nameController, 
                    label: 'Name', 
                    hint: 'Enter name', 
                    isMultiline: false,
                    obscureText: false,
                    validator: (value) => value!.isEmpty ? 'Enter name' : null,
                  ),
                  SizedBox(
                    height: size.height * .03,
                  ),
                  BorderedCustomInputField(
                    controller: _emailController, 
                    label: 'Email', 
                    hint: 'Enter email', 
                    isMultiline: false,
                    obscureText: false,
                    validator: (value) => value!.isEmpty ? 'Enter email' : null,
                  ),
                  SizedBox(
                    height: size.height * .03,
                  ),
                  BorderedCustomInputField(
                    controller: _phoneController, 
                    label: 'Mobile', 
                    hint: 'Enter phone number', 
                    isMultiline: false,
                    obscureText: false,
                    validator: (value) => value!.isEmpty ? 'Enter phone number' : null,
                  ),
                  SizedBox(
                    height: size.height * .03,
                  ),
                  BorderedCustomInputField(
                    controller: _passwordController,
                    label: 'Password',
                    obscureText: true,
                    isMultiline: false,
                    validator: (value) => value!.isEmpty ? 'Enter password' : null, 
                    hint: '*********',
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Password must be atleast 8 characters',
                      style: MarkTextStyles.bodyLight14.copyWith(
                        color: AppTheme.grey
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .03,
                  ),
                  state is AuthLoading
                      ? const CircularProgressIndicator()
                      : 
                        CustomButton(
                label: 'Register', 
                onPressed: _onRegisterPressed, 
                text: 'Register',
              ),
              SizedBox(
                    height: size.height * .02,
                  ),
              Text(
                'Privacy Policy',
                style: MarkTextStyles.bodyBold14.copyWith(
                  color: AppTheme.grey,
                  
                ),
              )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
