import 'package:credit_manager/database/application_database.dart';
import 'package:credit_manager/database/credit_card_dao.dart';
import 'package:credit_manager/database/credit_dao.dart';
import 'package:credit_manager/i18n/strings.g.dart';
import 'package:credit_manager/providers/credit_card_provider.dart';
import 'package:credit_manager/providers/credit_provider.dart';
import 'package:credit_manager/screens/card_screens/add_card_screen.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:credit_manager/screens/cards_screen.dart';
import 'package:credit_manager/screens/credit_screen.dart';
import 'package:credit_manager/screens/about_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

void main() {
  final widgetsBinding = WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter initialization
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  LocaleSettings.useDeviceLocale(); // Make Locale available
  // GetIt Database dependency injection
  GetIt.instance.registerSingletonAsync<ApplicationDatabase>(() async =>
      $FloorApplicationDatabase.databaseBuilder('credit_manager.db').build());
  GetIt.instance.registerSingletonWithDependencies<CreditCardDao>(
      () => GetIt.instance.get<ApplicationDatabase>().creditCardDao,
      dependsOn: [ApplicationDatabase]);
  GetIt.instance.registerSingletonWithDependencies<CreditDao>(
      () => GetIt.instance.get<ApplicationDatabase>().creditDao,
      dependsOn: [ApplicationDatabase]);
  // Run application
  runApp(TranslationProvider(child: const Application()));
}

/// Creates [MaterialApp] with [DynamicColorBuilder] provided ColorScheme compatible with Material You
class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) => DynamicColorBuilder(
        // MaterialYou theme loader
        builder: (lightDynamic, darkDynamic) => FutureBuilder(
            // Wait for Dependency Injectio
            future: GetIt.instance.allReady(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // Remove the splash screen
                FlutterNativeSplash.remove();
                // Material Application
                return MultiProvider(
                    providers: [
                      ChangeNotifierProvider<CreditCardProvider>(
                        create: (_) => CreditCardProvider(),
                      ),
                      ChangeNotifierProvider<CreditProvider>(
                        create: (_) => CreditProvider(),
                      )
                    ],
                    builder: (context, _) {
                      return MaterialApp(
                          title: 'Credit Manager',
                          locale: TranslationProvider.of(context).flutterLocale,
                          localizationsDelegates:
                              GlobalMaterialLocalizations.delegates,
                          supportedLocales: LocaleSettings.supportedLocales,
                          theme: ThemeData(
                              colorScheme: lightDynamic ??
                                  ColorScheme.fromSeed(
                                      seedColor: Colors.greenAccent),
                              useMaterial3: true),
                          darkTheme: ThemeData(
                              colorScheme: darkDynamic ??
                                  ColorScheme.fromSeed(
                                      seedColor: Colors.lightGreen,
                                      brightness: Brightness.dark),
                              useMaterial3: true),
                          home: const MainView());
                    });
              } else {
                return const SizedBox.shrink();
              }
            }),
      );
}

/// Create the main view with bottom navigation bar with [CardsScreen], [CreditScreen] and [AboutScreen]
class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;
  final PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String appBarTitle = t.app.title;
    switch (_currentIndex) {
      case 0:
        appBarTitle = t.navigation.cards.appbar_title;
        break;
      case 1:
        appBarTitle = t.navigation.credit.appbar_title;
        break;
      case 2:
        appBarTitle = t.navigation.about.appbar_title;
        break;
    }

    return Scaffold(
        floatingActionButton: _currentIndex == 0
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const AddCardScreen(),
                  ));
                },
                child: const Icon(Icons.add),
              )
            : null,
        body: NestedScrollView(
          headerSliverBuilder: (_, __) => [
            SliverAppBar.large(
              title: Text(appBarTitle),
              centerTitle: true,
            ),
          ],
          body: PageView(
              controller: pageController,
              onPageChanged: (value) => setState(() {
                    _currentIndex = value;
                  }),
              children: [
                const CardsScreen(),
                WillPopScope(
                    onWillPop: _returnToHome, child: const CreditScreen()),
                WillPopScope(
                    onWillPop: _returnToHome, child: const AboutScreen())
              ]),
        ),

        //* BottomNavigationBar to Routes
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (value) => navigateToPage(value),
          destinations: [
            NavigationDestination(
                icon: const Icon(Icons.credit_card),
                label: t.navigation.cards.bottom_item),
            NavigationDestination(
                icon: const Icon(Icons.attach_money),
                label: t.navigation.credit.bottom_item),
            NavigationDestination(
                icon: const Icon(Icons.info_rounded),
                label: t.navigation.about.bottom_item),
          ],
        ));
  }

  Future<bool> _returnToHome() async {
    navigateToPage(0);
    return false;
  }

  navigateToPage(int index) {
    setState(() {
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    });
  }
}
