import 'package:flutter/material.dart';
import '../widgets/api_test_card.dart';
import '../utils/sample_data.dart';

class PhotoScreen extends StatelessWidget {
  const PhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Nano Banana - Generate
        ApiTestCard(
          modelName: 'Nano Banana - Generate',
          description: 'Gemini 2.5 Flash (Nano Banana) image generation',
          endpoint: '/api/photo/nano-banana/generate',
          samplePrompt: SampleData.photoPrompts['nanoBanana'],
          parameters: [
            ApiParameter(
              name: 'prompt',
              label: 'Prompt',
              type: 'text',
              description: 'Describe the image you want to generate',
            ),
            ApiParameter(
              name: 'output_format',
              label: 'Output Format',
              type: 'dropdown',
              defaultValue: 'png',
              options: SampleData.outputFormats,
            ),
            ApiParameter(
              name: 'image_size',
              label: 'Image Size',
              type: 'dropdown',
              defaultValue: '1:1',
              options: SampleData.imageSizes,
            ),
          ],
        ),

        // Nano Banana - Edit
        ApiTestCard(
          modelName: 'Nano Banana - Edit',
          description: 'Edit images with natural language',
          endpoint: '/api/photo/nano-banana/edit',
          requiresFileUpload: true,
          parameters: [
            ApiParameter(
              name: 'prompt',
              label: 'Edit Instruction',
              type: 'text',
              description: 'Describe how to edit the image',
              defaultValue: SampleData.photoPrompts['nanoBananaEdit'],
            ),
            ApiParameter(
              name: 'output_format',
              label: 'Output Format',
              type: 'dropdown',
              defaultValue: 'png',
              options: SampleData.outputFormats,
            ),
          ],
        ),

        // 4O Image - Generate
        ApiTestCard(
          modelName: '4O Image - Generate',
          description: 'GPT-4O powered image generation',
          endpoint: '/api/photo/4o-image/generate',
          samplePrompt: SampleData.photoPrompts['4oImage'],
          parameters: [
            ApiParameter(
              name: 'prompt',
              label: 'Prompt',
              type: 'text',
            ),
            ApiParameter(
              name: 'image_size',
              label: 'Image Size',
              type: 'dropdown',
              defaultValue: '1:1',
              options: SampleData.imageSizes,
            ),
          ],
        ),

        // 4O Image - Edit
        ApiTestCard(
          modelName: '4O Image - Edit',
          description: 'GPT-4O powered image editing',
          endpoint: '/api/photo/4o-image/edit',
          requiresFileUpload: true,
          parameters: [
            ApiParameter(
              name: 'prompt',
              label: 'Edit Instruction',
              type: 'text',
              defaultValue: 'Enhance the colors and add more details',
            ),
          ],
        ),

        // Flux Kontext - Generate
        ApiTestCard(
          modelName: 'Flux Kontext - Generate',
          description: 'Context-aware image generation',
          endpoint: '/api/photo/flux-kontext/generate',
          samplePrompt: SampleData.photoPrompts['fluxKontext'],
          parameters: [
            ApiParameter(
              name: 'prompt',
              label: 'Prompt',
              type: 'text',
            ),
            ApiParameter(
              name: 'image_size',
              label: 'Image Size',
              type: 'dropdown',
              defaultValue: '1:1',
              options: SampleData.imageSizes,
            ),
          ],
        ),

        // Flux Kontext - Edit
        ApiTestCard(
          modelName: 'Flux Kontext - Edit',
          description: 'Context-aware image editing',
          endpoint: '/api/photo/flux-kontext/edit',
          requiresFileUpload: true,
          parameters: [
            ApiParameter(
              name: 'prompt',
              label: 'Edit Instruction',
              type: 'text',
              defaultValue: 'Modify the scene with better lighting',
            ),
          ],
        ),

        // Ideogram V3
        ApiTestCard(
          modelName: 'Ideogram V3',
          description: 'Advanced text-to-image generation',
          endpoint: '/api/photo/ideogram/v3',
          samplePrompt: SampleData.photoPrompts['ideogram'],
          parameters: [
            ApiParameter(
              name: 'prompt',
              label: 'Prompt',
              type: 'text',
            ),
            ApiParameter(
              name: 'style',
              label: 'Style',
              type: 'dropdown',
              defaultValue: 'auto',
              options: ['auto', 'realistic', 'design', 'anime', '3d'],
            ),
          ],
        ),

        // Ideogram Character
        ApiTestCard(
          modelName: 'Ideogram Character',
          description: 'Character-focused image generation',
          endpoint: '/api/photo/ideogram/character',
          parameters: [
            ApiParameter(
              name: 'prompt',
              label: 'Character Description',
              type: 'text',
              defaultValue: 'A friendly cartoon robot character with expressive eyes',
            ),
            ApiParameter(
              name: 'style',
              label: 'Style',
              type: 'dropdown',
              defaultValue: 'cartoon',
              options: ['cartoon', 'anime', 'realistic', '3d'],
            ),
          ],
        ),

        // Qwen Image Edit
        ApiTestCard(
          modelName: 'Qwen Image Edit',
          description: 'AI-powered image editing',
          endpoint: '/api/photo/qwen/edit',
          requiresFileUpload: true,
          parameters: [
            ApiParameter(
              name: 'prompt',
              label: 'Edit Instruction',
              type: 'text',
              defaultValue: SampleData.photoPrompts['qwen'],
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
                      'Image Generation Tips',
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
                  '• Be descriptive and specific in prompts\n'
                  '• Include style, lighting, and composition details\n'
                  '• For editing, describe the specific changes\n'
                  '• Supported formats: JPEG, PNG, WEBP (max 10MB)',
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

