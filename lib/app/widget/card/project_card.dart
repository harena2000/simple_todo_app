import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:simple_todo_app/app/constant/app_assets.dart';
import 'package:simple_todo_app/app/constant/app_colors.dart';
import 'package:simple_todo_app/app/model/project_model.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel projectModel;
  final double? width;
  final void Function()? onTap;

  const ProjectCard(
      {super.key, required this.projectModel, this.width = 220, this.onTap});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations word = AppLocalizations.of(context)!;
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      splashColor: AppColors.green,
      onTap: () => widget.onTap!(),
      child: Ink(
        child: SizedBox(
          width: widget.width,
          height: 180,
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 0,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: widget.projectModel.projectColor,
                      image: const DecorationImage(
                        image: AssetImage(
                          AppAssets.waveTransparent,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "The project title is long",
                            overflow: TextOverflow.fade,
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            word.subTaskNumber(16),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                word.complationRate,
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                "70%",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: LinearPercentIndicator(
                            lineHeight: 6,
                            percent: 0.7,
                            animation: true,
                            animationDuration: 500,
                            backgroundColor: AppColors.grey,
                            progressColor: widget.projectModel.projectColor,
                            barRadius: const Radius.circular(50),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget userAvatarWidget(int index) {
    return Positioned(
      left: index == 0 ? 0 : index * 20,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: widget.projectModel.projectColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: CircleAvatar(
            child: Icon(FontAwesomeIcons.user),
          ),
        ),
      ),
    );
  }
}
