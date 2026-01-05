import 'package:flutter/material.dart';

class UpdateDialog extends StatelessWidget {
  final String latestVersion;
  final String updateLog;
  final bool isMandatory;
  final VoidCallback onUpdate;
  final VoidCallback? onCancel;

  const UpdateDialog({
    super.key,
    required this.latestVersion,
    required this.updateLog,
    required this.isMandatory,
    required this.onUpdate,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        '发现新版本',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '最新版本: $latestVersion',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            '更新内容:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            updateLog,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          if (isMandatory)
            const Padding(
              padding: EdgeInsets.only(top: 12),
              child: Text(
                '* 此更新为强制更新，需更新后才能继续使用',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.red,
                ),
              ),
            ),
        ],
      ),
      actions: [
        if (!isMandatory && onCancel != null)
          TextButton(
            onPressed: onCancel,
            child: const Text('稍后提醒'),
          ),
        TextButton(
          onPressed: onUpdate,
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
          ),
          child: const Text('立即更新'),
        ),
      ],
    );
  }
}