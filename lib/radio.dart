import 'package:flutter/material.dart';

class RadioExample extends StatefulWidget {
  @override
  _RadioExampleState createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  List<String> selectedItems = [];

  void toggleSelection(String value) {
    setState(() {
      if (selectedItems.contains(value)) {
        selectedItems.remove(value);
      } else {
        selectedItems.add(value);
      }
    });
  }

  String _selectedOption = 'Option 1';
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  double _sliderValue = 50; // Nilai awal
  RangeValues _rangeValues = RangeValues(20, 80); // Nilai awal

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Radio Button Example")),
      body: Column(
        children: [
          ListTile(
            title: Text("Option 1"),
            leading: Radio(
              value: 'Option 1',
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value!;
                });
              },
            ),
          ),
          ListTile(
            title: Text("Option 2"),
            leading: Radio(
              value: 'Option 2',
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value!;
                });
              },
            ),
          ),
          Text("Selected: $_selectedOption"),
          Column(
            children: [
              Checkbox(
                value: _isChecked1,
                onChanged: (value) {
                  setState(() {
                    _isChecked1 = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text("Option 1"),
                value: _isChecked1,
                onChanged: (value) {
                  setState(() {
                    _isChecked1 = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text("Option 2"),
                value: _isChecked2,
                onChanged: (value) {
                  setState(() {
                    _isChecked2 = value!;
                  });
                },
              ),
              Text(
                  "Selected: ${_isChecked1 ? 'Option 1 ' : ''}${_isChecked2 ? 'Option 2' : ''}"),
            ],
          ),
          customRadioButton("Option 1"),
          customRadioButton("Option 2"),
          customRadioButton("Option 3"),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Volume: ${_sliderValue.toInt()}%",
                  style: TextStyle(fontSize: 18)),
              Slider(
                value: _sliderValue,
                min: 0,
                max: 100,
                divisions: 4, // Membagi slider ke beberapa bagian
                label: _sliderValue.toInt().toString(),
                onChanged: (value) {
                  setState(() {
                    _sliderValue = value;
                  });
                },
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "Range: ${_rangeValues.start.toInt()} - ${_rangeValues.end.toInt()}",
                  style: TextStyle(fontSize: 18)),
              RangeSlider(
                values: _rangeValues,
                min: 0,
                max: 100,
                divisions: 10,
                labels: RangeLabels(
                  _rangeValues.start.toInt().toString(),
                  _rangeValues.end.toInt().toString(),
                ),
                onChanged: (values) {
                  setState(() {
                    _rangeValues = values;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget customRadioButton(String value) {
    bool isSelected = selectedItems.contains(value);

    return ListTile(
      title: Text(value),
      leading: InkWell(
        onTap: () => toggleSelection(value),
        child: CircleAvatar(
          radius: 10,
          backgroundColor: isSelected ? Colors.blue : Colors.grey.shade300,
          foregroundColor: Colors.white,
          child: Icon(
            size: 20,
            isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isSelected ? Colors.white : Colors.black54,
          ),
        ),
      ),
    );
  }
}
