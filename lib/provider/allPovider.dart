


import 'package:alibhaiapp/task/auth_provider.dart';
import 'package:provider/provider.dart';

var allProvider = [

   ChangeNotifierProvider<AuthProvider>(
    create: (_) => AuthProvider(),
    lazy: true,
  ),
];