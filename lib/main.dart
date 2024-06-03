import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_unit_test_app/core/extensions/after_last_dot_capitalized.dart';
import 'package:easy_unit_test_app/core/extensions/after_last_dot_not_capitalized.dart';
import 'package:easy_unit_test_app/core/extensions/format_number.dart';
import 'package:easy_unit_test_app/widgets/search_modal_widget.dart';
import 'package:easy_unit_test_app/core/theme/light.dart';
import 'package:easy_unit_test_app/core/theme/values/app_colors.dart';
import 'package:easy_unit_test_app/core/theme/values/app_units.dart';
import 'package:easy_unit_test_app/widgets/unit_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:units_converter/units_converter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Unit Test App',
      theme: LightTheme.themeData,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final Color _outputButtonColor = AppColors.getRandomColor();
  bool _isFavourite = false;
  Property _selectedProperty = properties.first;
  Unit? _selectedInputUnit;
  Unit? _selectedOutputUnit;
  List<Unit> get _units => _selectedProperty.getAll();
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();

  List<DropdownMenuItem<Property>> get _propertiesItems => List.generate(
      properties.length,
      (int index) => DropdownMenuItem(
          value: properties[index],
          child: Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: index == 0 ? Colors.transparent : Colors.grey,
                        width: 0.5))),
            child: Text(
                properties[index].name.toString().afterLastDotCapitalized,
                style: Theme.of(context).textTheme.titleSmall),
          )));

  @override
  Widget build(BuildContext context) {
    _selectedInputUnit ??= _units.first;
    _selectedOutputUnit ??= _units.last;

    final themeData = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 62),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                DropdownButton2<Property>(
                  customButton: Row(
                    children: [
                      Text(
                          _selectedProperty.name
                              .toString()
                              .afterLastDotCapitalized,
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(width: 15),
                      const Icon(CupertinoIcons.chevron_down,
                          weight: 800, color: Colors.black),
                    ],
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(CupertinoIcons.chevron_down,
                        weight: 800, color: Colors.black),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                  items: _propertiesItems,
                  onChanged: (value) {
                    setState(() {
                      _selectedProperty = value!;
                      _selectedInputUnit = _units.first;
                      _selectedOutputUnit = _units.last;
                      convertUnits();
                    });
                  },
                  underline: const SizedBox.shrink(),
                ),
                const Spacer(),
                IconButton(
                    onPressed: setFavourite,
                    icon: _isFavourite
                        ? const Icon(CupertinoIcons.heart_fill,
                            color: Colors.red)
                        : const Icon(CupertinoIcons.heart))
              ],
            ),
            const SizedBox(height: 16),
            Text('from', style: themeData.textTheme.bodySmall),
            const SizedBox(height: 2),
            Row(
              children: [
                Expanded(
                  child: UnitTextField(
                    controller: _inputController,
                    themeData: themeData,
                    readOnly: false,
                    onChanged: convertUnits,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () async =>
                      await openBottomSheet(_units, context, true),
                  child: Container(
                      height: 72,
                      width: 109,
                      decoration: BoxDecoration(
                        color: AppColors.gray,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Center(
                          child: Row(
                        children: [
                          Expanded(
                            child: Text(
                                _selectedInputUnit!.symbol == null
                                    ? _selectedInputUnit!.name
                                        .toString()
                                        .afterLastDotCapitalized
                                        .substring(0, 4)
                                    : _selectedInputUnit!.symbol.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleSmall),
                          ),
                          const SizedBox(width: 4),
                          const Icon(CupertinoIcons.chevron_down,
                              weight: 800, color: Colors.black),
                        ],
                      ))),
                )
              ],
            ),
            const SizedBox(height: 16),
            Text('to', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 2),
            Row(
              children: [
                Expanded(
                  child: UnitTextField(
                    controller: _outputController,
                    themeData: themeData,
                    readOnly: true,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () async =>
                      await openBottomSheet(_units, context, false),
                  child: Container(
                      height: 72,
                      width: 109,
                      decoration: BoxDecoration(
                        color: _outputButtonColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Center(
                          child: Row(
                        children: [
                          Expanded(
                            child: Text(
                                _selectedOutputUnit!.symbol == null
                                    ? _selectedOutputUnit!.name
                                        .toString()
                                        .afterLastNotDotCapitalized
                                        .substring(0, 4)
                                    : _selectedOutputUnit!.symbol.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleSmall),
                          ),
                          const SizedBox(width: 4),
                          const Icon(CupertinoIcons.chevron_down,
                              weight: 800, color: Colors.black),
                        ],
                      ))),
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: Colors.black.withOpacity(0.1), width: 1.0))),
        child: BottomNavigationBar(
          onTap: (value) => {setState(() => _selectedIndex = value)},
          currentIndex: _selectedIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.arrow_up_arrow_down),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.money_dollar_circle),
              label: 'Plans',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.gear),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }

  // Установить в избранное
  setFavourite() {
    setState(() {
      _isFavourite = !_isFavourite;
    });
  }

  // Выбор единицы измерения для ввода
  setInputUnitTap(Unit unit) {
    setState(() {
      _selectedInputUnit = unit;
      convertUnits();
    });
  }

  // Выбор единицы измерения для вывода
  setOutputUnitTap(Unit unit) {
    setState(() {
      _selectedOutputUnit = unit;
      convertUnits();
    });
  }

  // Конвертор из одной единицы в другую
  convertUnits() {
    setState(() {
      final double? doubleFromString = double.tryParse(_inputController.text);
      if (doubleFromString == null) {
        _inputController.text = '';
        _outputController.text = '';
      } else {
        _outputController.text = doubleFromString
            .convertFromTo(_selectedInputUnit!.name, _selectedOutputUnit!.name)!
            .formatNumber;
      }
    });
  }

  //Открыт боттомшит для выбора единицы измерения
  openBottomSheet(
      List<Unit> units, BuildContext context, bool isUnputField) async {
    await showModalBottomSheet(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        isScrollControlled: true,
        enableDrag: true,
        context: context,
        builder: (context) {
          return SearchModalWidget(
            units: units,
            onInputUnitTap: setInputUnitTap,
            onOutputUnitTap: setOutputUnitTap,
            isUnputField: isUnputField,
          );
        });
  }
}
