import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsTitle),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(AppLocalizations.of(context)!.languageLabel),
            trailing: DropdownButton<Locale>(
              value: Localizations.localeOf(context),
              onChanged: (Locale? newLocale) {
                if (newLocale != null) {
                  MyApp.setLocale(context, newLocale);
                }
              },
              items: const [
                DropdownMenuItem(value: Locale('es'), child: Text('Español')),
                DropdownMenuItem(value: Locale('en'), child: Text('English')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
