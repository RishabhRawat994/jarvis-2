// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:jarvis2_flutter/secrets.dart';

// class OpenAIService {
//   final List<Map<String, String>> message = [];

//   Future<String> isArtPromptAPI(String prompt) async {
//     try {
//       final res = await http.post(
//           Uri.parse('https://api.openai.com/v1/chat/completions'),
//           headers: {
//             'Content-Type': 'application/json',
//             'Authorization': 'Bearer $openAIAPIKey',
//           },
//           body: jsonEncode({
//             "model": "gpt-3.5-turbo",
//             "message": [
//               {
//                 'role': 'user',
//                 'content':
//                     'Does this message want to generate a AI picture, image, art or anything similar? $prompt . Simply answer with a yes or no.',
//               }
//             ]
//           }));
//       print(res.body);
//       if (res.statusCode == 200) {
//         String content =
//             jsonDecode(res.body)['choices'][0]['message']['content'];
//         content = content.trim();

//         switch (content) {
//           case 'Yes':
//           case 'yes':
//           case 'Yes.':
//           case 'yes.':
//             final res = await dallEAPI(prompt);
//             return res;
//           default:
//             final res = await chatGPTAPI(prompt);
//             return res;
//         }
//       }
//       return 'An internal error occured';
//     } catch (e) {
//       return e.toString();
//     }
//   }

//   Future<String> chatGPTAPI(String prompt) async {
//     message.add({
//       'role': 'user',
//       'content': prompt,
//     });
//     try {
//       final res = await http.post(
//         Uri.parse('https://api.openai.com/v1/chat/completions'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $openAIAPIKey',
//         },
//         body: jsonEncode({
//           "model": "gpt-3.5-turbo",
//           "message": message,
//         }),
//       );

//       if (res.statusCode == 200) {
//         String content =
//             jsonDecode(res.body)['choices'][0]['message']['content'];
//         content = content.trim();

//         message.add({
//           'role': 'assistant',
//           'content': content,
//         });
//         return content;
//       }
//       return 'An internal error occured';
//     } catch (e) {
//       return e.toString();
//     }
//   }

//   Future<String> dallEAPI(String prompt) async {
//     message.add({
//       'role': 'user',
//       'content': prompt,
//     });
//     try {
//       final res = await http.post(
//         Uri.parse('https://api.openai.com/v1/images/generations'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $openAIAPIKey',
//         },
//         body: jsonEncode({
//           'prompt': prompt,
//           'n': 1,
//         }),
//       );

//       if (res.statusCode == 200) {
//         String imageUrl = jsonDecode(res.body)['data'][0]['url'];
//         imageUrl = imageUrl.trim();

//         message.add({
//           'role': 'assistant',
//           'content': imageUrl,
//         });
//         return imageUrl;
//       }
//       return 'An internal error occured';
//     } catch (e) {
//       return e.toString();
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jarvis2_flutter/secrets.dart';

class OpenAIService {
  final List<Map<String, String>> message = [];

  Future<String> isArtPromptAPI(String prompt) async {
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              'role': 'user',
              'content':
                  'Does this message want to generate a AI picture, image, art or anything similar? $prompt . Simply answer with a yes or no.',
            }
          ]
        }),
      );
      print(res.body);
      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim().toLowerCase();

        if (content == 'yes' || content == 'yes.') {
          final dallEResponse = await dallEAPI(prompt);
          return dallEResponse;
        } else {
          final chatGPTResponse = await chatGPTAPI(prompt);
          return chatGPTResponse;
        }
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> chatGPTAPI(String prompt) async {
    message.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": message,
        }),
      );

      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();

        message.add({
          'role': 'assistant',
          'content': content,
        });
        return content;
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> dallEAPI(String prompt) async {
    message.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/images/generations'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey',
        },
        body: jsonEncode({
          'prompt': prompt,
          'n': 1,
        }),
      );

      if (res.statusCode == 200) {
        String imageUrl = jsonDecode(res.body)['data'][0]['url'];
        imageUrl = imageUrl.trim();

        message.add({
          'role': 'assistant',
          'content': imageUrl,
        });
        return imageUrl;
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }
}
