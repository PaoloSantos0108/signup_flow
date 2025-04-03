import 'package:flutter/material.dart';
import 'package:signup_flow/models/user_data.dart';
import 'package:signup_flow/utils/validators.dart';
import 'package:signup_flow/widgets/country_code_picker.dart';

class ContactScreen extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  final UserData userData;

  const ContactScreen({
    Key? key,
    required this.onNext,
    required this.onBack,
    required this.userData,
  }) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isFormValid = false;
  late CountryCode _selectedCountryCode;

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.userData.email ?? '';
    
    // Initialize country code and phone number
    _selectedCountryCode = CountryCode(
      name: 'Philippines',
      dialCode: '+63',
      flag: '🇵🇭',
    );
    
    if (widget.userData.phoneNumber != null && widget.userData.phoneNumber!.isNotEmpty) {
      // Extract country code and phone number if already set
      final phoneNumber = widget.userData.phoneNumber!;
      for (var code in ['+1', '+44', '+61', '+63', '+65', '+81', '+82', '+86', '+91', '+60', '+62', '+66', '+84']) {
        if (phoneNumber.startsWith(code)) {
          _selectedCountryCode = _getCountryCodeByDialCode(code);
          _phoneController.text = phoneNumber.substring(code.length);
          break;
        }
      }
      
      // If no matching code found, use the whole number
      if (_phoneController.text.isEmpty) {
        _phoneController.text = phoneNumber;
      }
    }
    
    _validateForm();

    _emailController.addListener(_validateForm);
    _phoneController.addListener(_validateForm);
  }

  CountryCode _getCountryCodeByDialCode(String dialCode) {
    // Find the country code by dial code
    final codes = [
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
    
    return codes.firstWhere(
      (code) => code.dialCode == dialCode,
      orElse: () => CountryCode(name: 'Philippines', dialCode: '+63', flag: '🇵🇭'),
    );
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _emailController.text.isNotEmpty &&
          _phoneController.text.isNotEmpty;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _isFormValid) {
      widget.userData.email = _emailController.text;
      widget.userData.phoneNumber = '${_selectedCountryCode.dialCode}${_phoneController.text}';
      widget.onNext();
    } else {
      // Show validation error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields correctly'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
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
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Let's keep in touch!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "You'll need this to login",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 48),
                const Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _emailController,
                  hintText: 'example@email.com',
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.validateEmail,
                ),
                const SizedBox(height: 24),
                const Text(
                  "Phone Number",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _buildPhoneField(),
                const Spacer(),
                Container(
                  width: double.infinity,
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
                      backgroundColor: _isFormValid ? const Color(0xFFE53935) : Colors.grey,
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
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[400]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE53935), width: 2.0),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      cursorColor: const Color(0xFFE53935),
    );
  }

  Widget _buildPhoneField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CountryCodePicker(
          initialSelection: _selectedCountryCode,
          onChanged: (CountryCode countryCode) {
            setState(() {
              _selectedCountryCode = countryCode;
            });
          },
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Phone number is required';
              }
              // Check if the string contains only digits
              final phoneRegex = RegExp(r'^[0-9]+$');
              if (!phoneRegex.hasMatch(value)) {
                return 'Please enter a valid phone number';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: 'Phone number',
              hintStyle: TextStyle(color: Colors.grey[400]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE53935), width: 2.0),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            cursorColor: const Color(0xFFE53935),
          ),
        ),
      ],
    );
  }
}

