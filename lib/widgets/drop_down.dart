import 'package:chatgpt_flutterapp_tutorial/constants/constants.dart';
import 'package:chatgpt_flutterapp_tutorial/services/api_services.dart';
import 'package:chatgpt_flutterapp_tutorial/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../models/models_model.dart';

class ModelDropDownWidget extends StatefulWidget {
  const ModelDropDownWidget({super.key});

  @override
  State<ModelDropDownWidget> createState() => _ModelDropDownWidgetState();
}

class _ModelDropDownWidgetState extends State<ModelDropDownWidget> {
  String modelsSnapshot = ApiService.getModels() as String;
  String currentModel = 'text-davinci-003';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ModelsModel>>(
        future: ApiService.getModels(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: TextWidget(label: snapshot.error.toString()),
            );
          }
          return snapshot.data == null || snapshot.data!.isEmpty
              ? const SizedBox.shrink()
              : FittedBox(
                  child: DropdownButton(
                    iconEnabledColor: Colors.white,
                    dropdownColor: scaffoldBackgroundColor,
                    items: List<DropdownMenuItem<String?>>.generate(
                        snapshot.data!.length,
                        (index) => DropdownMenuItem(
                            value: snapshot.data![index].id,
                            child: TextWidget(
                              label: snapshot.data![index].id,
                              fontSize: 15,
                            ))),
                    value: currentModel,
                    onChanged: (value) {
                      setState(() {
                        currentModel = value.toString();
                      });
                    },
                  ),
                );
        }));
  }
}


/**
 */