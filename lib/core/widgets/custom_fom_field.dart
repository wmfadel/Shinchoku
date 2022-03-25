import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final Function(String?)? onSave;
  final String? Function(String?)? validate;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final bool isSecretValue;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final bool obscure;
  final int lengthLimit;
  final bool enabled;

  const CustomFormField({
    required this.label,
    required this.validate,
    this.onSave,
    this.controller,
    this.onChanged,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.name,
    this.isSecretValue = false,
    this.obscure = true,
    this.enabled = true,
    this.lengthLimit = 0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      obscureText: isSecretValue ? obscure : false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: lengthLimit == 0
          ? null
          : [
              LengthLimitingTextInputFormatter(lengthLimit),
            ],
      decoration: InputDecoration(
        hintText: label,
        errorStyle: Theme.of(context).textTheme.caption!.copyWith(
              color: Colors.red,
            ),
        filled: true,
        fillColor: Colors.white,
        enabled: enabled,
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(14),
          ),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.solid,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        suffixIcon: isSecretValue
            ? GestureDetector(
                onTap: () {},
                child: Icon(
                  obscure ? Icons.visibility_off : Icons.visibility,
                ),
              )
            : null,
      ),
      onChanged: onChanged,
      validator: validate,
      onSaved: onSave,
    );
  }
}
