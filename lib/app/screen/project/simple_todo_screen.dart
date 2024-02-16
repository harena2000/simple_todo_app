import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simple_todo_app/app/constant/app_colors.dart';

class SimpleTodoScreen extends StatefulWidget {
  const SimpleTodoScreen({super.key});

  @override
  State<SimpleTodoScreen> createState() => _SimpleTodoScreenState();
}

class _SimpleTodoScreenState extends State<SimpleTodoScreen> {
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
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.lightGrey.withOpacity(0.5),
                ),
                child: const Icon(
                  FontAwesomeIcons.listCheck,
                  size: 18,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(word.myWorkspace,
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
          actions: [
            SizedBox(
              height: 50,
              width: 50,
              child: IconButton(
                onPressed: () {},
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.lightGrey.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                icon: const Icon(
                  FontAwesomeIcons.plus,
                  size: 18,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ],
    );
  }
}
