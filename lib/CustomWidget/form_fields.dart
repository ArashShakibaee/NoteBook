import 'package:flutter/material.dart';

class FormTextFields extends StatelessWidget {
  final bool? isImportant;
  final int? number;
  final String? title;
  final String? description;
  final ValueChanged<bool> onChangedIsImportant;
  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  const FormTextFields(
      {Key? key,
      this.isImportant,
      this.number,
      this.title,
      this.description,
      required this.onChangedIsImportant,
      required this.onChangedNumber,
      required this.onChangedTitle,
      required this.onChangedDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Switch(
                  value: isImportant ?? false, onChanged: onChangedIsImportant),
              const SizedBox(
                width: 20,
              ),
              Slider(
                  value: (number ?? 0).toDouble(),
                  min: 0,
                  max: 5,
                  divisions: 5,
                  onChanged: (number) => onChangedNumber(number.toInt()))
            ],
          ),
          const SizedBox(height: 10,),
          buildTitleField(),
          const SizedBox(height: 8,),
          buildDescriptionField(),
          const SizedBox(height: 20,)
        ],
      ),
    );
  }
  Widget buildTitleField(){
    return TextFormField(
      validator: (title){
        title != null && title.isEmpty ? 'Title is required !':null;
      },
      initialValue: title,
      maxLines: 1,
      style: const TextStyle(
        color: Colors.white70,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      onChanged: onChangedTitle,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Title',
        hintStyle: TextStyle(color: Colors.white70),
      ),
    );
  }
  Widget buildDescriptionField(){
    return TextFormField(
      validator: (description){
        description != null && description.isEmpty ? 'Description is required !':null;
      },
      initialValue: description,
      style: const TextStyle(
        color: Colors.white60,
        fontSize: 18,
      ),
      onChanged: onChangedDescription,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Type Something ...',
        hintStyle: TextStyle(color: Colors.white60),
      ),
    );
  }
}
