import 'package:flutter/material.dart';
import 'package:signup_flow/models/user_data.dart';
import 'package:signup_flow/screens/welcome_screen.dart';
import 'package:signup_flow/screens/name_screen.dart';
import 'package:signup_flow/screens/birthday_screen.dart';
import 'package:signup_flow/screens/gender_screen.dart';
import 'package:signup_flow/screens/username_screen.dart';
import 'package:signup_flow/screens/contact_screen.dart';
import 'package:signup_flow/screens/password_screen.dart';
import 'package:signup_flow/screens/verification_screen.dart';
import 'package:signup_flow/screens/profile_photo_screen.dart';
import 'package:signup_flow/screens/success_screen.dart';

class SignUpFlow extends StatefulWidget {
  const SignUpFlow({Key? key}) : super(key: key);

  @override
  State<SignUpFlow> createState() => _SignUpFlowState();
}

class _SignUpFlowState extends State<SignUpFlow> {
  final PageController _pageController = PageController();
  final UserData _userData = UserData();
  int _currentPage = 0;

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      WelcomeScreen(onNext: _nextPage), // Remove onBack for WelcomeScreen
      NameScreen(onNext: _nextPage, onBack: _previousPage, userData: _userData),
      BirthdayScreen(onNext: _nextPage, onBack: _previousPage, userData: _userData),
      GenderScreen(onNext: _nextPage, onBack: _previousPage, userData: _userData),
      UsernameScreen(onNext: _nextPage, onBack: _previousPage, userData: _userData),
      ContactScreen(onNext: _nextPage, onBack: _previousPage, userData: _userData),
      PasswordScreen(onNext: _nextPage, onBack: _previousPage, userData: _userData),
      VerificationScreen(onNext: _nextPage, onBack: _previousPage, userData: _userData),
      ProfilePhotoScreen(onNext: _nextPage, onBack: _previousPage, userData: _userData),
      SuccessScreen(userData: _userData),
    ]);
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage++;
      });
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage--;
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(), // Prevent swiping between pages
      children: _pages,
    );
  }
}

