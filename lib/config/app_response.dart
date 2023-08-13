import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:laundry_app/config/failure.dart';

class AppResponse {
  static Map data(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseBody = jsonDecode(response.body);
        return responseBody;
      case 204:
        return {'success': true};
      case 400:
        throw BadRequestFailure(response.body);
      case 401:
        throw AnauthorizedFailure(response.body);
      case 422:
        throw InvalidInputFailure(response.body);
      case 403:
        throw ForbiddenFailure(response.body);
      case 404:
        throw NotFoundFailure(response.body);
      case 500:
        throw ServerFailure(response.body);
      default:
        throw FetchFailure(response.body);
    }
  }

  static invalidInput(BuildContext context, String messageBody) {
    Map errors = jsonDecode(messageBody)["errors"];
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            titlePadding: const EdgeInsets.fromLTRB(6, 6, 6, 0),
            title: const Text("Invalid input"),
            children: [
              ...errors.entries
                  .map(
                    (e) => ListTile(
                      title: e.key,
                      subtitle: Column(
                        children: [
                          ...(e.value as List).map((itemErr) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("-"),
                                Expanded(child: Text(itemErr))
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ],
          );
        });
  }
}
