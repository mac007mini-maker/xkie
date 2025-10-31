import 'package:flutter/material.dart';
import '../widgets/api_test_card.dart';
import '../utils/sample_data.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Veo 3.1
        ApiTestCard(
          modelName: 'Veo 3.1 - Generate',
          description: 'Google Veo 3.1 text/image to video generation',
          endpoint: '/api/video/veo/generate',
          samplePrompt: SampleData.videoPrompts['veo'],
          parameters: [
            ApiParameter(
              name: 'prompt',
              label: 'Prompt',
              type: 'text',
              description: 'Describe the video you want to generate',
            ),
            ApiParameter(
              name: 'duration',
              label: 'Duration (seconds)',
              type: 'dropdown',
              defaultValue: '5',
              options: SampleData.videoDurations,
            ),
          ],
        ),

        ApiTestCard(
          modelName: 'Veo 3.1 - Extend',
          description: 'Extend an existing Veo 3.1 video',
          endpoint: '/api/video/veo/extend',
          parameters: [
            ApiParameter(
              name: 'video_id',
              label: 'Video ID',
              type: 'text',
              description: 'The ID of the video to extend',
            ),
            ApiParameter(
              name: 'prompt',
              label: 'Extension Prompt',
              type: 'text',
              description: 'How to continue the video',
            ),
          ],
        ),

        // Runway Gen-3
        ApiTestCard(
          modelName: 'Runway Gen-3',
          description: 'Runway image to video generation',
          endpoint: '/api/video/runway',
          requiresFileUpload: true,
          parameters: [
            ApiParameter(
              name: 'prompt',
              label: 'Prompt',
              type: 'text',
              description: 'Describe the motion/action',
              defaultValue: SampleData.videoPrompts['runway'],
            ),
            ApiParameter(
              name: 'duration',
              label: 'Duration',
              type: 'dropdown',
              defaultValue: '5',
              options: ['5', '10'],
            ),
          ],
        ),

        // Runway Aleph
        ApiTestCard(
          modelName: 'Runway Aleph',
          description: 'Video to video style transfer',
          endpoint: '/api/video/runway-aleph',
          requiresFileUpload: true,
          parameters: [
            ApiParameter(
              name: 'prompt',
              label: 'Style Prompt',
              type: 'text',
              description: 'Describe the style transformation',
              defaultValue: 'Transform into anime style',
            ),
          ],
        ),

        // Sora 2
        ApiTestCard(
          modelName: 'Sora 2 - Text to Video',
          description: 'OpenAI Sora 2 text to video',
          endpoint: '/api/video/sora/text',
          samplePrompt: SampleData.videoPrompts['sora'],
          parameters: [
            ApiParameter(
              name: 'prompt',
              label: 'Prompt',
              type: 'text',
              description: 'Describe the video scene',
            ),
            ApiParameter(
              name: 'duration',
              label: 'Duration',
              type: 'dropdown',
              defaultValue: '5',
              options: ['5', '10', '20'],
            ),
          ],
        ),

        ApiTestCard(
          modelName: 'Sora 2 - Image to Video',
          description: 'OpenAI Sora 2 image to video',
          endpoint: '/api/video/sora/image',
          requiresFileUpload: true,
          parameters: [
            ApiParameter(
              name: 'prompt',
              label: 'Motion Prompt',
              type: 'text',
              description: 'Describe the motion',
              defaultValue: 'Add gentle motion to the scene',
            ),
          ],
        ),

        // Hailuo 2.3
        ApiTestCard(
          modelName: 'Hailuo 2.3 - Text to Video',
          description: 'Hailuo text to video generation',
          endpoint: '/api/video/hailuo/text',
          samplePrompt: SampleData.videoPrompts['hailuo'],
          parameters: [
            ApiParameter(
              name: 'prompt',
              label: 'Prompt',
              type: 'text',
            ),
          ],
        ),

        ApiTestCard(
          modelName: 'Hailuo 2.3 - Image to Video',
          description: 'Hailuo image to video',
          endpoint: '/api/video/hailuo/image',
          requiresFileUpload: true,
          parameters: [
            ApiParameter(
              name: 'prompt',
              label: 'Motion Prompt',
              type: 'text',
              defaultValue: 'Animate this image',
            ),
          ],
        ),

        // Kling 2.1
        ApiTestCard(
          modelName: 'Kling 2.1',
          description: 'Kling text to video generation',
          endpoint: '/api/video/kling',
          samplePrompt: SampleData.videoPrompts['kling'],
          parameters: [
            ApiParameter(
              name: 'prompt',
              label: 'Prompt',
              type: 'text',
            ),
            ApiParameter(
              name: 'version',
              label: 'Version',
              type: 'dropdown',
              defaultValue: '2.1',
              options: ['2.1', '2.5'],
            ),
          ],
        ),

        // Wan Video
        ApiTestCard(
          modelName: 'Wan Video',
          description: 'Wan text to video generation',
          endpoint: '/api/video/wan',
          samplePrompt: SampleData.videoPrompts['wan'],
          parameters: [
            ApiParameter(
              name: 'prompt',
              label: 'Prompt',
              type: 'text',
            ),
            ApiParameter(
              name: 'version',
              label: 'Version',
              type: 'dropdown',
              defaultValue: '2.2',
              options: ['2.2', '2.5'],
            ),
          ],
        ),

        // Luma
        ApiTestCard(
          modelName: 'Luma',
          description: 'Luma AI video generation',
          endpoint: '/api/video/luma',
          samplePrompt: SampleData.videoPrompts['luma'],
          parameters: [
            ApiParameter(
              name: 'prompt',
              label: 'Prompt',
              type: 'text',
            ),
          ],
        ),

        // Sora 2 Watermark Remove
        ApiTestCard(
          modelName: 'Sora 2 Watermark Remove',
          description: 'Remove watermark from Sora videos',
          endpoint: '/api/video/sora/watermark-remove',
          requiresFileUpload: true,
          parameters: [
            ApiParameter(
              name: 'video_id',
              label: 'Video ID (optional)',
              type: 'text',
              description: 'Or upload video file',
            ),
          ],
        ),
      ],
    );
  }
}

