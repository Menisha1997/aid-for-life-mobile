import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.controller,
    this.label,
    this.type,
    this.validator,
    this.minlines,
    this.maxlines,
    this.onChanged,
    this.inputFormatters,
    this.inputBorder,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? label;
  final TextInputType? type;
  final String? Function(String?)? validator;
  final int? minlines;
  final int? maxlines;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final InputBorder? inputBorder;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      minLines: minlines,
      maxLines: maxlines,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        errorStyle: const TextStyle(color: Colors.red),
        labelStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
              fontWeight: FontWeight.normal,
            ),
        labelText: label,
        border: inputBorder,
      ),
      validator: validator,

      // onChanged: (value) {
      //   if (controller == _firstName) {
      //     setState(() {
      //       _bName = value;
      //     });
      //   }
      // },
    );
  }
}

class CustomFormPasswordField extends StatefulWidget {
  const CustomFormPasswordField(
      {Key? key, this.controller, this.label, this.type, this.validator})
      : super(key: key);

  final TextEditingController? controller;
  final String? label;
  final TextInputType? type;
  final String? Function(String?)? validator;

  @override
  State<CustomFormPasswordField> createState() =>
      _CustomFormPasswordFieldState();
}

class _CustomFormPasswordFieldState extends State<CustomFormPasswordField> {
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.type,
      obscureText: _passwordVisible,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
        labelText: widget.label,
      ),
      validator: widget.validator,

      // onChanged: (value) {
      //   if (controller == _firstName) {
      //     setState(() {
      //       _bName = value;
      //     });
      //   }
      // },
    );
  }
}
