// import 'package:flutter/material.dart';
// import 'package:jarvis2_flutter/feature_box.dart';
// import 'package:speech_to_text/speech_to_text.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final speechToText = SpeechToText();
//   bool speechEnabled = false;
//   String lastWords = '';

//   @override
//   void initState() {
//     super.initState();
//     initSpeechToText();
//   }

//   Future<void> initSpeechToText() async {
//     await speechToText.initialize();
//     setState(() {});
//   }

//   Future<void> startListening() async {
//     await speechToText.listen(onResult: onSpeechResult);
//     setState(() {});
//   }

//   Future<void> stopListening() async {
//     await speechToText.stop();
//     setState(() {});
//   }

//   void onSpeechResult(SpeechRecognitionResult result) {
//     setState(() {
//       lastWords = result.recognizedWords;
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     speechToText.stop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Jarvis'),
//         leading: const Icon(Icons.menu),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // virtual assiatant picture
//             Stack(
//               children: [
//                 Center(
//                   child: Container(
//                     height: 140,
//                     width: 140,
//                     margin: const EdgeInsets.only(top: 5),
//                     decoration: const BoxDecoration(
//                       color: Color.fromARGB(255, 171, 245, 255),
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: 150,
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     image: DecorationImage(
//                       image: AssetImage(
//                         'assets/image/virtualAssistant2.png',
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 20,
//                 vertical: 10,
//               ),
//               margin: const EdgeInsets.symmetric(horizontal: 40).copyWith(
//                 top: 30,
//               ),
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: const Color.fromARGB(255, 165, 165, 165),
//                 ),
//                 borderRadius:
//                     BorderRadius.circular(20).copyWith(topLeft: Radius.zero),
//               ),
//               child: const Padding(
//                 padding: EdgeInsets.symmetric(vertical: 10.0),
//                 child: Text(
//                   'Good Morning, What task can I do for you?',
//                   style: TextStyle(
//                     fontFamily: 'Cera Pro',
//                     color: Color.fromARGB(255, 62, 95, 162),
//                     fontSize: 25,
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.only(
//                 top: 20,
//                 bottom: 20,
//                 left: 15,
//                 right: 15,
//               ),
//               alignment: Alignment.centerLeft,
//               child: const Text(
//                 'Here are a few features',
//                 style: TextStyle(
//                   fontFamily: 'Cera Pro',
//                   fontSize: 20,
//                   color: Color.fromARGB(255, 62, 95, 162),
//                 ),
//               ),
//             ),
//             // features List
//             const Column(
//               children: [
//                 FeatureBox(
//                   color: Color.fromARGB(138, 255, 150, 150),
//                   headerText: 'chatGPT',
//                   descriptionText:
//                       'A smarter way to stay organised and informed with chatGPT',
//                 ),
//                 FeatureBox(
//                   color: Color.fromARGB(134, 255, 249, 79),
//                   headerText: 'Dall-E',
//                   descriptionText:
//                       'Get inspired and stay connected with your personal assistant powered by Dall-E',
//                 ),
//                 FeatureBox(
//                   color: Color.fromARGB(133, 135, 255, 249),
//                   headerText: 'Smart voice assistant',
//                   descriptionText:
//                       'Get the best of both words and a voice assistant powered by Dall-E and chatGPT',
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           if (await speechToText.hasPermission && speechToText.isNotListening) {
//             await startListening();
//           } else if (speechToText.isListening) {
//             await stopListening();
//           } else {
//             initSpeechToText();
//           }
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:jarvis2_flutter/feature_box.dart';
// import 'package:jarvis2_flutter/openai_service.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:speech_to_text/speech_recognition_result.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final stt.SpeechToText speech = stt.SpeechToText();
//   bool speechEnabled = false;
//   String lastWords = '';
//   final OpenAIService openAIService = OpenAIService();
//   String? generatedContent;
//   String? generatedImageUrl;

//   @override
//   void initState() {
//     super.initState();
//     initSpeechToText();
//   }

//   Future<void> initTextToSpeech() async {
//     await FlutterTts.initialize();
//     setState(() {});
//   }

//   Future<void> initSpeechToText() async {
//     speechEnabled = await speech.initialize(
//       onStatus: statusListener,
//       onError: errorListener,
//     );

//     if (speechEnabled) {
//       debugPrint('Speech recognition initialized');
//     } else {
//       debugPrint('Speech recognition initialization failed');
//     }

//     setState(() {});
//   }

//   Future<void> startListening() async {
//     if (speechEnabled && !speech.isListening) {
//       await speech.listen(onResult: onSpeechResult);
//       debugPrint('Started listening');
//     } else {
//       debugPrint('Speech recognition not enabled or already listening');
//     }
//     setState(() {});
//   }

//   Future<void> stopListening() async {
//     if (speech.isListening) {
//       await speech.stop();
//       debugPrint('Stopped listening');
//     }
//     setState(() {});
//   }

//   void statusListener(String status) {
//     debugPrint('Speech recognition status: $status');
//   }

//   void errorListener(dynamic error) {
//     debugPrint('Speech recognition error: $error');
//   }

//   void onSpeechResult(SpeechRecognitionResult result) {
//     debugPrint('Recognized words: ${result.recognizedWords}');
//     setState(() {
//       lastWords = result.recognizedWords;
//     });
//   }

//   Future<void> systemSpeak(String content) async {}

//   @override
//   void dispose() {
//     speech.stop();
//     FlutterTts.pause();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Jarvis'),
//         leading: const Icon(Icons.menu),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 Center(
//                   child: Container(
//                     height: 140,
//                     width: 140,
//                     margin: const EdgeInsets.only(top: 5),
//                     decoration: const BoxDecoration(
//                       color: Color.fromARGB(255, 171, 245, 255),
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: 150,
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     image: DecorationImage(
//                       image: AssetImage('assets/image/virtualAssistant2.png'),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Visibility(
//               visible: generatedImageUrl == null,
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 margin: const EdgeInsets.symmetric(horizontal: 40).copyWith(
//                   top: 30,
//                 ),
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: const Color.fromARGB(255, 165, 165, 165),
//                   ),
//                   borderRadius:
//                       BorderRadius.circular(20).copyWith(topLeft: Radius.zero),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 10.0),
//                   child: Text(
//                     generatedContent == null
//                         ? 'Good Morning, What task can I do for you?'
//                         : generatedContent!,
//                     style: TextStyle(
//                       fontFamily: 'Cera Pro',
//                       color: const Color.fromARGB(255, 62, 95, 162),
//                       fontSize: generatedContent == null ? 25 : 18,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             if (generatedImageUrl != null) Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Image.network(generatedImageUrl!),
//             ),
//             Visibility(
//               visible: generatedContent == null && generatedImageUrl == null,
//               child: Container(
//                 padding: const EdgeInsets.only(
//                   top: 20,
//                   bottom: 20,
//                   left: 15,
//                   right: 15,
//                 ),
//                 alignment: Alignment.centerLeft,
//                 child: const Text(
//                   'Here are a few features',
//                   style: TextStyle(
//                     fontFamily: 'Cera Pro',
//                     fontSize: 20,
//                     color: Color.fromARGB(255, 62, 95, 162),
//                   ),
//                 ),
//               ),
//             ),
//             Visibility(
//               visible: generatedContent == null && generatedImageUrl == null,
//               child: const Column(
//                 children: [
//                   FeatureBox(
//                     color: Color.fromARGB(138, 255, 150, 150),
//                     headerText: 'chatGPT',
//                     descriptionText:
//                         'A smarter way to stay organized and informed with chatGPT',
//                   ),
//                   FeatureBox(
//                     color: Color.fromARGB(134, 255, 249, 79),
//                     headerText: 'Dall-E',
//                     descriptionText:
//                         'Get inspired and stay connected with your personal assistant powered by Dall-E',
//                   ),
//                   FeatureBox(
//                     color: Color.fromARGB(133, 135, 255, 249),
//                     headerText: 'Smart voice assistant',
//                     descriptionText:
//                         'Get the best of both worlds with a voice assistant powered by Dall-E and chatGPT',
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           if (speech.isListening) {
//             final speech = await openAIService.isArtPromptAPI(lastWords);
//             if (speech.contains('https')) {
//               generatedImageUrl = speech;
//               generatedContent = null;
//               setState(() {});
//             } else {
//               generatedImageUrl = null;
//               generatedContent = speech;
//               await systemSpeak(speech);
//               setState(() {});
//             }
//             await systemSpeak(speech);
//             print(speech);
//             await stopListening();
//           } else {
//             await startListening();
//           }
//         },
//         child: Icon(speech.isListening ? Icons.mic : Icons.mic_none),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:jarvis2_flutter/feature_box.dart';
import 'package:jarvis2_flutter/openai_service.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_recognition_result.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final stt.SpeechToText speech = stt.SpeechToText();
  final FlutterTts flutterTts = FlutterTts();
  bool speechEnabled = false;
  String lastWords = '';
  final OpenAIService openAIService = OpenAIService();
  String? generatedContent;
  String? generatedImageUrl;

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    setState(() {});
  }

  Future<void> initSpeechToText() async {
    speechEnabled = await speech.initialize(
      onStatus: statusListener,
      onError: errorListener,
    );

    if (speechEnabled) {
      debugPrint('Speech recognition initialized');
    } else {
      debugPrint('Speech recognition initialization failed');
    }

    setState(() {});
  }

  Future<void> startListening() async {
    if (speechEnabled && !speech.isListening) {
      await speech.listen(onResult: onSpeechResult);
      debugPrint('Started listening');
    } else {
      debugPrint('Speech recognition not enabled or already listening');
    }
    setState(() {});
  }

  Future<void> stopListening() async {
    if (speech.isListening) {
      await speech.stop();
      debugPrint('Stopped listening');
    }
    setState(() {});
  }

  void statusListener(String status) {
    debugPrint('Speech recognition status: $status');
  }

  void errorListener(dynamic error) {
    debugPrint('Speech recognition error: $error');
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    debugPrint('Recognized words: ${result.recognizedWords}');
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    speech.stop();
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jarvis'),
        leading: const Icon(Icons.menu),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    height: 140,
                    width: 140,
                    margin: const EdgeInsets.only(top: 5),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 171, 245, 255),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Container(
                  height: 150,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/image/virtualAssistant2.png'),
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: generatedImageUrl == null,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 40).copyWith(
                  top: 30,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 165, 165, 165),
                  ),
                  borderRadius:
                      BorderRadius.circular(20).copyWith(topLeft: Radius.zero),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    generatedContent ??
                        'Good Morning, What task can I do for you?',
                    style: TextStyle(
                      fontFamily: 'Cera Pro',
                      color: const Color.fromARGB(255, 62, 95, 162),
                      fontSize: generatedContent == null ? 25 : 18,
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: generatedImageUrl != null,
              child: generatedImageUrl != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(generatedImageUrl!),
                    )
                  : const SizedBox.shrink(),
            ),
            Visibility(
              visible: generatedContent == null && generatedImageUrl == null,
              child: Container(
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                  left: 15,
                  right: 15,
                ),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Here are a few features',
                  style: TextStyle(
                    fontFamily: 'Cera Pro',
                    fontSize: 20,
                    color: Color.fromARGB(255, 62, 95, 162),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: generatedContent == null && generatedImageUrl == null,
              child: const Column(
                children: [
                  FeatureBox(
                    color: Color.fromARGB(138, 255, 150, 150),
                    headerText: 'chatGPT',
                    descriptionText:
                        'A smarter way to stay organized and informed with chatGPT',
                  ),
                  FeatureBox(
                    color: Color.fromARGB(134, 255, 249, 79),
                    headerText: 'Dall-E',
                    descriptionText:
                        'Get inspired and stay connected with your personal assistant powered by Dall-E',
                  ),
                  FeatureBox(
                    color: Color.fromARGB(133, 135, 255, 249),
                    headerText: 'Smart voice assistant',
                    descriptionText:
                        'Get the best of both worlds with a voice assistant powered by Dall-E and chatGPT',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (speech.isListening) {
            try {
              final response = await openAIService.isArtPromptAPI(lastWords);
              if (response.contains('https')) {
                generatedImageUrl = response;
                generatedContent = null;
              } else {
                generatedImageUrl = null;
                generatedContent = response;
                await systemSpeak(response);
              }
            } catch (e) {
              debugPrint('Error: $e');
            }
            await stopListening();
          } else {
            await startListening();
          }
          setState(() {});
        },
        child: Icon(speech.isListening ? Icons.mic : Icons.mic_none),
      ),
    );
  }
}
