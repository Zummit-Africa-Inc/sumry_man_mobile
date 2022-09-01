// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

const host =
    "https://summaryer-api.pk25mf6178910.eu-west-3.cs.amazonlightsail.com";

class SummaryApi {
  Future<Map<String, dynamic>> summarize(
      {required String text, int? sentenceCount}) async {
    Map<String, dynamic> summaryObject = {};
    bool validURL = Uri.parse(text).isAbsolute;
    print("isLink: ${validURL.toString()} \nTEXT: $text");
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*",
    };

    Map<String, dynamic> textBody = {"text": text, "sentence_count": 10};
    Map<String, dynamic> urlBody = {"url": text, "sentence_count": 10};

    try {
      final response =
          await http.post(Uri.parse(validURL ? "$host/url" : "$host/text"),
              headers: requestHeaders,
              body: json.encode(
                validURL ? urlBody : textBody,
              ));
      print(response.statusCode.toString());
      print(response.body);
      final decodedResponse = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("SUMMARY SUCCESSFUL");
        summaryObject = {
          "status": "success",
          "message": decodedResponse["summary"],
        };
        return summaryObject;
      } else if (response.statusCode == 422) {
        print("VALIDATION ERROR");
        summaryObject = {
          "status": "error",
          "message":
              "Sorry, we are unable to process your text due to semantic errors.",
        };
        return summaryObject;
      } else if (response.statusCode == 500 || response.statusCode == 501) {
        print("SERVER ERROR");
        summaryObject = {
          "status": "error",
          "message": "Server Timeout Error 500",
        };
        return summaryObject;
      } else {
        print("UNKNOWN ERROR");
        summaryObject = {
          "status": "error",
          "message": "Something went wrong",
        };
        return summaryObject;
      }
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  Future sendRequest(String filepath, String filename) async {
    var extension = filepath.split('.').last;
    print("file extension is: $extension");
    var request = http.MultipartRequest("POST", Uri.parse("$host/upload_file"));
    var text = await http.MultipartFile.fromPath(
      "file_upload",
      filepath,
      filename: filename,
      contentType: extension == "txt"
          ? MediaType('text', 'plain')
          : MediaType('application',
              'vnd.openxmlformats-officedocument.wordprocessingml.document'),
    );
    request.files.add(text);
    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    final responseData = json.decode(responsed.body);
    if (response.statusCode == 200) {
      print("Uploaded!");
      print(responseData);
    } else {
      print(response.statusCode);
      print(responseData);
      print('not Uploaded');
    }
  }
}
