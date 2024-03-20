import 'package:dantown_test/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/auth/auth_service.dart';
// import 'package:sliverapp_practice/pages/buy_page.dart';
// import 'package:sliverapp_practice/pages/tab_bar.dart';
// import 'package:sliverapp_practice/widgets/hidden_drawer.dart';

class PopUpMenuButtonWidget extends StatelessWidget {
  const PopUpMenuButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: PopupMenuButton<MenuItem>(
        color: Theme.of(context).colorScheme.background,
        onSelected: (value) {
          if (value == MenuItem.logout) {
            AuthService().signOut().then(
                  (value) => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const SignInScreen(),
                      ),
                      (route) => false),
                );
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(value: MenuItem.logout, child: Text("Logout")),
        ],
      ),
    );
  }
}

enum MenuItem { logout }
