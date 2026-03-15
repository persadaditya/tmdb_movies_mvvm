import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

import 'app_text_field_model.dart';

class AppTextField extends StackedView<AppTextFieldModel> {
  const AppTextField(
      {super.key,
      this.hintText,
      this.labelText,
      this.isPassword,
      this.onSubmitted,
      this.onChanged,
      this.onEditingComplete,
      this.inputFormatters,
      this.enabled,
      this.keyboardType = TextInputType.text,
      this.textInputAction,
      this.textCapitalization = TextCapitalization.none,
      this.textAlign = TextAlign.start,
      this.textDirection,
      this.textAlignVertical,
      this.minLines,
      this.maxLines,
      this.expands = false,
      this.readOnly = false,
      this.controller});

  final String? hintText;
  final String? labelText;
  final bool? isPassword;
  final TextEditingController? controller;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  ///
  /// See also:
  ///
  ///  * [TextInputAction.next] and [TextInputAction.previous], which
  ///    automatically shift the focus to the next/previous focusable item when
  ///    the user is done editing.
  final ValueChanged<String>? onSubmitted;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  /// If false the text field is "disabled": it ignores taps and its
  /// [decoration] is rendered in grey.
  ///
  /// If non-null this property overrides the [decoration]'s
  /// [InputDecoration.enabled] property.
  final bool? enabled;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType keyboardType;

  /// {@template flutter.widgets.TextField.textInputAction}
  /// The type of action button to use for the keyboard.
  ///
  /// Defaults to [TextInputAction.newline] if [keyboardType] is
  /// [TextInputType.multiline] and [TextInputAction.done] otherwise.
  /// {@endtemplate}
  final TextInputAction? textInputAction;

  /// {@macro flutter.widgets.editableText.textCapitalization}
  final TextCapitalization textCapitalization;

  /// {@macro flutter.widgets.editableText.textAlign}
  final TextAlign textAlign;

  /// {@macro flutter.material.InputDecorator.textAlignVertical}
  final TextAlignVertical? textAlignVertical;

  /// {@macro flutter.widgets.editableText.textDirection}
  final TextDirection? textDirection;

  /// {@macro flutter.widgets.editableText.maxLines}
  ///  * [expands], which determines whether the field should fill the height of
  ///    its parent.
  final int? maxLines;

  /// {@macro flutter.widgets.editableText.minLines}
  ///  * [expands], which determines whether the field should fill the height of
  ///    its parent.
  final int? minLines;

  /// {@macro flutter.widgets.editableText.expands}
  final bool expands;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;

  /// {@macro flutter.widgets.editableText.onChanged}
  ///
  /// See also:
  ///
  ///  * [inputFormatters], which are called before [onChanged]
  ///    runs and can validate and change ("format") the input value.
  ///  * [onEditingComplete], [onSubmitted]:
  ///    which are more specialized input change notifications.
  final ValueChanged<String>? onChanged;

  /// {@macro flutter.widgets.editableText.onEditingComplete}
  final VoidCallback? onEditingComplete;

  @override
  Widget builder(
    BuildContext context,
    AppTextFieldModel viewModel,
    Widget? child,
  ) {
    return TextField(
        controller: controller,
        obscureText: isPassword == true ? viewModel.obscureText : false,
        enabled: enabled,
        inputFormatters: inputFormatters,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
        textCapitalization: textCapitalization,
        keyboardType: keyboardType,
        textAlign: textAlign,
        textAlignVertical: textAlignVertical,
        textDirection: textDirection,
        minLines: minLines,
        maxLines: isPassword == true ? 1 : maxLines,
        expands: expands,
        readOnly: readOnly,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          suffixIcon: isPassword == null
              ? null
              : isPassword == true
                  ? IconButton(
                      icon: Icon(viewModel.obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () =>
                          viewModel.setObscureText(!viewModel.obscureText),
                    )
                  : null,
        ));
  }

  @override
  AppTextFieldModel viewModelBuilder(
    BuildContext context,
  ) =>
      AppTextFieldModel();
}
