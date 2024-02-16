import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_todo_app/app/constant/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountSettingScreen extends StatefulWidget {
  const AccountSettingScreen({super.key});

  @override
  State<AccountSettingScreen> createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations word = AppLocalizations.of(context)!;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: Container(),
          leadingWidth: 10,
          toolbarHeight: 90,
          scrolledUnderElevation: 50,
          pinned: true,
          stretch: true,
          backgroundColor: AppColors.green,
          foregroundColor: Colors.white,
          title: Row(
            children: [
              CircleAvatar(
                child: Icon(FontAwesomeIcons.user),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(word.accountSetting,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    "Mahefaniaina Harena Rico",
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w100),
                  ),
                ],
              ),
            ],
          ),
          actions: const [
            CircleAvatar(
              child: Icon(FontAwesomeIcons.user),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ],
    );
  }
}
