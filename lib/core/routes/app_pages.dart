import 'package:get/get.dart';
import '../../modules/auth/login_view.dart';
import '../../modules/home/home_view.dart';
import '../../modules/group/group_list_view.dart';
import '../../modules/group/group_form_view.dart';
import '../../modules/group/group_detail_view.dart';
import '../../modules/members/members_view.dart';
import '../../modules/billing/billing_list_view.dart';
import '../../modules/export/export_view.dart';
import '../../modules/settings/settings_view.dart';
import '../../modules/auth/splash_view.dart';
import '../middleware/auth_guard.dart';
import '../middleware/pro_guard.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = <GetPage>[
    GetPage(name: Routes.splash, page: () => const SplashView()),
    GetPage(name: Routes.login, page: () => const LoginView()),
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      middlewares: [AuthGuard()],
    ),
    GetPage(
      name: Routes.groupList,
      page: () => const GroupListView(),
      middlewares: [AuthGuard()],
    ),
    GetPage(
      name: Routes.groupForm,
      page: () => const GroupFormView(),
      middlewares: [AuthGuard()],
    ),
    GetPage(
      name: Routes.groupDetail,
      page: () => const GroupDetailView(),
      middlewares: [AuthGuard()],
    ),
    GetPage(
      name: Routes.members,
      page: () => const MembersView(),
      middlewares: [AuthGuard()],
    ),
    GetPage(
      name: Routes.billing,
      page: () => const BillingListView(),
      middlewares: [AuthGuard()],
    ),
    GetPage(
      name: Routes.export,
      page: () => const ExportView(),
      middlewares: [AuthGuard(), ProGuard()],
    ),
    GetPage(
      name: Routes.settings,
      page: () => const SettingsView(),
      middlewares: [AuthGuard()],
    ),
  ];
}
