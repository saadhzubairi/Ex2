import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../models/models.dart';
import '../components/grocery_tile.dart';

class GroceryItemScreen extends StatefulWidget {
  final Function(GroceryItem) onCreate;
  final Function(GroceryItem) onUpdate;
  final GroceryItem? originalItem;
  final bool isUpdating;

  const GroceryItemScreen({
    Key? key,
    required this.onCreate,
    required this.onUpdate,
    this.originalItem,
  })  : isUpdating = (originalItem != null),
        super(key: key);

  @override
  State<GroceryItemScreen> createState() => _GroceryItemScreenState();
}

class _GroceryItemScreenState extends State<GroceryItemScreen> {
  final _nameController = TextEditingController();
  String _name = '';
  Importance _importance = Importance.low;
  DateTime _dueDate = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  Color _currentColor = Colors.green;
  int _currentSliderValue = 0;

  void initState() {
    final originalItem = widget.originalItem;
    if (originalItem != null) {
      _nameController.text = originalItem.name;
      _name = originalItem.name;
      _currentSliderValue = originalItem.quantity;
      _importance = originalItem.importance;
      _currentColor = originalItem.color;
      _timeOfDay = TimeOfDay(
          hour: originalItem.date.hour, minute: originalItem.date.minute);
      _dueDate = originalItem.date;
    }

    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.purple,
        actions: [
          IconButton(
            onPressed: () {
              // 1
              final groceryItem = GroceryItem(
                id: widget.originalItem?.id ?? const Uuid().v1(),
                name: _nameController.text,
                importance: _importance,
                color: _currentColor,
                quantity: _currentSliderValue,
                date: DateTime(
                  _dueDate.year,
                  _dueDate.month,
                  _dueDate.day,
                  _timeOfDay.hour,
                  _timeOfDay.minute,
                ),
              );
              if (widget.isUpdating) {
                // 2
                widget.onUpdate(groceryItem);
              } else {
                // 3
                widget.onCreate(groceryItem);
              }
            },
            icon: const Icon(Icons.check),
          ),
        ],
        elevation: 0.0,
        title: Text(
          "Grocery Item",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(26),
        child: ListView(
          children: [
            buildNameField(),
            const SizedBox(height: 25),
            buildImportanceField(),
            const SizedBox(height: 5),
            buildDateField(context),
            const SizedBox(height: 15),
            buildTimeField(context),
            const SizedBox(height: 15),
            buildColorPicker(context),
            const SizedBox(height: 25),
            Positioned(
              child: buildQuantityField(),
              bottom: 10,
            ),
            const SizedBox(height: 15),
            GroceryTile(
              item: GroceryItem(
                id: 'previewMode',
                name: _name,
                importance: _importance,
                color: _currentColor,
                quantity: _currentSliderValue,
                date: DateTime(
                  _dueDate.year,
                  _dueDate.month,
                  _dueDate.day,
                  _timeOfDay.hour,
                  _timeOfDay.minute,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Item Name',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        TextField(
          controller: _nameController,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w300,
          ),
          cursorColor: _currentColor,
          decoration: InputDecoration(
            hintText: "E.g Apples, Bananas, Meat",
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildImportanceField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Item Name',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Wrap(
          spacing: 10.0,
          children: [
            ChoiceChip(
              selectedColor: Colors.black,
              // 6
              selected: _importance == Importance.low,
              label: const Text(
                'low',
                style: TextStyle(color: Colors.white),
              ),
              // 7
              onSelected: (selected) {
                setState(() => _importance = Importance.low);
              },
            ),
            ChoiceChip(
              selectedColor: Colors.black,
              selected: _importance == Importance.medium,
              label: const Text(
                'medium',
                style: TextStyle(color: Colors.white),
              ),
              onSelected: (selected) {
                setState(() => _importance = Importance.medium);
              },
            ),
            ChoiceChip(
              selectedColor: Colors.black,
              selected: _importance == Importance.high,
              label: const Text(
                'high',
                style: TextStyle(color: Colors.white),
              ),
              onSelected: (selected) {
                setState(() => _importance = Importance.high);
              },
            ),
          ],
        )
      ],
    );
  }

  Widget buildDateField(BuildContext context) {
    // 1
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 2
        Row(
          // 3
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 4
            Text(
              'Date',
              style: GoogleFonts.montserrat(
                  fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
            // 5
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(_currentColor),
                ),
                // 6
                onPressed: () async {
                  final currentDate = DateTime.now();
                  // 7
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: currentDate,
                    firstDate: currentDate,
                    lastDate: DateTime(currentDate.year + 5),
                  );
                  // 8
                  setState(() {
                    if (selectedDate != null) {
                      _dueDate = selectedDate;
                    }
                  });
                },
                child: Text(
                  'SELECT',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        // 9
        Text(
          DateFormat('yyyy-MM-dd').format(_dueDate),
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.italic,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget buildTimeField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Time of Day',
              style: GoogleFonts.montserrat(
                  fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(_currentColor),
                ),
                child: Text(
                  'SELECT',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  // 1
                  final timeOfDay = await showTimePicker(
                    // 2
                    initialTime: TimeOfDay.now(),
                    context: context,
                  );
                  // 3
                  setState(() {
                    if (timeOfDay != null) {
                      _timeOfDay = timeOfDay;
                    }
                  });
                },
              ),
            ),
          ],
        ),
        Text(
          _timeOfDay.format(context),
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.italic,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget buildColorPicker(BuildContext context) {
    // 1
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 2
        Row(
          children: [
            Container(
              height: 50.0,
              width: 20.0,
              color: _currentColor,
            ),
            SizedBox(
              width: 15,
            ),
            const SizedBox(width: 8.0),
            Text(
              'Color',
              style: GoogleFonts.montserrat(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        // 3
        Container(
          padding: const EdgeInsets.only(
            right: 10,
          ),
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(_currentColor),
            ),
            onPressed: () {
              // 4
              showDialog(
                context: context,
                builder: (context) {
                  // 5
                  return AlertDialog(
                    content: BlockPicker(
                      pickerColor: Colors.white,
                      // 6
                      onColorChanged: (color) {
                        setState(() => _currentColor = color);
                      },
                    ),
                    actions: [
                      // 7
                      Container(
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(_currentColor),
                          ),
                          child: Text(
                            'SAVE',
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text('SELECT',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.white,
                )),
          ),
        ),
      ],
    );
  }

  Widget buildQuantityField() {
    // 1
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 2
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              'Quantity',
              style: GoogleFonts.montserrat(
                  fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 16.0),
            Text(
              _currentSliderValue.toInt().toString(),
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.italic,
                fontSize: 20,
              ),

              /*  */
            ),
          ],
        ),
        // 3
        Slider(
          // 4
          inactiveColor: _currentColor.withOpacity(0.5),
          activeColor: _currentColor,
          // 5
          value: _currentSliderValue.toDouble(),
          // 6
          min: 0.0,
          max: 100.0,
          // 7
          divisions: 100,
          // 8
          label: _currentSliderValue.toInt().toString(),
          // 9
          onChanged: (double value) {
            setState(
              () {
                _currentSliderValue = value.toInt();
              },
            );
          },
        ),
      ],
    );
  }
}
