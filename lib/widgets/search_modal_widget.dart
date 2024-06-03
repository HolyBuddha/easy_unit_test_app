import 'package:easy_unit_test_app/core/extensions/after_last_dot_not_capitalized.dart';
import 'package:easy_unit_test_app/core/theme/values/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:units_converter/models/unit.dart';

class SearchModalWidget extends StatefulWidget {
  final List<Unit> units;
  final bool isUnputField;
  final Function(Unit unit) onInputUnitTap;
  final Function(Unit unit) onOutputUnitTap;

  const SearchModalWidget(
      {super.key,
      required this.units,
      required this.onInputUnitTap,
      required this.isUnputField,
      required this.onOutputUnitTap});
  @override
  SearchModalWidgetState createState() => SearchModalWidgetState();
}

class SearchModalWidgetState extends State<SearchModalWidget> {
  final TextEditingController _searchController = TextEditingController();

  List<Unit> _filteredUnits = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterItems);
    _filteredUnits = widget.units;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems() {
    setState(() {
      _filteredUnits = widget.units
          .where((item) => item.name
              .toString()
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 44),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child:
                Text('Add unit', style: Theme.of(context).textTheme.titleLarge),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                    fillColor: AppColors.gray,
                    filled: true,
                    prefixIcon: Icon(CupertinoIcons.search,
                        color: Color.fromRGBO(60, 60, 67, 0.6)),
                    hintText: 'Search',
                    hintStyle: TextStyle(fontSize: 17),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide.none,
                    ))),
          ),
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider(color: Colors.grey, height: 1);
                },
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _filteredUnits[index]
                          .name
                          .toString()
                          .afterLastNotDotCapitalized,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    onTap: () {
                      setState(() {
                        widget.isUnputField
                            ? widget.onInputUnitTap(_filteredUnits[index])
                            : widget.onOutputUnitTap(_filteredUnits[index]);
                      });
                      Navigator.pop(context);
                    },
                  );
                },
                itemCount: _filteredUnits.length),
          ),
        ],
      ),
    );
  }
}
