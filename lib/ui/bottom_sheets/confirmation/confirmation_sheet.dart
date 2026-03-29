import 'package:flutter/material.dart';
import 'package:tmdb_movies/ui/common/app_colors.dart';
import 'package:tmdb_movies/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'confirmation_sheet_model.dart';

class ConfirmationSheet extends StackedView<ConfirmationSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const ConfirmationSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ConfirmationSheetModel viewModel,
    Widget? child,
  ) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            request.title ?? 'Confirmation',
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
          if (request.description != null) ...[
            verticalSpaceTiny,
            Text(
              request.description!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: kcLightGrey,
              ),
              maxLines: 3,
              softWrap: true,
            ),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () =>
                    completer?.call(SheetResponse(confirmed: false)),
                child: const Text('No'),
              ),
              horizontalSpaceSmall,
              ElevatedButton(
                onPressed: () =>
                    completer?.call(SheetResponse(confirmed: true)),
                child: const Text('Yes'),
              ),
            ],
          ),
          verticalSpaceLarge,
        ],
      ),
    );
  }

  @override
  ConfirmationSheetModel viewModelBuilder(BuildContext context) =>
      ConfirmationSheetModel();
}
