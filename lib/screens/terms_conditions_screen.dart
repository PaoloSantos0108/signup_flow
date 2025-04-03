import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Terms and Conditions',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Divider(height: 1),
          InkWell(
            onTap: () {
              // Send terms by email logic
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              alignment: Alignment.center,
              child: const Text(
                'Send by Email',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'IMPORTANT',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Please read the following terms. By proceeding with this sign up process, you are agreeing to be bound by the Teleo Terms and Conditions.',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'A. Teleo Terms and Conditions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const Divider(height: 32),
                  const Text(
                    'Welcome to Teleo! These Terms and Conditions govern your use of our application and services. By accessing or using our services, you agree to be bound by these terms.',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 16),
                  _buildBulletPoint('You must be at least 12 years old to use our services.'),
                  _buildBulletPoint('You agree not to misuse our services or use them for any illegal or unauthorized purposes.'),
                  _buildBulletPoint('We reserve the right to suspend or terminate access to our services for any violation of these terms.'),
                  const SizedBox(height: 16),
                  _buildBulletPoint('All content, trademarks, and intellectual property on our platform are owned by Teleo or licensed to us.'),
                  _buildBulletPoint('You may not copy, distribute, or exploit any part of our content without our prior written permission.'),
                  const SizedBox(height: 16),
                  _buildBulletPoint('We do not guarantee the accuracy, completeness, or reliability of our services.'),
                  _buildBulletPoint('We are not liable for any direct, indirect, or incidental damages arising from your use of our services.'),
                  const SizedBox(height: 16),
                  _buildBulletPoint('Your use of our services is also governed by our Privacy Policy, which explains how we collect, use, and protect your data.'),
                  const SizedBox(height: 16),
                  _buildBulletPoint('We reserve the right to update or modify these terms at any time. Changes will be effective upon posting on our website.'),
                  _buildBulletPoint('Continued use of our services after any modifications constitutes acceptance of the new terms.'),
                  const SizedBox(height: 16),
                  _buildBulletPoint('These terms are governed by the laws of R.A. 8293.'),
                  _buildBulletPoint('Any disputes arising under these terms will be subject to the exclusive jurisdiction of the courts in R.A. 7394.'),
                  const SizedBox(height: 24),
                  const Text(
                    'If you have any questions about these terms, please contact us at teleo@gmail.com.',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'By using our services, you acknowledge that you have read, understood, and agreed to these Terms and Conditions.',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}

