import 'package:flutter/material.dart';
import 'package:tmdb_movies/ui/common/app_colors.dart';
import 'package:tmdb_movies/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'countries_sheet_model.dart';

class CountriesSheet extends StackedView<CountriesSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const CountriesSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CountriesSheetModel viewModel,
    Widget? child,
  ) {
    final colorTheme = Theme.of(context).colorScheme;
    return Container(
      height: screenHeight(context) * 0.85,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: colorTheme.surface,
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
            request.title ?? 'Countries',
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
          verticalSpaceSmall,
          TextField(
            controller: viewModel.controller,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: appColorTextBlack,
              focusColor: Colors.grey.shade100,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  borderSide: BorderSide.none),
              hintStyle: TextStyle(
                color: Colors.grey.shade500,
              ),
              hintText: 'Search Country here',
              suffixIcon: viewModel.isSearch
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        viewModel.clearSearch();
                      },
                    )
                  : null,
              contentPadding: const EdgeInsets.all(8.0),
            ),
            onChanged: (value) {
              viewModel.toggleSearch();
              if (value.isEmpty) {
                viewModel.clearSearch();
              }
            },
            onSubmitted: (value) {
              if (value.isEmpty) return;
              viewModel.searchCountries(value);
            },
            textInputAction: TextInputAction.search,
          ),
          verticalSpaceSmall,
          Expanded(
            child: viewModel.isBusy
                ? Center(
                    child: CircularProgressIndicator(
                      color: colorTheme.primary,
                      strokeWidth: 2,
                    ),
                  )
                : ListView.separated(
                    itemCount: viewModel.countries.length,
                    separatorBuilder: (context, index) => verticalSpaceTiny,
                    itemBuilder: (context, index) {
                      var country = viewModel.countries[index];
                      return ListTile(
                        onTap: () => viewModel.selectCountry(country),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 5),
                        title: Text(country.englishName ?? 'Unknown'),
                        subtitle: Text(country.nativeName ?? 'Unknown'),
                        trailing: viewModel.selectedCountry?.iso31661 ==
                                country.iso31661
                            ? const Icon(Icons.check_rounded,
                                color: appColorPrimaryBlueAccent)
                            : null,
                      );
                    },
                  ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => completer?.call(SheetResponse()),
              ),
              ElevatedButton(
                child: const Text('Select'),
                onPressed: () {
                  viewModel.saveCountry();
                  completer?.call(SheetResponse(confirmed: true));
                },
              ),
            ],
          ),
          verticalSpaceLarge,
        ],
      ),
    );
  }

  @override
  void onViewModelReady(CountriesSheetModel viewModel) {
    viewModel.loadCountries();
    viewModel.loadSelectedCountry();
  }

  @override
  CountriesSheetModel viewModelBuilder(BuildContext context) =>
      CountriesSheetModel();
}
