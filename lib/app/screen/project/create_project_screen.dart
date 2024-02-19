import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_app/app/constant/app_assets.dart';
import 'package:simple_todo_app/app/constant/app_colors.dart';
import 'package:simple_todo_app/app/model/project_model.dart';
import 'package:simple_todo_app/app/provider/project_provider.dart';
import 'package:simple_todo_app/app/widget/button/simple_button.dart';
import 'package:simple_todo_app/app/widget/loader/loader.dart';
import 'package:simple_todo_app/app/widget/text_field/custom_text_field.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  Color colorPicked = AppColors.green;
  int assetIndex = 0;
  String assetSelected = AppAssets.rectangleShapes;
  final _inputFormKey = GlobalKey<FormState>();

  List<String> assetsList = [
    AppAssets.rectangleShapes,
    AppAssets.waveTransparent,
  ];

  String title = "";
  String description = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AppLocalizations word = AppLocalizations.of(context)!;
    return Consumer<ProjectProvider>(builder: (context, projectProvider, _) {
      return ModalProgressHUD(
        inAsyncCall: isLoading,
        progressIndicator: const Loader(),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        word.createProject,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(FontAwesomeIcons.xmark),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        chooseColorForm(word),
                        const SizedBox(
                          height: 20,
                        ),
                        chooseAssetForm(word),
                        const SizedBox(
                          height: 20,
                        ),
                        textInputForm(word),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: SimpleButton(
                    text: word.save,
                    onPressed: () {
                      if (_inputFormKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        ProjectModel data = ProjectModel(
                          title: title,
                          description: description,
                          projectId: 1,
                          projectColor: colorPicked,
                          imageAsset: assetSelected,
                          todoTaskList: [],
                        );
                        try {
                          projectProvider.addProject(data);
                          Navigator.of(context).pop();
                        } catch (e) {
                          print("error");
                        }
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget chooseColorForm(AppLocalizations word) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          word.chooseColor,
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(word.chooseColor),
                content: MultipleChoiceBlockPicker(
                  pickerColors: const [],
                  onColorsChanged: (value) {},
                  itemBuilder: (color, isCurrentColor, changeColor) =>
                      GestureDetector(
                    onTap: () {
                      setState(() {
                        colorPicked = color;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: color,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(10),
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.grey.withOpacity(0.3),
            ),
            child: Row(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colorPicked,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  colorPicked.value.toRadixString(16).toUpperCase(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget chooseAssetForm(AppLocalizations word) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          word.chooseAsset,
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: assetsList.length,
            itemBuilder: ((context, index) {
              return Container(
                height: 50,
                width: 50,
                margin: const EdgeInsets.only(right: 10),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: colorPicked,
                  border: assetIndex == index
                      ? Border.all(
                          color: AppColors.darkGrey.withOpacity(0.5),
                          width: 3,
                        )
                      : null,
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      assetIndex = index;
                      assetSelected = assetsList[index];
                    });
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    assetsList[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }),
          ),
        )
      ],
    );
  }

  Widget textInputForm(AppLocalizations word) {
    return Form(
      key: _inputFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            word.title,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            hintText: word.enterTitle,
            icon: FontAwesomeIcons.t,
            validator: (value) {
              if (value!.isEmpty) {
                return word.inputEmptyError;
              }
              return null;
            },
            onChange: (value) {
              setState(() {
                title = value;
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            word.description,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            hintText: word.enterDescription,
            maxLines: 8,
            onChange: (value) {
              setState(() {
                description = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
