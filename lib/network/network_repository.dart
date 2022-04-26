import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:edu_books_flutter/models/book_model.dart';
import 'package:edu_books_flutter/models/comment_model.dart';
import 'package:edu_books_flutter/models/order_model.dart';
import 'package:edu_books_flutter/models/subject_model.dart';
import 'package:edu_books_flutter/models/user_model.dart';
import 'package:edu_books_flutter/network/network_service.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkRepository {
  static NetworkRepository? _instance;

  factory NetworkRepository() => _instance ?? NetworkRepository._internal();

  NetworkRepository._internal() {
    _instance = this;
  }

  Future<void> logout() async {
    String endpoint = 'api/logout';
    final api = NetworkService().getApiWithOptions(withXSRFToken: true);
    try {
      final response = await api.post(endpoint);
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Logged out');
        }
      }
    } catch (err) {
      if (err is DioError) {
        if (err.response?.statusCode == 401) {
          if (kDebugMode) {
            print('Already Unathenticated');
          }
        } else {
          rethrow;
        }
      } else {
        rethrow;
      }
    }
  }

  Future<Map<String, dynamic>> payForOrder(Map<String, dynamic> data) async {
    String endpoint = 'api/pay';
    final api = NetworkService().getApiWithOptions();
    final response = await api.post(endpoint, data: data);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseDecoded = Map.from(response.data);
      return responseDecoded;
    } else {
      throw Exception('Failed to make payment');
    }
  }

  Future<List<OrderModel>> getMyOrders() async {
    String endpoint = 'api/myorders';
    final api = NetworkService().getApiWithOptions();
    final response = await api.get(endpoint);
    if (response.statusCode == 200) {
      List<dynamic> responseDecoded = List.from(response.data);
      return responseDecoded.map((e) => OrderModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<List<BookModel>> getMyOrderBook(int id) async {
    String endpoint = 'api/order/$id';
    final api = NetworkService().getApiWithOptions();
    final response = await api.get(endpoint);
    if (response.statusCode == 200) {
      List<dynamic> responseDecoded = List.from(response.data);
      return responseDecoded.map((e) => BookModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed orders books');
    }
  }

  Future<void> deleteComment(int id) async {
    String endpoint = 'api/reviews/delete/$id';
    final api = NetworkService().getApiWithOptions();
    await api.delete(endpoint);
  }

  Future<CommentModel> createComment(Map<String, dynamic> data) async {
    String endpoint = 'api/reviews/';
    final api = NetworkService().getApiWithOptions();
    final response = await api.post(endpoint, data: data);
    if (response.statusCode == 201) {
      Map<String, dynamic> responseDecoded = Map.from(response.data);
      return CommentModel.fromJson(responseDecoded);
    } else {
      throw Exception('Failed to load comments');
    }
  }

  Future<CommentModel> updateComment(Map<String, dynamic> data) async {
    String endpoint = 'api/reviews/update';
    final api = NetworkService().getApiWithOptions();
    final response = await api.put(endpoint, data: data);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseDecoded = Map.from(response.data);
      return CommentModel.fromJson(responseDecoded);
    } else {
      throw Exception('Failed to update comments');
    }
  }

  Future<List<BookModel>> getBooks() async {
    String endpoint = 'api/books/';
    final api = NetworkService().getApiWithOptions();
    final response = await api.get(endpoint);
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> responseDecoded = List.from(response.data)
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
      return responseDecoded.map((e) => BookModel.fromJson(e)).toList();
    } else {
      throw Exception();
    }
  }

  Future<List<SubjectModel>> getSubjects() async {
    String endpoint = 'api/subjects';
    final api = NetworkService().getApiWithOptions();
    final response = await api.get(endpoint);
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> responseDecoded = List.from(response.data)
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
      return responseDecoded.map((e) => SubjectModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load subjects');
    }
  }

  Future<List<BookModel>> searchBooks(String title) async {
    String endpoint = 'api/books/search/$title';
    final api = NetworkService().getApiWithOptions();
    final response = await api.get(endpoint);
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> responseDecoded = List.from(response.data)
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
      return responseDecoded.map((e) => BookModel.fromJson(e)).toList();
    } else {
      throw Exception('Search books exception');
    }
  }

  Future<String> getPublishingHouse(int id) async {
    String endpoint = 'api/publishingHouse/$id';
    final api = NetworkService().getApiWithOptions();
    final response = await api.get(endpoint);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseDecoded =
          Map<String, dynamic>.from(response.data);
      String publishingHouse = responseDecoded['name'];

      return publishingHouse;
    } else {
      throw Exception();
    }
  }

  Future<List<dynamic>> getBook(int id) async {
    String endpoint = 'api/books/$id';
    final api = NetworkService().getApiWithOptions(withReferer: true);
    final response = await api.get(endpoint);
    if (response.statusCode == 200) {
      return List<dynamic>.from(response.data);
    } else {
      throw Exception('Failed to load book data');
    }
  }

  Future<List<int>> getViewed() async {
    var prefs = await SharedPreferences.getInstance();
    return List<int>.from(jsonDecode(prefs.getString('viewed') ?? '[]'));
  }

  Future<void> removeViewed() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove('viewed');
  }

  Future<List<int>> addNewViewed(int bookId) async {
    var prefs = await SharedPreferences.getInstance();
    List<int> viewed = await getViewed();
    viewed = viewed.where((element) => element != bookId).toList()
      ..insert(0, bookId);
    prefs.setString('viewed', jsonEncode(viewed.take(10).toList()));
    return viewed.take(10).toList();
  }

  Future<void> loadSession() async {
    bool haveCookie = await NetworkService().getSessionId();
    bool haveXSRF = await NetworkService().getXSRFToken();
    if (!haveCookie || !haveXSRF) {
      await getNewSession();
    }
  }

  Future<void> getNewSession() async {
    String endpoint = '/sanctum/csrf-cookie';
    final api = NetworkService().getApiWithOptions(isSanctum: true);
    final response = await api.get(endpoint);
    if (response.statusCode == 204) {
      List<String> cookies = response.headers['set-cookie']?.toList() ?? [];
      for (String c in cookies) {
        String mainPart = c.split(';')[0];
        await NetworkService()
            .setToShared(mainPart.split('=')[0], mainPart.split('=')[1]);
      }
      await NetworkService().getSessionId();
      await NetworkService().getXSRFToken();
    }
  }

  Future<bool> isTokenExist() async {
    return await NetworkService().getToken();
  }

  Future<void> removeToken() async {
    await NetworkService().deleteToken();
  }

  Future<Map<String, dynamic>> signUp(Map<String, dynamic> data) async {
    String endpoint = 'api/register';
    final api = NetworkService().getApiWithOptions(withXSRFToken: true);
    try {
      final response = await api.post(endpoint, data: data);
      if (response.statusCode == 201) {
        await getNewSession();
        Map<String, dynamic> responseDecoded =
            Map<String, dynamic>.from(response.data);
        await NetworkService().setToShared('token', responseDecoded['token']);
        await NetworkService().getToken();
        return {'status': 'success', 'data': responseDecoded};
      } else {
        throw Exception();
      }
    } catch (err) {
      if (err is DioError) {
        if (err.response?.statusCode == 422) {
          return {
            'status': 'error',
            'data': Map<String, dynamic>.from(err.response?.data)
          };
        } else {
          rethrow;
        }
      } else {
        rethrow;
      }
    }
  }

  Future<Map<String, dynamic>> login(Map<String, dynamic> data) async {
    String endpoint = 'api/login';
    final api = NetworkService().getApiWithOptions(withXSRFToken: true);
    try {
      final response = await api.post(endpoint, data: data);
      if (response.statusCode == 200) {
        await getNewSession();
        await getViewed();
        Map<String, dynamic> responseDecoded =
            Map<String, dynamic>.from(response.data);
        await NetworkService().setToShared('token', responseDecoded['token']);
        await NetworkService().getToken();
        return {'status': 'success', 'data': responseDecoded};
      } else {
        throw Exception();
      }
    } catch (err) {
      if (err is DioError) {
        if (err.response?.statusCode == 403) {
          return {
            'status': 'error',
            'data': Map<String, dynamic>.from(err.response?.data)
          };
        } else {
          rethrow;
        }
      } else {
        rethrow;
      }
    }
  }

  void deleteBucketBook(int id) async {
    String endpoint = 'api/cart/delete/$id';
    final api = NetworkService().getApiWithOptions(
      withXSRFToken: true,
      withReferer: true,
    );
    try {
      await api.delete(endpoint);
    } catch (_) {
      throw (Exception);
    }
  }

  // void checkPayment(Map<String, dynamic> data) async {
  //   String endpoint = 'api/pay';
  //   final api = NetworkService().getApiWithOptions(
  //     withXSRFToken: true,
  //   );
  //   try {
  //     final response = await api.post(endpoint, data: data);
  //     if (response.statusCode == 200) {
  //       if (kDebugMode) {
  //         print('Order is payed');
  //       }
  //     }
  //   } catch (err) {
  //     if (kDebugMode) {
  //       print(err);
  //     }
  //   }
  // }

  Future<List<BookModel>> getCart() async {
    String endpoint = 'api/cart';
    final api = NetworkService()
        .getApiWithOptions(withReferer: true, withXSRFToken: true);

    final response = await api.get(endpoint);
    if (response.data.toString().isNotEmpty && response.data.toString() != "") {
      if (response.statusCode == 200) {
        Map<String, dynamic> responseDecoded =
            Map<String, dynamic>.from(response.data);
        List<BookModel> booksList = [];
        for (var k in responseDecoded.keys) {
          List<dynamic> bookCoded =
              await NetworkRepository().getBook(int.parse(k));
          booksList.add(BookModel.fromJson(bookCoded[0]));
        }
        return booksList;
      } else {
        throw Exception();
      }
    } else {
      return [];
    }
  }

  Future<Map<String, dynamic>> makerOrderFromBucket(
      Map<String, dynamic> data) async {
    String endpoint = 'api/order';
    final api = NetworkService().getApiWithOptions(
      withXSRFToken: true,
      withReferer: true,
    );
    final response = await api.post(endpoint, data: data);
    if (response.statusCode == 201) {
      Map<String, dynamic> responseDecoded =
          Map<String, dynamic>.from(response.data);
      return responseDecoded;
    } else {
      return {};
    }
  }

  void updateCart(Map<String, dynamic> data) async {
    String endpoint = 'api/cart';
    final api = NetworkService().getApiWithOptions(
      withXSRFToken: true,
      withReferer: true,
    );
    try {
      await api.post(endpoint, data: data);
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  updateUserInfo(String email, String name) async {
    String endpoint = 'api/update_user';
    final api = NetworkService().getApiWithOptions(withXSRFToken: true);

    try {
      await api.put(endpoint, queryParameters: {
        'email': email,
        'name': name,
      });
    } on DioError catch (e) {
      if (e.response != null) {
        throw ResponseError(e.response!.data as Map<String, dynamic>);
      } else {
        throw ResponseError();
      }
    }
  }

  Future<UserModel> loadUser() async {
    String endpoint = 'api/myaccount';
    var api = NetworkService().getApiWithOptions(withXSRFToken: true);

    var response = await api.get(endpoint);

    return UserModel.fromJson(response.data[0]);
  }

  uploadAvatar(File file) async {
    String endpoint = 'api/set_avatar';
    var api = NetworkService().getApiWithOptions(withXSRFToken: true);

    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "avatar": await MultipartFile.fromFile(file.path, filename: fileName),
    });
    await api.post(endpoint, data: formData);
  }
}

class ResponseError implements Exception {
  final Map<String, dynamic>? messages;

  ResponseError([this.messages]);
}
