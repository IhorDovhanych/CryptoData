import 'package:auto_route/auto_route.dart';
import 'package:crypto_data/application/presentation/features/main/features/detail/page/detail_page.dart';
import 'package:crypto_data/application/presentation/features/main/page/main_page.dart';
import 'package:crypto_data/application/presentation/initial_page.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page|Screen|BottomSheet,Route',
  routes: [
    AutoRoute(
      path: '/',
      page: InitialPage,
      children: [
        CustomRoute(
          path: 'main_page',
          page: MainPage,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          path: 'detail',
          page: DetailPage,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          )
      ],
    ),
    RedirectRoute(
      path: '*',
      redirectTo: '/',
    ),
  ],
)
class $AppRouter {}
