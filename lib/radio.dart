import 'package:flutter/material.dart';
import 'widgets/custom.dart';
import 'package:flutter/material.dart';

class CustomSliderValueIndicator extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(50, 35); // Lebih tinggi agar ada ruang untuk lancipnya
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required Size sizeWithOverflow,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double textScaleFactor,
    required double value,
  }) {
    final canvas = context.canvas;
    const double width = 40;
    const double height = 24;
    const double arrowSize = 10; // Ukuran lancipnya

    // **Hitung posisi kotak dan segitiga (lancipnya)**
    final Rect rect = Rect.fromCenter(
      center: center - const Offset(0, 35),
      width: width,
      height: height,
    );

    // **Bentuk lancip di tengah bawah kotak**
    final Path trianglePath = Path()
      ..moveTo(center.dx - arrowSize / 2, rect.bottom) // Kiri bawah lancip
      ..lineTo(center.dx + arrowSize / 2, rect.bottom) // Kanan bawah lancip
      ..lineTo(center.dx, rect.bottom + arrowSize) // Puncak lancip di bawah
      ..close();

    // **Buat cat untuk menggambar**
    final Paint paint = Paint()..color = Colors.blue;

    // **Gambar kotak dan lancipnya**
    canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(5)), paint);
    canvas.drawPath(trianglePath, paint);

    // **Tampilkan teks nilai slider**
    final Offset textOffset = Offset(center.dx - (labelPainter.width / 2), rect.top + 5);
    labelPainter.paint(canvas, textOffset);
  }
}


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
          CustomCheckbox(
            items: ['Flutter', 'Dart', 'React'],
            type: CheckboxType.single,
            onChanged: (selected) {
              print(selected); // Menampilkan daftar item yang dipilih
            },
          ),
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
                activeColor: Colors.blueAccent,
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Volume: ${_sliderValue.toInt()}%",
                  style: TextStyle(fontSize: 18)),
            //   SliderTheme(
            //     data: SliderTheme.of(context).copyWith(
            //       valueIndicatorShape: CustomSliderValueIndicator(), // Pakai indikator custom
            // showValueIndicator: ShowValueIndicator.always, // Selalu tampilkan

            //       trackHeight: 10, // Tinggi garis slider
            //       activeTrackColor: primary,
            //       inactiveTrackColor: const Color.fromARGB(76, 64, 195, 255),
            //       thumbColor: primary,
            //     ),
            //     child: Slider(
            //       divisions: 100, // Membuat slider memiliki step angka
            //       label: _sliderValue
            //           .round()
            //           .toString(), // Menampilkan angka di atas thumb

            //       value: _sliderValue,
            //       min: 0,
            //       max: 100,
            //       onChanged: (value) {
            //         setState(() {
            //           _sliderValue = value;
            //         });
            //       },
            //     ),
            //   ),
              CustomSlider(
                max: 100,
                thumbColor: primary,
                inactiveColor: const Color.fromARGB(76, 64, 195, 255),
                value: _sliderValue,
                onChanged: (value) {
                  setState(() {
                    _sliderValue = value;
                  });
                },
              ),

              // Slider(
              //   value: _sliderValue,
              //   min: 0,
              //   max: 100,
              //   divisions: 10, // Membuat slider memiliki step angka
              //   label: _sliderValue
              //       .round()
              //       .toString(), // Menampilkan angka di atas thumb

              //   onChanged: (value) {
              //     setState(() {
              //       _sliderValue = value;
              //     });
              //   },
              // ),
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
