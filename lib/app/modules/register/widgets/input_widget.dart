// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputWidget extends StatefulWidget {
  const InputWidget({
    super.key,
    required this.labelText,
    required this.controller,
    this.validator,
    this.bottom,
    this.formatters,
    this.isLastInput,
    this.isPassword,
    this.keyboard,
    this.onTap,
    this.focusNode,
    this.autofillHints,
    this.radius,
  });
  final String? Function(String?)? validator;
  final String labelText;
  final double? bottom;
  final List<TextInputFormatter>? formatters;
  final TextEditingController controller;
  final bool? isLastInput;
  final bool? isPassword;
  final TextInputType? keyboard;
  final Function()? onTap;
  final FocusNode? focusNode;
  final Iterable<String>? autofillHints;
  final double? radius;

  @override
  // ignore: library_private_types_in_public_api
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: widget.bottom ?? 12,
      ),
      child: TextFormField(
        autofillHints: widget.autofillHints,
        focusNode: widget.focusNode,
        onTap: widget.onTap,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        keyboardType: widget.keyboard ?? TextInputType.text,
        obscureText: !_showPassword && (widget.isPassword ?? false),
        controller: widget.controller,
        inputFormatters: widget.formatters ?? [],
        textInputAction: widget.isLastInput ?? false ? TextInputAction.done : TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15.5,
            horizontal: 12,
          ),
          labelText: widget.labelText,
          labelStyle: const TextStyle(
            fontSize: 14,
          ),
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.all(
              widget.radius == null ? const Radius.circular(8) : Radius.circular(widget.radius!),
            ),
          
          ),
          suffixIcon: widget.isPassword == true
              ? IconButton(
                  icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                )
              : null,
        ),
        validator: (value) {
          return widget.validator?.call(value);
        },
      ),
    );
  }
}
