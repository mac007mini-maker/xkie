class SampleData {
  // Video samples
  static const Map<String, String> videoPrompts = {
    'veo': 'A serene underwater scene with colorful coral reefs and tropical fish swimming gracefully',
    'runway': 'A cinematic shot of a futuristic city at sunset with flying cars',
    'sora': 'A golden retriever puppy playing in a sunny garden with butterflies',
    'hailuo': 'Epic battle scene between two warriors at sunset with dramatic lighting',
    'kling': 'Time-lapse of a blooming flower in a beautiful garden',
    'wan': 'Aerial view of a misty mountain landscape at dawn',
    'luma': 'A magical forest with glowing fireflies at night',
  };

  // Audio samples
  static const Map<String, String> audioPrompts = {
    'suno': 'Upbeat electronic dance music with catchy melody, 120 BPM, energetic and modern',
  };

  // Photo samples
  static const Map<String, String> photoPrompts = {
    'nanoBanana': 'A hyper-realistic portrait of a wise old owl perched on a ancient tree branch',
    'nanoBananaEdit': 'Make the background more vibrant and colorful',
    '4oImage': 'A beautiful sunset over mountains with dramatic clouds',
    'fluxKontext': 'A cyberpunk street scene with neon lights and rain',
    'ideogram': 'A professional logo design for a tech startup',
    'qwen': 'Enhance the colors and add more contrast',
  };

  // Image sizes
  static const List<String> imageSizes = [
    '1:1',
    '9:16',
    '16:9',
    '3:4',
    '4:3',
    '3:2',
    '2:3',
    '5:4',
    '4:5',
    '21:9',
    'auto',
  ];

  // Output formats
  static const List<String> outputFormats = [
    'png',
    'jpeg',
  ];

  // Video durations
  static const List<String> videoDurations = [
    '5',
    '10',
  ];
}

