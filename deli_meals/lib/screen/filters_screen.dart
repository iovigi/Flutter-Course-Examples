import 'package:deli_meals/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegan = false;
  bool _vegetarian = false;
  bool _lactoseFree = false;

  Widget _buildSwitchListTile(
      String title, String subTitle, bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      onChanged: updateValue,
      subtitle: Text(subTitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection.',
                style: Theme.of(context).textTheme.headline6,
              )),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchListTile(
                  'Gluten-free', 'Only include gluten-free meals!', _glutenFree,
                  (newValue) {
                setState(() {
                  _glutenFree = newValue;
                });
              }),
              _buildSwitchListTile('Vegan', 'Only include vegan meals!', _vegan,
                  (newValue) {
                setState(() {
                  _vegan = newValue;
                });
              }),
              _buildSwitchListTile(
                  'Vegetarian', 'Only include vegetarian meals!', _vegetarian,
                  (newValue) {
                setState(() {
                  _vegetarian = newValue;
                });
              }),
              _buildSwitchListTile('Lactose-Free',
                  'Only include lactose-Free meals!', _lactoseFree, (newValue) {
                setState(() {
                  _lactoseFree = newValue;
                });
              }),
            ],
          ))
        ],
      ),
    );
  }
}
