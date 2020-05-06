import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kitchentimer/providers/app_provider.dart';
import 'package:kitchentimer/providers/database_provider.dart';
import 'package:kitchentimer/providers/notification_provider.dart';
import 'package:kitchentimer/resources/routes.dart';
import 'package:kitchentimer/resources/strings.dart';
import 'package:kitchentimer/resources/themes.dart';
import 'package:kitchentimer/screens/add_timer/add_timer_screen.dart';
import 'package:kitchentimer/screens/favorite/favorite_screen.dart';
import 'package:kitchentimer/screens/timer/timer_screen.dart';
import 'package:provider/provider.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        initialRoute: '/',
        title: Strings.appTitle,
        theme: Themes.appTheme(context),
        routes: {
          Routes.timerScreen: (context) => TimerScreen(),
          Routes.addTimerScreen: (context) => AddTimerScreen(),
          Routes.favoriteScreen: (context) => FavoriteScreen(),
        },
      ),
      providers: [
        Provider(create: (context) => NotificationProvider()),
        Provider(
          create: (context) => DatabaseProvider(),
          dispose: (_, DatabaseProvider favorite) => favorite.close(),
        ),
        ChangeNotifierProxyProvider2<NotificationProvider, DatabaseProvider,
            AppProvider>(
          create: (BuildContext context) => AppProvider(),
          update: (BuildContext context, NotificationProvider notification,
                  DatabaseProvider favorite, AppProvider app) =>
              app
                ..notificationProvider = notification
                ..databaseProvider = favorite,
        )
      ],
    );
  }
}
