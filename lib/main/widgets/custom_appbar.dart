import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool centerTitle;
  final bool showBackButton;
  final Widget? leading;
  final VoidCallback? onBack;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.centerTitle = true,
    this.leading,
    this.onBack,
     this.showBackButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 1,
      title: Text(title, style: const TextStyle(color: Colors.black)),
      centerTitle: centerTitle,
      actions: actions,
       leading: leading ??
          IconButton(
            onPressed: onBack ?? () => Navigator.of(context).pop(),
            icon: Image.asset(
              'assets/images/arrow_back.png', // your custom arrow image path
              width: 50,
              height: 60,
            ),
          ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}




class CircularImage extends StatelessWidget {
  final String imagePath;            
  final double size;                  
  final Color backgroundColor;        
  final BoxFit fit;                   

  const CircularImage({
    Key? key,
    required this.imagePath,
    this.size = 18.0,
    this.backgroundColor = Colors.yellow, 
    this.fit = BoxFit.contain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size + 16,
      height: size + 16,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Image.asset(
          imagePath,
          width: size,
          height: size,
          fit: fit,
        ),
      ),
    );
  }
}


