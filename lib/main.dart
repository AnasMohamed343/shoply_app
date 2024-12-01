import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shoply/view/control_view.dart';
import 'package:shoply/view_model/cart_viewmodel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shoply/utils/binding.dart' as binding;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //Get.put(CartViewModel());
  await Supabase.initialize(
    url:
        'https://xnixcxqncdntqxcpbmre.supabase.co', // Replace with your Supabase project URL
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhuaXhjeHFuY2RudHF4Y3BibXJlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE3OTc0MjQsImV4cCI6MjA0NzM3MzQyNH0.sxQqGodU7GVDKXQwMYT3O7teN1GCvH6xvqi_ti3Cj24', // Replace with your Supabase API Key
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            initialBinding: binding.Binding(),
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            home: ControlView(),
          );
        });
  }
}
