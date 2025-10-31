import 'package:flutter/material.dart';
import '../widgets/api_test_card.dart';
import '../utils/sample_data.dart';

class AudioScreen extends StatelessWidget {
  const AudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Suno V4 - Generate
        ApiTestCard(
          modelName: 'Suno V4 - Generate Music',
          description: 'Generate high-quality music from text prompt',
          endpoint: '/api/audio/suno/generate',
          samplePrompt: SampleData.audioPrompts['suno'],
          parameters: [
            ApiParameter(
              name: 'prompt',
              label: 'Music Description',
              type: 'text',
              description: 'Describe the music style, mood, tempo, instruments',
            ),
            ApiParameter(
              name: 'duration',
              label: 'Duration (seconds)',
              type: 'dropdown',
              defaultValue: '30',
              options: ['15', '30', '60', '120', '180'],
            ),
            ApiParameter(
              name: 'instrumental',
              label: 'Instrumental',
              type: 'dropdown',
              defaultValue: 'false',
              options: ['true', 'false'],
              description: 'Generate instrumental (no vocals)',
            ),
          ],
        ),

        // Suno V4 - Extend
        ApiTestCard(
          modelName: 'Suno V4 - Extend Music',
          description: 'Extend an existing Suno track',
          endpoint: '/api/audio/suno/extend',
          parameters: [
            ApiParameter(
              name: 'audio_id',
              label: 'Audio ID',
              type: 'text',
              description: 'The ID of the audio to extend',
            ),
            ApiParameter(
              name: 'continuation_prompt',
              label: 'Continuation Prompt',
              type: 'text',
              description: 'How to continue the music (optional)',
              defaultValue: '',
            ),
            ApiParameter(
              name: 'duration',
              label: 'Extension Duration',
              type: 'dropdown',
              defaultValue: '30',
              options: ['15', '30', '60'],
            ),
          ],
        ),

        // Suno V4 - Get Details
        ApiTestCard(
          modelName: 'Suno V4 - Get Track Details',
          description: 'Get details and status of a Suno track',
          endpoint: '/api/audio/suno/details',
          parameters: [
            ApiParameter(
              name: 'audio_id',
              label: 'Audio ID',
              type: 'text',
              description: 'The ID of the audio track',
            ),
          ],
        ),

        // Info Card
        const Card(
          margin: EdgeInsets.all(8.0),
          color: Colors.blue,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Suno V4 Tips',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  '• Be specific about genre, mood, and instruments\n'
                  '• Include tempo (BPM) for better results\n'
                  '• Music generation may take 1-2 minutes\n'
                  '• Use the audio ID to extend tracks later',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

