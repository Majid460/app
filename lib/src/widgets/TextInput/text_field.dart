import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  const TextInput(
      {super.key,
      required,
      this.value,
      this.maxLength,
      required this.hint,
      required this.textColor,
      required this.fontSize,
      required this.onChanged,
      required this.expands,
      required this.icon,
      required this.iconColor,
      this.inputType});
  final String hint;
  final Color textColor;
  final double fontSize;
  final Function onChanged;
  final bool expands;
  final IconData icon;
  final Color iconColor;
  final String? value;
  final int? maxLength;
  final TextInputType? inputType;
  @override
  State<TextInput> createState() => _TextField();
}

class _TextField extends State<TextInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
          maxLength: widget.maxLength == 0 ? null : widget.maxLength,
          minLines: null,
          maxLines: null,
          expands: widget.expands,
          keyboardType: widget.inputType,
          onChanged: (value) {
            widget.onChanged(value);
          },
          style: TextStyle(color: Color(widget.textColor.value)),
          decoration: InputDecoration(
            labelText: widget.hint,
            prefixIcon: Icon(widget.icon),
            prefixIconColor: widget.iconColor,
            alignLabelWithHint: true,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)),
            labelStyle:
                TextStyle(fontSize: widget.fontSize, color: Colors.grey),
          )),
    );
  }
}
