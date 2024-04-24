// https://api.flutter.dev/flutter/widgets/RawAutocomplete-class.html

import 'package:flutter/material.dart';

class RawAutoCompleteWidget extends StatelessWidget {
  const RawAutoCompleteWidget({super.key});

  static const List<String> _options = <String>[
    'aardvark',
    'bobcat',
    'chameleon',
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
        child: RawAutocomplete<String>(
            optionsBuilder: (TextEditingValue textEditingValue) {
      return _options.where((String option) {
        return option.contains(textEditingValue.text.toLowerCase());
      });
    }, fieldViewBuilder: (BuildContext context,
                TextEditingController textEditingController,
                FocusNode focusNode,
                VoidCallback onFieldSubmitted) {
      return TextFormField(
        controller: textEditingController,
        focusNode: focusNode,
        onFieldSubmitted: (String value) {
          onFieldSubmitted();
        },
      );
    }, optionsViewBuilder: (BuildContext context,
                AutocompleteOnSelected<String> onSelected,
                Iterable<String> options) {
      return Align(
          alignment: Alignment.topLeft,
          child: Material(
              elevation: 4.0,
              child: SizedBox(
                  height: 200.0,
                  child: ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: options.length,
                      itemBuilder: (BuildContext context, int index) {
                        final String option = options.elementAt(index);
                        return GestureDetector(
                            onTap: () {
                              onSelected(option);
                            },
                            child: ListTile(title: Text(option)));
                      }))));
    }));
  }
}
