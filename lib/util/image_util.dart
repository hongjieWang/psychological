import 'dart:io';

import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:typed_data';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// 保存文件或图片到本地
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ImageUtils {
  static String getImgPath(String name, {String format: 'png'}) {
    if (name != null) {
      return 'assets/images/$name.$format';
    } else {
      return null;
    }
  }

  static String getLottiePath(String name, {String format: 'json'}) {
    return 'assets/lotties/$name.$format';
  }

  /// 保存图片到相册
  ///
  /// 默认为下载网络图片，如需下载资源图片，需要指定 [isAsset] 为 `true`。
  static Future<void> saveImage(String imageUrl, {bool isAsset: false}) async {
    try {
      if (imageUrl == null) throw '保存失败，图片不存在！';

      /// 权限检测
      PermissionStatus storageStatus = await Permission.storage.status;
      if (storageStatus != PermissionStatus.granted) {
        storageStatus = await Permission.storage.request();
        if (storageStatus != PermissionStatus.granted) {
          throw '无法存储图片，请先授权！';
        }
      }

      /// 保存的图片数据
      Uint8List imageBytes;
      if (isAsset == true) {
        /// 保存资源图片
        ByteData bytes = await rootBundle.load(imageUrl);
        imageBytes = bytes.buffer.asUint8List();
      } else {
        /// 保存网络图片
        CachedNetworkImage image = CachedNetworkImage(imageUrl: imageUrl);
        DefaultCacheManager manager =
            image.cacheManager ?? DefaultCacheManager();
        Map<String, String> headers = image.httpHeaders;
        File file = await manager.getSingleFile(
          image.imageUrl,
          headers: headers,
        );
        imageBytes = await file.readAsBytes();
      }
      /// 保存图片
      final result = await ImageGallerySaver.saveImage(imageBytes, name: "706");
      print(result);
      if (result == null || result == '') throw '图片保存失败';
      print("保存成功");
    } catch (e) {
      print(e.toString());
    }
  }
}
