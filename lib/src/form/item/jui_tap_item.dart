// jui_tap_item.dart
import 'package:flutter/material.dart';
import 'package:jui/src/utils/extension.dart';

import '../../../generated/assets.dart';
import '../../utils/jui_theme.dart';
import 'jui_item.dart';
import 'jui_item_config.dart';

class JuiTapItem extends StatelessWidget {
// 定义JuiTapItem类中的属性
  // title: 用于显示的标题文本
  final String title;

  // contentText: 主要内容的文本
  final String contentText;

  // hintText: 当内容文本不显示时，用于提示的文本
  final String hintText;

  // maxLines: 内容文本显示的最大行数
  final int maxLines;

  // trailing: 可选的尾部组件，例如图标或按钮
  final Widget? trailing;

  // config: JuiTapItem的配置信息，可能包含样式、行为等设置
  final JuiItemConfig config;

  const JuiTapItem({
    Key? key,
    required this.title,
    required this.contentText,
    required this.hintText,
    this.maxLines = 1,
    this.trailing,
    this.config = const JuiItemConfig(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return JuiItem(
      title: title,
      content: _buildTapContent(),
      config: config,
    );
  }

  Widget _buildTapContent() {
    return Row(
      children: [
        Expanded(
          child: Text(
            contentText.isEmpty ? hintText : contentText,
            style: _getTextStyleForConfig(),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing ??
            Image.asset(
              config.isDisabled ? Assets.imagesMoreDisabled.path : Assets.imagesMore.path,
              height: 12,
            )
      ],
    );
  }

  ///根据配置展示文本样式
  TextStyle _getTextStyleForConfig() {
    if(contentText.isEmpty) {
      if(config.customTipsTextStyle != null) {
        return config.customTipsTextStyle!;
      }
    } else {
      if(config.customContentStyle != null) {
        return config.customContentStyle!;
      }
    }
    return _getTextStyle();
  }

  TextStyle _getTextStyle() {
    if (contentText.isEmpty) {
      return config.isDisabled ? JuiTheme.textStyles.itemHintDisabled : JuiTheme.textStyles.itemHint;
    }
    return JuiTheme.textStyles.itemContent;
  }
}
