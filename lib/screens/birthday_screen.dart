import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:signup_flow/models/user_data.dart';

class BirthdayScreen extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  final UserData userData;

  const BirthdayScreen({
    Key? key,
    required this.onNext,
    required this.onBack,
    required this.userData,
  }) : super(key: key);

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  late DateTime selectedDate;
  late FixedExtentScrollController _monthController;
  late FixedExtentScrollController _dayController;
  late FixedExtentScrollController _yearController;
  
  final List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  @override
  void initState() {
    super.initState();
    selectedDate = widget.userData.birthday ?? DateTime(2021, 9, 17);
    
    _monthController = FixedExtentScrollController(initialItem: selectedDate.month - 1);
    _dayController = FixedExtentScrollController(initialItem: selectedDate.day - 1);
    _yearController = FixedExtentScrollController(
      initialItem: selectedDate.year - (DateTime.now().year - 100),
    );
  }

  @override
  void dispose() {
    _monthController.dispose();
    _dayController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  void _submitForm() {
    widget.userData.birthday = selectedDate;
    widget.onNext();
  }

  void _updateSelectedDate({int? month, int? day, int? year}) {
    final newMonth = month ?? selectedDate.month;
    final newYear = year ?? selectedDate.year;
    
    // Calculate the maximum day for the new month/year
    final maxDay = _getDaysInMonth(newMonth, newYear);
    final newDay = (day ?? selectedDate.day) > maxDay ? maxDay : (day ?? selectedDate.day);
    
    setState(() {
      selectedDate = DateTime(newYear, newMonth, newDay);
      
      // If the day changed because the month doesn't have enough days,
      // update the day controller position
      if (day != null && day != newDay) {
        _dayController.jumpToItem(newDay - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: widget.onBack,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Text(
                "When's your birthday?",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                "We'd love to know!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              SizedBox(
                height: 200,
                child: Row(
                  children: [
                    // Month picker
                    Expanded(
                      child: CupertinoPicker(
                        itemExtent: 40,
                        backgroundColor: Colors.white,
                        selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
                          background: Colors.transparent,
                        ),
                        onSelectedItemChanged: (int index) {
                          _updateSelectedDate(month: index + 1);
                        },
                        scrollController: _monthController,
                        children: _months.map((month) => 
                          Center(
                            child: Text(
                              month,
                              style: const TextStyle(fontSize: 18),
                            ),
                          )
                        ).toList(),
                      ),
                    ),
                    // Day picker
                    Expanded(
                      child: CupertinoPicker(
                        itemExtent: 40,
                        backgroundColor: Colors.white,
                        selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
                          background: Colors.transparent,
                        ),
                        onSelectedItemChanged: (int index) {
                          _updateSelectedDate(day: index + 1);
                        },
                        scrollController: _dayController,
                        children: List<Widget>.generate(
                          _getDaysInMonth(selectedDate.month, selectedDate.year),
                          (index) => Center(
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Year picker
                    Expanded(
                      child: CupertinoPicker(
                        itemExtent: 40,
                        backgroundColor: Colors.white,
                        selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
                          background: Colors.transparent,
                        ),
                        onSelectedItemChanged: (int index) {
                          _updateSelectedDate(year: DateTime.now().year - 100 + index);
                        },
                        scrollController: _yearController,
                        children: List<Widget>.generate(
                          120, // 120 years range
                          (index) => Center(
                            child: Text(
                              '${DateTime.now().year - 100 + index}',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 40),
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFE53935).withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE53935),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _getDaysInMonth(int month, int year) {
    if (month == 2) {
      if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
        return 29;
      }
      return 28;
    }
    if ([4, 6, 9, 11].contains(month)) {
      return 30;
    }
    return 31;
  }
}

