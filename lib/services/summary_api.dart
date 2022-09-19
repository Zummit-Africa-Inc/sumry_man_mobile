// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

const host =
    "https://summaryer-api.pk25mf6178910.eu-west-3.cs.amazonlightsail.com";

class SummaryApi {
  Future<Map<String, dynamic>> summarize(
      {required String text, required int sentenceCount}) async {
    Map<String, dynamic> summaryObject = {};
    bool validURL = false;
    if (text.length > 1000) {
      validURL = false;
    } else {
      validURL = Uri.parse(text).isAbsolute;
    }
    print("isLink: ${validURL.toString()} \nTEXT: $text");
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*",
    };

    Map<String, dynamic> textBody = {
      "text": text,
      "sentence_count": sentenceCount
    };
    Map<String, dynamic> urlBody = {
      "url": text,
      "sentence_count": sentenceCount
    };
    try {
      final response =
          await http.post(Uri.parse(validURL ? "$host/url" : "$host/text"),
              headers: requestHeaders,
              body: json.encode(
                validURL ? urlBody : textBody,
              ));
      print(response.statusCode.toString());
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedResponse = json.decode(response.body);
        print("SUMMARY SUCCESSFUL");
        decodedResponse["summary"] == null
            ? summaryObject = {
                "status": "error",
                "message": decodedResponse["error"],
              }
            : summaryObject = {
                "status": "success",
                "message": decodedResponse["summary"],
              };
      } else if (response.statusCode == 422) {
        print("VALIDATION ERROR");
        summaryObject = {
          "status": "error",
          "message":
              "Sorry, we are unable to process your text due to semantic errors.",
        };
      } else if (response.statusCode == 500 || response.statusCode == 501) {
        print("SERVER ERROR");
        summaryObject = {
          "status": "error",
          "message": "Internal Server Error",
        };
      } else {
        print("UNKNOWN ERROR");
        summaryObject = {
          "status": "error",
          "message": "Something went wrong",
        };
      }
    } catch (exception) {
      return Future.error(exception.toString());
    }
    return summaryObject;
  }

  Future sendRequest(
      {required String filepath,
      required String filename,
      required int sentenceCount}) async {
    Map<String, dynamic> summaryObject = {};
    var extension = filepath.split('.').last;
    print("file extension is: $extension");
    if (filepath == "") {
      summaryObject = {"status": "error", "message": "No file provided"};
      return summaryObject;
    }

    var request = http.MultipartRequest(
        "POST", Uri.parse("$host/upload_file?sentence_count=$sentenceCount"));
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

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("SUMMARY SUCCESSFUL");
      final responseData = json.decode(responsed.body);
      summaryObject = {
        "status": "success",
        "message": responseData["summary"],
      };
    } else {
      print(response.statusCode);
      print('not Uploaded');
      summaryObject = {"status": "error", "message": "Something went wrong"};
    }
    return summaryObject;
  }
}
