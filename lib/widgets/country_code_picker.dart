import 'package:flutter/material.dart';

class CountryCode {
  final String name;
  final String dialCode;
  final String flag;

  CountryCode({
    required this.name,
    required this.dialCode,
    required this.flag,
  });
}

class CountryCodePicker extends StatefulWidget {
  final Function(CountryCode) onChanged;
  final CountryCode initialSelection;

  const CountryCodePicker({
    Key? key,
    required this.onChanged,
    required this.initialSelection,
  }) : super(key: key);

  @override
  State<CountryCodePicker> createState() => _CountryCodePickerState();
}

class _CountryCodePickerState extends State<CountryCodePicker> {
  late CountryCode _selectedCountry;
  
  // List of common country codes
  final List<CountryCode> _countryCodes = [
    CountryCode(name: 'Philippines', dialCode: '+63', flag: '🇵🇭'),
    CountryCode(name: 'United States', dialCode: '+1', flag: '🇺🇸'),
    CountryCode(name: 'United Kingdom', dialCode: '+44', flag: '🇬🇧'),
    CountryCode(name: 'Australia', dialCode: '+61', flag: '🇦🇺'),
    CountryCode(name: 'Canada', dialCode: '+1', flag: '🇨🇦'),
    CountryCode(name: 'China', dialCode: '+86', flag: '🇨🇳'),
    CountryCode(name: 'India', dialCode: '+91', flag: '🇮🇳'),
    CountryCode(name: 'Japan', dialCode: '+81', flag: '🇯🇵'),
    CountryCode(name: 'Singapore', dialCode: '+65', flag: '🇸🇬'),
    CountryCode(name: 'South Korea', dialCode: '+82', flag: '🇰🇷'),
    CountryCode(name: 'Malaysia', dialCode: '+60', flag: '🇲🇾'),
    CountryCode(name: 'Indonesia', dialCode: '+62', flag: '🇮🇩'),
    CountryCode(name: 'Thailand', dialCode: '+66', flag: '🇹🇭'),
    CountryCode(name: 'Vietnam', dialCode: '+84', flag: '🇻🇳'),
  ];

  @override
  void initState() {
    super.initState();
    _selectedCountry = widget.initialSelection;
  }

  void _showCountryPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Select Country Code',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: _countryCodes.length,
                  itemBuilder: (context, index) {
                    final country = _countryCodes[index];
                    return ListTile(
                      leading: Text(
                        country.flag,
                        style: const TextStyle(fontSize: 24),
                      ),
                      title: Text(country.name),
                      trailing: Text(
                        country.dialCode,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _selectedCountry = country;
                        });
                        widget.onChanged(country);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _showCountryPicker,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _selectedCountry.flag,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(width: 8),
            Text(
              _selectedCountry.dialCode,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

