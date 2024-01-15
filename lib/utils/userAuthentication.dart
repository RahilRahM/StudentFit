import 'dart:convert';
import '../main.dart';
import '../models/user.dart';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';
import '../constants/endpoints.dart';

class UserAuthentication {
  static String hashPassword(String password, String salt) {
    var bytes = utf8.encode(password + salt);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  static Future<User?> getLoggedUser() async {
    String? userInfoString = prefs?.getString('user');

    if (userInfoString != null) {
      Map<String, dynamic> userInfo = jsonDecode(userInfoString);

      int? uid = userInfo['user_id'];
      String? name = userInfo['user_name'];
      String? email = userInfo['user_email'];
      String? password = userInfo['user_password'];

      if (uid != null &&
          email != null &&
          name != null &&
          password != null &&
          email.isNotEmpty &&
          password.isNotEmpty) {
        return User(uid: uid, name: name, email: email, password: password);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<String> loginUser(String email, String password) async {
    String hashedPassword = hashPassword(password, 'unique_salt_for_each_user');
    Map<String, dynamic> form_data = {
      'email': email,
      'password': hashedPassword
    };

    var response = await dio.post(api_endpoint_user_login,
        data: FormData.fromMap(form_data));

    print(response);
    String error_msg = '';
    Map ret_data = jsonDecode(response.toString());
    if (ret_data['status'] == 200) {
      Map<String, dynamic> data = ret_data['data'];
      print(ret_data);
      if (prefs != null) {
        // Create a map to store user info
        Map<String, dynamic> user = {
          'user_id': data['id'],
          'user_name':  data['name'],
          'user_email': data['email'],
          'user_password': data['password'],
        };
        // Save the map to preferences
        prefs!.setString('user', jsonEncode(user));
      }
      return 'success';
    }
    error_msg = ret_data['message'];
    return '$error_msg';
  }

  static Future<bool> logoutUser(User user) async {
    await Future.delayed(Duration(seconds: 5));
    await prefs!.setBool('isLoggedIn', false);
    return true;
  }

  static Future<Map<String, dynamic>> signupUser(Map data) async {
    String name = data['name'];
    print('Name before creating form_data: $name');
    String password = data['password'];
    String hashedPassword = hashPassword(password, 'unique_salt_for_each_user');

    if (!isPasswordValid(password)) {
      return {'status': 'error', 'message': 'Provide a valid password'};
    }

    Map<String, dynamic> form_data = {
      'name': name,
      'email': data['email'],
      'password': hashedPassword,
    };

    try {
      var response = await dio.post(api_endpoint_user_sign,
          data: FormData.fromMap(form_data));

      print(response);

      if (response.statusCode == 200) {
        Map<String, dynamic>? ret_data = jsonDecode(response.toString());

        if (ret_data != null && ret_data['status'] == 200) {
          if (ret_data['message'] == 'User already exists') {
            return {'status': 'error', 'message': 'email_exists'};
          } else {
            Map<String, dynamic>? userData = ret_data['data'];

            if (userData != null) {
              // Save user data to preferences
              if (prefs != null) {
                Map<String, dynamic> user = {
                  'user_id': userData['id'],
                  'user_name': userData['name'],
                  'user_email': userData['email'],
                  'user_password': userData['password'],
                };
                prefs!.setString('user', jsonEncode(user));
              }

              return {'status': 'success', 'userId': userData['id']};
            } else {
              return {'status': 'error', 'message': 'User data is missing'};
            }
          }
        } else {
          return {
            'status': 'error',
            'message': '${ret_data?['status']} - ${ret_data?['message']}'
          };
        }
      } else {
        return {
          'status': 'error',
          'message': '${response.statusCode} - ${response.statusMessage}'
        };
      }
    } catch (error) {
      return {'status': 'error', 'message': '$error'};
    }
  }

  static Future<String> getUserInfo(int userId) async {
    try {
      var response = await dio.get(
        api_endpoint_user_get_info,
        queryParameters: {'user_id': userId},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> retData = jsonDecode(response.data);
        if (retData['status'] == 200) {
          // Save user info and weight to preferences
          if (prefs != null) {
            Map<String, dynamic> userInfo = retData['user_info'][0];
            var weightRecords = retData['weight'];

            if (weightRecords.isNotEmpty) {
              int weight = weightRecords[0]['weight'];

              // Create a map to store user info
              Map<String, dynamic> user_info = {
                'height': userInfo['height'],
                'weight': weight,
                'gender': userInfo['gender'],
                'age': userInfo['age'],
              };
              // Save the map to preferences
              prefs!.setString('user_info', jsonEncode(user_info));
            }
          }
          return 'success';
        } else {
          return '${retData['status']} - ${retData['message']}';
        }
      } else {
        return '${response.statusCode} - ${response.statusMessage}';
      }
    } catch (error) {
      return '$error';
    }
  }

  static Future<String> insertGender(int user_id, String gender) async {
    Map<String, dynamic> form_data = {
      'user_id': user_id,
      'gender': gender,
    };
    print(form_data);

    try {
      var response = await dio.post(
        api_endpoint_user_insert_gender,
        data: FormData.fromMap(form_data),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> retData = jsonDecode(response.data);
        if (retData['status'] == 200) {
          if (retData['data'] != null) {
            List<Map<String, dynamic>> data = retData['data'];
            print(data);
            if (data.isNotEmpty) {
              String? userInfoString = prefs?.getString('user_info');
              if (userInfoString != null) {
                Map<String, dynamic> userInfo = jsonDecode(userInfoString);
                userInfo['gender'] = data[0]['gender'];
                prefs!.setString('user_info', jsonEncode(userInfo));
              }
            }
          }
          return 'success';
        } else {
          return '${retData['status']} - ${retData['message']}';
        }
      } else {
        return '${response.statusCode} - ${response.statusMessage}';
      }
    } catch (error) {
      return '$error';
    }
  }

  static Future<String> insertAge(int userId, int age) async {
    Map<String, dynamic> formData = {
      'user_id': userId,
      'age': age,
    };
    print(formData);

    try {
      var response = await dio.post(
        api_endpoint_user_insert_age,
        data: FormData.fromMap(formData),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> retData = jsonDecode(response.data);

        if (retData['status'] == 200) {
          if (retData['data'] != null) {
            List<Map<String, dynamic>> data = retData['data'];
            if (data.isNotEmpty) {
              String? userInfoString = prefs?.getString('user_info');
              if (userInfoString != null) {
                Map<String, dynamic> userInfo = jsonDecode(userInfoString);
                userInfo['age'] = data[0]['age'];
                prefs!.setString('user_info', jsonEncode(userInfo));
              }
            }
          }

          return 'success';
        } else {
          return '${retData['status']} - ${retData['message']}';
        }
      } else {
        return '${response.statusCode} - ${response.statusMessage}';
      }
    } catch (error) {
      return '$error';
    }
  }

  static Future<String> insertHeight(int userId, int height) async {
    Map<String, dynamic> formData = {
      'user_id': userId,
      'height': height,
    };
    print(formData);

    try {
      var response = await dio.post(
        api_endpoint_user_insert_height,
        data: FormData.fromMap(formData),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> retData = jsonDecode(response.data);

        if (retData['status'] == 200) {
          if (retData['data'] != null) {
            List<Map<String, dynamic>> data = retData['data'];
            if (data.isNotEmpty) {
              String? userInfoString = prefs?.getString('user_info');
              if (userInfoString != null) {
                Map<String, dynamic> userInfo = jsonDecode(userInfoString);
                userInfo['height'] = data[0]['height'];
                prefs!.setString('user_info', jsonEncode(userInfo));
              }
            }
          }

          return 'success';
        } else {
          return '${retData['status']} - ${retData['message']}';
        }
      } else {
        return '${response.statusCode} - ${response.statusMessage}';
      }
    } catch (error) {
      return '$error';
    }
  }

  static Future<String> insertWeight(int userId, int weight) async {
    Map<String, dynamic> formData = {
      'user_id': userId,
      'weight': weight,
    };
    print(formData);

    try {
      var response = await dio.post(
        api_endpoint_user_insert_weight,
        data: FormData.fromMap(formData),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> retData = jsonDecode(response.data);

        if (retData['status'] == 200) {
          if (retData['data'] != null) {
            List<Map<String, dynamic>> data = retData['data'];
            if (data.isNotEmpty) {
              String? userInfoString = prefs?.getString('user_info');
              if (userInfoString != null) {
                Map<String, dynamic> userInfo = jsonDecode(userInfoString);
                userInfo['weight'] = data[0]['weight'];
                prefs!.setString('user_info', jsonEncode(userInfo));
              }
            }
          }

          return 'success';
        } else {
          return '${retData['status']} - ${retData['message']}';
        }
      } else {
        return '${response.statusCode} - ${response.statusMessage}';
      }
    } catch (error) {
      return '$error';
    }
  }

  static bool isPasswordValid(String password) {
    return password.contains(RegExp(r'\d'));
  }
}
