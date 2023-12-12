import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_fit/commons/button.dart';
import 'package:student_fit/commons/colors.dart';
import '../../screens/home/home_widgets/app_bar.dart';
import 'package:email_validator/email_validator.dart';
import '../../screens/home/home_widgets/side_bar.dart';

class EditProfilePage extends StatefulWidget {
  final File? image;
  final Function(File? image)? onImageChanged; // Add this line

  EditProfilePage({required this.image, this.onImageChanged});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? _tempImage;

  bool isClicked = false;

  @override
  void initState() {
    super.initState();
    _tempImage = widget.image; // Initialize with the existing image
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _tempImage = File(pickedFile.path); // Update the temporary image
      });
    }
  }

  bool isPasswordVisible = false;
  bool validateInputEmail = true;
  Widget buildTextField(
    String hintText,
    IconData icon,
    TextInputType keyboardType,
    ValueChanged<String>? onChanged,
    bool isPassword,
    VoidCallback onToggleVisibility,
    double width,
    bool validateInput, // New parameter for validation
  ) {
    return Container(
      width: width,
      height: 65,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        border: Border.all(
          color: isPassword
              ? AppColors.primaryColor
              : validateInput
                  ? AppColors.primaryColor
                  : Colors.red,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 30,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              obscureText: isPassword && !isPasswordVisible,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
              ),
              keyboardType: keyboardType,
              onChanged: onChanged,
            ),
          ),
          if (isPassword)
            IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: AppColors.primaryColor,
              ),
              onPressed: onToggleVisibility,
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar2(
        appBarTitle: 'Edit Profile',
        showFavoriteIcon: false,
        onFavoritePressed: () {
          // Handle favorite pressed
        },
        leadingIcon: Icons.arrow_back_ios,
        onLeadingPressed: () {
          Navigator.pop(context);
        },
        actions: [],
      ),
      drawer: buildDrawer(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 120.0,
                height: 120.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2.0),
                ),
                child: _tempImage != null
                    ? Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          ClipOval(
                            child: Image.file(
                              _tempImage!,
                              width: 120.0,
                              height: 120.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          InkWell(
                            onTap: _pickImage,
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                size: 20.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      )
                    : InkWell(
                        onTap: _pickImage,
                        child: const Center(
                          child: Icon(
                            Icons.camera_alt,
                            size: 40.0,
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Lilia Amk',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Inter',
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'liliaamk@example.com',
                style: TextStyle(
                  color: Color(0xFF71839B),
                  fontFamily: 'Inter',
                  fontSize: 15.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 70),
              buildTextField(
                'Full name ',
                Icons.person,
                TextInputType.text,
                (value) {
                  // Handle name input
                },
                false,
                () {},
                screenWidth * 0.9,
                true, // Set validation to false for full name
              ),
              const SizedBox(height: 40),
              buildTextField(
                'Email ',
                Icons.email,
                TextInputType.emailAddress,
                (value) {
                  bool isValid = EmailValidator.validate(value);
                  setState(() {
                    validateInputEmail = isValid;
                  });
                },
                false,
                () {},
                screenWidth * 0.9,
                validateInputEmail, // Use the validateInputEmail variable for email validation
              ),
              const SizedBox(height: 50),
              CustomElevatedButton2(
                buttonText: 'Confirm',
                onPressed: () {
                  // Update the parent widget with the confirmed image
                  widget.onImageChanged?.call(_tempImage);
                  // Navigate back
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
