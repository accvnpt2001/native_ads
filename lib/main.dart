import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:test_ads/src/normal_native_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();

  MobileAds.instance.updateRequestConfiguration(
    RequestConfiguration(
      testDeviceIds: ['D14B3B92C5B0532790311D6A1FD91CB1'],
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // PreloadNativeAdsManager.preloadNativeAds(
    //     name: 'test', adUnitId: 'ca-app-pub-3940256099942544/2247696110', templateType: TemplateAdType.medium);
    // PreloadNativeAdsManager.preloadNativeAds(
    //     name: 'test2', adUnitId: 'ca-app-pub-3940256099942544/2247696110', templateType: TemplateAdType.medium);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            NormalAdsNative(
                starColor: Colors.cyan,
                buttonBackgroundColor: Colors.cyan,
                backgroundColor: Colors.white,
                templateType: TemplateAdType.medium,
                adUnitId: 'ca-app-pub-3940256099942544/2247696110'),
            // PreloadNativeAds(name: 'test'),
          ],
        ),
      ),
    );
  }
}
