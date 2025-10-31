import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:audioplayers/audioplayers.dart';

class MediaResultDisplay extends StatefulWidget {
  final String url;
  final String type; // 'image', 'video', 'audio'
  final Map<String, dynamic>? metadata;

  const MediaResultDisplay({
    super.key,
    required this.url,
    required this.type,
    this.metadata,
  });

  @override
  State<MediaResultDisplay> createState() => _MediaResultDisplayState();
}

class _MediaResultDisplayState extends State<MediaResultDisplay> {
  VideoPlayerController? _videoController;
  AudioPlayer? _audioPlayer;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    if (widget.type == 'video') {
      _initializeVideo();
    } else if (widget.type == 'audio') {
      _audioPlayer = AudioPlayer();
    }
  }

  void _initializeVideo() {
    _videoController = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _audioPlayer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.green[50],
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.green),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Result (${widget.type})',
                  style: TextStyle(
                    color: Colors.green[900],
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildMediaWidget(),
          const SizedBox(height: 8),
          SelectableText(
            'URL: ${widget.url}',
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
          if (widget.metadata != null) ...[
            const SizedBox(height: 8),
            ExpansionTile(
              title: const Text('Metadata'),
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.grey[200],
                  child: SelectableText(
                    widget.metadata.toString(),
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMediaWidget() {
    switch (widget.type) {
      case 'image':
        return Image.network(
          widget.url,
          errorBuilder: (context, error, stackTrace) {
            return Text('Failed to load image: $error');
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
        );

      case 'video':
        if (_videoController == null || !_videoController!.value.isInitialized) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            AspectRatio(
              aspectRatio: _videoController!.value.aspectRatio,
              child: VideoPlayer(_videoController!),
            ),
            VideoProgressIndicator(_videoController!, allowScrubbing: true),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    _videoController!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  ),
                  onPressed: () {
                    setState(() {
                      if (_videoController!.value.isPlaying) {
                        _videoController!.pause();
                      } else {
                        _videoController!.play();
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        );

      case 'audio':
        return Column(
          children: [
            const Icon(Icons.audiotrack, size: 64, color: Colors.blue),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: () async {
                    if (_isPlaying) {
                      await _audioPlayer!.pause();
                      setState(() => _isPlaying = false);
                    } else {
                      await _audioPlayer!.play(UrlSource(widget.url));
                      setState(() => _isPlaying = true);
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.stop),
                  onPressed: () async {
                    await _audioPlayer!.stop();
                    setState(() => _isPlaying = false);
                  },
                ),
              ],
            ),
          ],
        );

      default:
        return Text('Unsupported media type: ${widget.type}');
    }
  }
}

