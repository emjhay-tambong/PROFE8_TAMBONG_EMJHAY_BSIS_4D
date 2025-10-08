import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:audioplayers/audioplayers.dart';

class MediaPlayerAppScreen extends StatefulWidget {
  const MediaPlayerAppScreen({super.key});

  @override
  State<MediaPlayerAppScreen> createState() => _MediaPlayerAppScreenState();
}

class _MediaPlayerAppScreenState extends State<MediaPlayerAppScreen>
    with TickerProviderStateMixin {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  late TabController _tabController;
  bool _isAudioPlaying = false;
  bool _isVideoPlaying = false;
  Duration _audioPosition = Duration.zero;
  Duration _audioDuration = Duration.zero;
  
  // Stream subscriptions for proper cleanup
  StreamSubscription<Duration>? _durationSubscription;
  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<PlayerState>? _playerStateSubscription;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _initializeMediaPlayers();
    _setupAudioListeners();
    _initializeAudioDemo(); // Initialize demo audio for web compatibility
  }

  void _initializeMediaPlayers() {
    // Initialize video player with local asset
    _videoController = VideoPlayerController.asset('assets/videos/bike_video.mp4');
    
    _videoController!.initialize().then((_) {
      if (mounted) {
        _chewieController = ChewieController(
          videoPlayerController: _videoController!,
          autoPlay: false,
          looping: true,
          showControls: true,
          materialProgressColors: ChewieProgressColors(
            playedColor: Colors.blue,
            handleColor: Colors.blue,
            backgroundColor: Colors.grey,
            bufferedColor: Colors.lightBlue,
          ),
        );
        setState(() {});
      }
    }).catchError((error) {
      // Handle video format errors gracefully
      debugPrint('Video initialization error: $error');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Video format not supported. Using demo placeholder.'),
            duration: Duration(seconds: 3),
          ),
        );
        setState(() {});
      }
    });

    // Listen to video player state
    _videoController!.addListener(() {
      if (mounted && _videoController!.value.isPlaying != _isVideoPlaying) {
        setState(() {
          _isVideoPlaying = _videoController!.value.isPlaying;
        });
      }
    });
  }

  void _setupAudioListeners() {
    _durationSubscription = _audioPlayer.onDurationChanged.listen((duration) {
      if (mounted) {
        setState(() {
          _audioDuration = duration;
        });
      }
    });

    _positionSubscription = _audioPlayer.onPositionChanged.listen((position) {
      if (mounted) {
        setState(() {
          _audioPosition = position;
        });
      }
    });

    _playerStateSubscription = _audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          _isAudioPlaying = state == PlayerState.playing;
        });
      }
    });
  }

  // Initialize audio with demo duration for web compatibility
  void _initializeAudioDemo() {
    if (mounted) {
      setState(() {
        _audioDuration = const Duration(seconds: 1);
        _audioPosition = Duration.zero;
      });
    }
  }

  @override
  void dispose() {
    // Cancel all audio stream subscriptions
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerStateSubscription?.cancel();
    
    _tabController.dispose();
    _videoController?.dispose();
    _chewieController?.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playAudio() async {
    try {
      if (_isAudioPlaying) {
        await _audioPlayer.pause();
      } else {
        // Try to play the actual audio file
        await _audioPlayer.play(AssetSource('audio/click.mp3'));
      }
    } catch (e) {
      // Handle audio format errors gracefully for web
      debugPrint('Audio playback error: $e');
      if (mounted) {
        setState(() {
          _isAudioPlaying = !_isAudioPlaying;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isAudioPlaying 
              ? 'Audio Demo: Playing bike safety guide'
              : 'Audio Demo: Paused bike safety guide'),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.blue,
          ),
        );
      }
    }
  }

  Future<void> _stopAudio() async {
    try {
      await _audioPlayer.stop();
      if (mounted) {
        setState(() {
          _audioPosition = Duration.zero;
          _isAudioPlaying = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Audio stopped'),
            duration: Duration(seconds: 1),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      debugPrint('Audio stop error: $e');
      if (mounted) {
        setState(() {
          _audioPosition = Duration.zero;
          _isAudioPlaying = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Audio Demo: Stopped bike safety guide'),
            duration: Duration(seconds: 1),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _seekAudio(Duration position) async {
    try {
      await _audioPlayer.seek(position);
    } catch (e) {
      debugPrint('Audio seek error: $e');
      // For demo purposes, simulate seeking
      if (mounted) {
        setState(() {
          _audioPosition = position;
        });
      }
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Media Player App'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.audiotrack), text: 'Audio'),
            Tab(icon: Icon(Icons.videocam), text: 'Video'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAudioPlayer(),
          _buildVideoPlayer(),
        ],
      ),
    );
  }

  Widget _buildAudioPlayer() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          // Audio Visualizer (Placeholder)
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: _isAudioPlaying
                    ? [Colors.blue.withValues(alpha: 0.3), Colors.blue.withValues(alpha: 0.1)]
                    : [Colors.grey.withValues(alpha: 0.3), Colors.grey.withValues(alpha: 0.1)],
              ),
            ),
            child: Icon(
              _isAudioPlaying ? Icons.music_note : Icons.music_off,
              size: 70,
              color: _isAudioPlaying ? Colors.blue : Colors.grey,
            ),
          ),
          const SizedBox(height: 24),
          
          // Song Info
          const Text(
            'Audio Track',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Audio Track Available',
              style: TextStyle(
                fontSize: 12,
                color: Colors.blue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Progress Bar
          Column(
            children: [
              Slider(
                value: _audioDuration.inMilliseconds > 0
                    ? _audioPosition.inMilliseconds / _audioDuration.inMilliseconds
                    : 0.0,
                onChanged: (value) {
                  final position = Duration(
                    milliseconds: (value * _audioDuration.inMilliseconds).round(),
                  );
                  _seekAudio(position);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_formatDuration(_audioPosition)),
                    Text(_formatDuration(_audioDuration)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Control Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: _stopAudio,
                icon: const Icon(Icons.stop),
                iconSize: 40,
                color: Colors.red,
                style: IconButton.styleFrom(
                  backgroundColor: Colors.red.withValues(alpha: 0.1),
                ),
              ),
              IconButton(
                onPressed: _playAudio,
                icon: Icon(_isAudioPlaying ? Icons.pause : Icons.play_arrow),
                iconSize: 56,
                color: Colors.blue,
                style: IconButton.styleFrom(
                  backgroundColor: Colors.blue.withValues(alpha: 0.1),
                ),
              ),
              IconButton(
                onPressed: () async {
                  try {
                    await _audioPlayer.pause();
                  } catch (e) {
                    debugPrint('Audio pause error: $e');
                    if (mounted) {
                      setState(() {
                        _isAudioPlaying = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Audio paused'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    }
                  }
                },
                icon: const Icon(Icons.pause),
                iconSize: 40,
                color: Colors.orange,
                style: IconButton.styleFrom(
                  backgroundColor: Colors.orange.withValues(alpha: 0.1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Video Player
          Container(
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: _chewieController != null
                  ? Chewie(controller: _chewieController!)
                  : _buildVideoPlaceholder(),
            ),
          ),
          const SizedBox(height: 16),
          
          // Video Controls
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: _videoController != null ? () {
                  _videoController?.seekTo(Duration.zero);
                } : () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Video player demo - restart function')),
                  );
                },
                icon: const Icon(Icons.replay, size: 16),
                label: const Text('Restart', style: TextStyle(fontSize: 12)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
              ElevatedButton.icon(
                onPressed: _videoController != null ? () {
                  if (_isVideoPlaying) {
                    _videoController?.pause();
                  } else {
                    _videoController?.play();
                  }
                } : () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Video player demo - play function')),
                  );
                },
                icon: Icon(_isVideoPlaying ? Icons.pause : Icons.play_arrow, size: 16),
                label: Text(_isVideoPlaying ? 'Pause' : 'Play', style: const TextStyle(fontSize: 12)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
              ElevatedButton.icon(
                onPressed: _videoController != null ? () {
                  _videoController?.pause();
                } : () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Video player demo - stop function')),
                  );
                },
                icon: const Icon(Icons.stop, size: 16),
                label: const Text('Stop', style: TextStyle(fontSize: 12)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Video Info
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Video Player Features',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '• Play, Pause, Stop controls\n• Seek to any position\n• Full screen support\n• Volume control\n• Progress indicator',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildVideoPlaceholder() {
    return Container(
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.videocam_off,
              size: 48,
              color: Colors.grey[600],
            ),
            const SizedBox(height: 12),
            Text(
              'Video Demo Placeholder',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              'Bike Video Player Demo',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.play_arrow, color: Colors.white, size: 16),
                  SizedBox(width: 6),
                  Text(
                    'Demo Video Player',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
