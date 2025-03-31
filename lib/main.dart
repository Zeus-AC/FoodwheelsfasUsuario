import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pn_fl_foody_user/screens/screens.dart';
import 'package:pn_fl_foody_user/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{

 WidgetsFlutterBinding.ensureInitialized(); // Asegura la inicialización correcta de Flutter antes de Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

//raíz de la aplicación
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: primaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FoodWheelsFast Usuario',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: primaryColor,
            primary: primaryColor,
          ),
          primaryColor: primaryColor,
          useMaterial3: true,
          fontFamily: 'Mulish',
          scaffoldBackgroundColor: whiteColor,
          appBarTheme: const AppBarTheme(
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            shadowColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: primaryColor,
              statusBarIconBrightness: Brightness.light,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            prefixIconColor: WidgetStateColor.resolveWith(
              (states) => states.contains(WidgetState.focused)
                  ? primaryColor
                  : greyColor,
            ),
          ),
        ),
        home: const SplashScreen(),
        onGenerateRoute: route,
      ),
    );
  }

  Route<dynamic>? route(settings) {
    switch (settings.name) {
      case '/':
        return PageTransition(
          child: const SplashScreen(),
          type: PageTransitionType.fade,
          settings: settings,
        );
      case '/onboarding':
        return PageTransition(
          child: const OnboardingScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/signin':
        return PageTransition(
          child: const SignInScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/signup':
        return PageTransition(
          child: const SignUpScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/bottomBar':
        return PageTransition(
          child: const BottomBar(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/home':
        return PageTransition(
          child: const HomeScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/notification':
        return PageTransition(
          child: const NotificationScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/search':
        return PageTransition(
          child: const SearchScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/foodDetail':
        return PageTransition(
          child: const FoodDetailScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/restaurantDetail':
        return PageTransition(
          child: const RestaurantDetailScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/categoryWiseFood':
        return PageTransition(
          child: const CategoryFoodScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/reviews':
        return PageTransition(
          child: const ReviewsScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/cart':
        return PageTransition(
          child: const CartScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/nearestRestaurant':
        return PageTransition(
          child: const NearestRestaurantScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/restuarantFood':
        return PageTransition(
          child: const RestaurantFoodScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/orders':
        return PageTransition(
          child: const OrdersScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/orderDetail':
        return PageTransition(
          child: const OrderDetailScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/trackOrder':
        return PageTransition(
          child: const TrackOrderScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/chat':
        return PageTransition(
          child: const ChatScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/rating':
        return PageTransition(
          child: const RatingScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/favourite':
        return PageTransition(
          child: const FavouriteScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/selectDeliveryAddress':
        return PageTransition(
          child: const SelectDeliveryAddressScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/addNewAddress':
        return PageTransition(
          child: const AddNewAddressScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/paymentMethod':
        return PageTransition(
          child: const PaymentMethodScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/creditcard':
        return PageTransition(
          child: const CreditCardScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/success':
        return PageTransition(
          child: const SuccessScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/profile':
        return PageTransition(
          child: const ProfileScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/editProfile':
        return PageTransition(
          child: const EditProfileScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/address':
        return PageTransition(
          child: const AddressScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/settings':
        return PageTransition(
          child: const SettingsScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/termsAndCondition':
        return PageTransition(
          child: const TermsAndConditionScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/privacyPolicy':
        return PageTransition(
          child: const PrivacyPolicyScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/helpAndSupport':
        return PageTransition(
          child: const HelpAndSupportScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      default:
        return null;
    }
  }
}
