import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'shared/providers/auth_provider.dart';
import 'shared/providers/user_provider.dart';
import 'shared/routes/app_router.dart';
import 'shared/theme/app_theme.dart';
import 'shared/services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await SharedPreferences.getInstance();
  final storageService = StorageService(storage);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(storageService)),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MediQApp(),
    ),
  );
}

class MediQApp extends StatelessWidget {
  const MediQApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter.router;

    return MaterialApp.router(
      title: 'MediQ',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
