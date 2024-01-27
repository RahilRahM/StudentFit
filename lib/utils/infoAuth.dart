import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/endpoints.dart';

class InfoAuth {
  static Future<String> saveWeightRecord(int weight) async {
    final prefs = await SharedPreferences.getInstance();
  
    // Retrieve user info from SharedPreferences
    String? userString = prefs.getString('user');
    if (userString == null) {
      return 'User not found in SharedPreferences';
    }
    Map<String, dynamic> user = jsonDecode(userString);
    int userId = user['user_id']; // Extract the userId

    Map<String, dynamic> formData = {
      'user_id': userId,
      'weight': weight,
    };

    try {
      var response = await Dio().post(
        api_endpoint_user_insert_weight,
        data: FormData.fromMap(formData),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> retData = jsonDecode(response.data.toString());
        if (retData['status'] == 200) {
          // Update user_info with the new weight
          String? userInfoString = prefs.getString('user_info');
          if (userInfoString != null) {
            Map<String, dynamic> userInfo = jsonDecode(userInfoString);
            userInfo['weight'] = weight;
            await prefs.setString('user_info', jsonEncode(userInfo)); // Save updated info
          }

          // Handle weight records
          String? weightRecordsString = prefs.getString('weight_records');
          List<Map<String, dynamic>> weightRecords = weightRecordsString != null
              ? List<Map<String, dynamic>>.from(json.decode(weightRecordsString))
              : [];

          // Add the new weight record with a timestamp
          final newWeightRecord = {
            'weight': weight,
            'timestamp': DateTime.now().toIso8601String(),
          };
          weightRecords.add(newWeightRecord);
          
          // Save the updated weight records list
          await prefs.setString('weight_records', jsonEncode(weightRecords));

          return 'success';
        } else {
          return '${retData['status']} - ${retData['message']}';
        }
      } else {
        return 'Error: ${response.statusCode} - ${response.statusMessage}';
      }
    } catch (error) {
      return 'Exception: $error';
    }
  }

  static Future<String> updateHeightRecord(int height) async {
    final prefs = await SharedPreferences.getInstance();

    // Retrieve user info from SharedPreferences
    String? userString = prefs.getString('user');
    if (userString == null) {
      return 'User not found in SharedPreferences';
    }
    Map<String, dynamic> user = jsonDecode(userString);
    int userId = user['user_id']; // Extract the userId

    Map<String, dynamic> formData = {
      'user_id': userId,
      'height': height,
    };

    try {
      var response = await Dio().post(
        api_endpoint_user_insert_height, // Your API endpoint to update height
        data: FormData.fromMap(formData),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> retData = jsonDecode(response.data.toString());
        if (retData['status'] == 200) {
          // Update user_info with the new height
          String? userInfoString = prefs.getString('user_info');
          if (userInfoString != null) {
            Map<String, dynamic> userInfo = jsonDecode(userInfoString);
            userInfo['height'] = height;
            await prefs.setString('user_info', jsonEncode(userInfo)); // Save updated info
          }

          return 'success';
        } else {
          return '${retData['status']} - ${retData['message']}';
        }
      } else {
        return 'Error: ${response.statusCode} - ${response.statusMessage}';
      }
    } catch (error) {
      return 'Exception: $error';
    }
  }
}
