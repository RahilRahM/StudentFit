import '../../../commons/colors.dart';
import 'package:flutter/material.dart';
import '../../welcomePages/widgets/app_text_styles.dart';


class CustomAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitle;
  final bool showFavoriteIcon;
  final VoidCallback? onFavoritePressed;
  final IconData? leadingIcon; // Nullable leading icon
  final VoidCallback? onLeadingPressed; // Nullable callback for leading icon
  final List<Widget> actions; // List of action widgets

  const CustomAppBar2({
    Key? key,
    required this.appBarTitle,
    this.showFavoriteIcon = false,
    this.onFavoritePressed,
    this.leadingIcon,
    this.onLeadingPressed,
    required this.actions, // Accept a list of widgets
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 5.0);

  @override
  Widget build(BuildContext context) {
    final double appBarHeight = kToolbarHeight + 5.0;
    final double iconSize = 30.0;
    final double marginSize = 18.0;

    List<Widget> appBarActions = [];

    if (showFavoriteIcon && onFavoritePressed != null) {
      appBarActions.add(
        Padding(
          padding: EdgeInsets.only(right: marginSize),
          child: IconButton(
            onPressed: onFavoritePressed,
            icon: Stack(
              children: [
                Icon(
                  Icons.favorite_border,
                  color: Colors.black,
                  size: iconSize - 6,
                ),
              ],
            ),
          ),
        ),
      );
    }

    appBarActions.addAll(actions); // Add the provided actions to the list
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: Icon(
              leadingIcon ?? Icons.menu,
              color: AppColors.blackColor,
              size: iconSize,
            ),
            onPressed:
                onLeadingPressed ?? () => Scaffold.of(context).openDrawer(),
          );
        },
      ),
      title: SizedBox(
        width: MediaQuery.of(context).size.width - marginSize * 2,
        height: appBarHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              appBarTitle,
              style: AppTextStyles.alreadyMember.copyWith(
                fontSize: 24,
                color: AppColors.blackColor,
              ),
            ),
          ],
        ),
      ),
      actions: appBarActions,
    );
    
  }
}
