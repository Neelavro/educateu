import 'package:educateu/injection_container.dart';
import 'package:educateu/providers/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'core/router.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<AuthenticationProvider>()),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return HeroIconTheme(
            style: HeroIconStyle.outline,
            child: MaterialApp.router(
              routerConfig: appRouter,
              theme: ThemeData(
                primarySwatch: Colors.blue,
                iconTheme: const IconThemeData(
                  color: Colors.red,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}