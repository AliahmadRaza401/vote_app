


import 'package:alibhaiapp/provider/admin_provider.dart';
import 'package:alibhaiapp/provider/auth_provider.dart';
import 'package:provider/provider.dart';

var allProvider = [

   ChangeNotifierProvider<AuthProvider>(
    create: (_) => AuthProvider(),
    lazy: true,
  ),
   ChangeNotifierProvider<AdminProvider>(
    create: (_) => AdminProvider(),
    lazy: true,
  ),
];