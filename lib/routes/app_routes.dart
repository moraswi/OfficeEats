import 'package:flutter/material.dart';

// public
import 'package:eats/components/public/forgot_password.dart';
import 'package:eats/components/public/landing_page.dart';
import 'package:eats/components/public/logIn.dart';
import 'package:eats/components/public/reset_password.dart';
import 'package:eats/components/public/sign_up.dart';
import 'package:eats/components/public/splash_screen.dart';

// private
import 'package:eats/components/private/home/stores/store_screen.dart';
import 'package:eats/components/private/home/menu/menu_screen.dart';
import 'package:eats/components/private/home/cart_and_review/cart_screen.dart';
import 'package:eats/components/private/history/history_screen.dart';
import 'package:eats/components/private/history/track_order.dart';
import 'package:eats/components/private/home/offices/offices.dart';
import 'package:eats/components/private/home/cart_and_review/order_review.dart';
import 'package:eats/components/private/profile/profile_screen.dart';
import 'package:eats/components/private/feedback/feedback.dart';
import 'package:eats/components/private/feedback/feedback_confirmed.dart';

Map<String, WidgetBuilder> getRoutes() {
  return {
    // public
    '/': (context) => ContainSelector(),
    LogIn().routeName: (context) => LogIn(),
    SignUp().routeName: (context) => SignUp(),
    LandingPage().routeName: (context) => LandingPage(),
    ForgotPassword().routeName: (context) => ForgotPassword(),
    ResetPassword().routeName: (context) => ResetPassword(),

    // private
    HomeScreen().routeName: (context) => HomeScreen(),
    MenuPage().routeName: (context) => MenuPage(),
    CartPage().routeName: (context) => CartPage(),
    HistoryPage().routeName: (context) => HistoryPage(),
    TrackOrderPage().routeName: (context) => TrackOrderPage(),
    OfficePage().routeName: (context) => OfficePage(),
    OrderReviewPage().routeName: (context) => OrderReviewPage(),
    ProfileLandingPage().routeName: (context) => ProfileLandingPage(),
    FeedBack().routeName: (context) => FeedBack(),
    FeedBackConfirmed().routeName: (context) => FeedBackConfirmed(),


  };
}

class ContainSelector extends StatefulWidget {
  const ContainSelector({Key? key}) : super(key: key);

  @override
  _ContainSelectorState createState() => _ContainSelectorState();
}

class _ContainSelectorState extends State<ContainSelector> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}
