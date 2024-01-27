import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:StudentFit/commons/button.dart';
import 'package:StudentFit/commons/colors.dart';
import '../../screens/home/home_widgets/app_bar.dart';
import 'package:email_validator/email_validator.dart';
import '../../screens/home/home_widgets/side_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/userAuthentication.dart'; // Import UserAuthentication

class EditProfilePage extends StatefulWidget {
  final File? image;
  final Function(File? image)? onImageChanged;

  EditProfilePage({required this.image, this.onImageChanged});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? _tempImage;
  String? userName;
  String? userEmail;
  int? userId; // Variable to store user ID
  bool isClicked = false;
  bool isPasswordVisible = false;
  bool validateInputEmail = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tempImage = widget.image;
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString('user');
    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);
      setState(() {
        userName = userData['user_name'];
        userEmail = userData['user_email'];
        userId = userData['user_id'];
        _nameController.text = userName!;
        _emailController.text = userEmail!;
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _tempImage = File(pickedFile.path);
      });
    }
  }

  Widget buildTextField(
    String hintText,
    IconData icon,
    TextInputType keyboardType,
    ValueChanged<String>? onChanged,
    bool isPassword,
    VoidCallback onToggleVisibility,
    double width,
    bool validateInput,
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
              controller:
                  hintText == 'Full name ' ? _nameController : _emailController,
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

  Future<void> _updateProfile() async {
    if (userId != null) {
      String newName = _nameController.text;
      String newEmail = _emailController.text;

      String result =
          await UserAuthentication.updateUserDetails(userId!, newName);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Updated name!")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("User ID is not available")));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar2(
        appBarTitle: 'Edit Profile',
        showFavoriteIcon: false,
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
              Text(
                userName ?? 'Default Name',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Inter',
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                userEmail ?? 'example@example.com',
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
                  userName = value;
                },
                false,
                () {},
                screenWidth * 0.9,
                true,
              ),
              const SizedBox(height: 40),
              buildTextField(
                'Email ',
                Icons.email,
                TextInputType.emailAddress,
                (value) {
                  userEmail = value;
                  bool isValid = EmailValidator.validate(value);
                  setState(() {
                    validateInputEmail = isValid;
                  });
                },
                false,
                () {},
                screenWidth * 0.9,
                validateInputEmail,
              ),
              const SizedBox(height: 50),
              CustomElevatedButton2(
                buttonText: 'Confirm',
                onPressed: _updateProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
