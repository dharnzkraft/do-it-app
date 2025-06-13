import 'package:do_it_fixed_fixed/app-themes/MarkTextStyle.dart';
import 'package:do_it_fixed_fixed/app-themes/theme.dart';
import 'package:do_it_fixed_fixed/main/widgets/button.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
   
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: size.width * .15,
                    height: 200,
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
              Center(
                child: SizedBox(
                  width: size.width * 1,
                  height: size.height * .45,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/exploregb.png',
                        width: size.width * .7,
                      ),
          
                      Positioned(
                        top: 3,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: Image.asset('assets/images/explore1.png', width: 80),
                        ),
                      ),
          
                      Positioned(
                        top: 60,
                        left: 10,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: Image.asset('assets/images/explore2.png', width: 80),
                        ),
                      ),
          
                      Positioned(
                        top: 60,
                        right: 10,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: Image.asset(
                            'assets/images/explore3.png',
                            width: 80,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Just',
                    style: MarkTextStyles.headingSemiBold24.copyWith(
                      color: AppTheme.black
                    ),
                  ),
                  SizedBox(
                    width: size.width * .02,
                  ),
                  Text(
                    'DO-IT',
                    style: MarkTextStyles.headingSemiBold24.copyWith(
                      color: AppTheme.primaryColor
                    ),
                  )
                ],
              ),
              SizedBox(
                height: size.height * .01,
              ),
              CustomButton(
                label: 'Create Account', 
                onPressed: () { 
                  Navigator.pushNamed(context, '/register');
                 }, 
                text: 'Create Account',
              ),
              SizedBox(
                height: size.height * .005,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account ?',
                    style: MarkTextStyles.bodyLight14.copyWith(
                      color: AppTheme.grey
                    ),
                  ),
                  SizedBox(
                    width: size.width * .02,
                  ),
                  TextButton(
                     onPressed: () { 
                      Navigator.pushNamed(context, '/login');
                      }, 
                    child: Text(
                      'Sign in',
                        style: MarkTextStyles.bodyLight14.copyWith(
                          color: AppTheme.primaryColor
                        ),
                    ),
                  )
                ],
              ),
            ],
          ),

        ),
      ),
    );
  }
}
