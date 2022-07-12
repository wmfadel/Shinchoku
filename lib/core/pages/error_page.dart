import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shinchoku/core/constants/images.dart';
import 'package:shinchoku/router/routes_info.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double pageHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 8),
              SvgPicture.asset(
                Images.error404,
                height: pageHeight * 0.2,
                color: Theme.of(context).primaryColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => FirebaseAuth.instance.signOut(),
                    child: const Text('Logout'),
                  ),
                  const SizedBox(width: 16),
                  MaterialButton(
                    onPressed: () {
                      try {
                        /// try to pop
                        context.pop();
                      } catch (_) {
                        /// if last page in stack, or cannot navigate go to home
                        context.go(RoutesInfo.homeInitialPath);
                      }
                    },
                    height: 46,
                    minWidth: 120,
                    elevation: 1,
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    child: const Text('Back'),
                  ),
                ],
              ),
              SvgPicture.asset(
                Images.errorDog,
                height: pageHeight * 0.25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
