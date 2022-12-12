import 'package:credit_manager/i18n/strings.g.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              t.app.title,
              style: const TextStyle(fontSize: 22.0),
            ),
            Expanded(
              child: Image.asset(
                'assets/icons/icon.png',
              ),
            ),
            FutureBuilder(
              future: PackageInfo.fromPlatform(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final data = snapshot.data!;
                  return Text.rich(
                      TextSpan(text: "${data.appName} (v${data.version})"));
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Powered by Flutter 🐦️\nCopyright © Ángel Talero 2022 - ${DateTime.now().year}\n${t.app.legal}",
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.balance),
              label: Text(t.app.licenses),
              onPressed: () {
                showLicensePage(
                    applicationName: t.app.title,
                    useRootNavigator: true,
                    context: context);
              },
            ),
            ElevatedButton.icon(
              label: Text(t.app.github),
              icon: const Icon(Icons.people_alt_rounded),
              onPressed: () {
                launchUrl(
                        mode: LaunchMode.externalApplication,
                        Uri.parse(
                            "https://github.com/taleroangel/credit_manager"))
                    .onError((error, stackTrace) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(error.toString())));
                  return true;
                });
              },
            )
          ],
        ),
      );
}
