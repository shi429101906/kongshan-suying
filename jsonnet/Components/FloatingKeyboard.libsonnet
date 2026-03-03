local toolbarParams = import '../Buttons/Toolbar.libsonnet';
local basicStyle = import 'BasicStyle.libsonnet';
local utils = import 'Utils.libsonnet';

local floatingKeyboardButtonsDefine = {
  // 浮动键盘面板按钮定义，格式如下：

  // 第一个浮动键盘名称: [
  //    [按钮行1],
  //    [按钮行2],
  // ],
  // 第二个浮动键盘名称: [
  //    [按钮行1],
  //    [按钮行2],
  // ],

  panel: [
    [
      toolbarParams.toolbarButton.toolbarHamster3Button, // 设置
      toolbarParams.toolbarButton.toolbarRimeInputSchemaButton, // 方案切换
      toolbarParams.toolbarButton.toolbarSkinPreference, // 微调
      toolbarParams.toolbarButton.toolbarFeedbackButton, // 震动
    ],
    [
      toolbarParams.toolbarButton.toolbarSkinButton, // 皮肤
      toolbarParams.toolbarButton.toolbarRimeDeployButton, // 部署
      toolbarParams.toolbarButton.toolbarRimeSyncButton, // 同步
      toolbarParams.toolbarButton.toolbarToggleEmbeddedButton, // 内嵌
    ],
  ],
};

local newKeyLayout(buttonsInRow, isDark=false, isPortrait=false) =
  local floatTargetScale = if isPortrait then toolbarParams.floatingKeyboard.floatTargetScale.portrait else toolbarParams.floatingKeyboard.floatTargetScale.landscape;
  {
    floatTargetScale: floatTargetScale,
    keyboardStyle: {
        insets: toolbarParams.floatingKeyboard.insets,
      }
      + utils.newBackgroundStyle(style=basicStyle.keyboardBackgroundStyleName),
  }
  + utils.newRowKeyboardLayout(buttonsInRow)
  + std.foldl(function(acc, button) acc +
      basicStyle.newFloatingKeyboardButton(button.name, isDark, button.params),
      std.flattenArrays(buttonsInRow),
      {});

local newFloatingKeyboard(buttonsInRow, isDark=false, isPortrait=false) =
  basicStyle.newKeyboardBackgroundStyle(isDark)
  + basicStyle.newFloatingKeyboardButtonBackgroundStyle(isDark)
  + newKeyLayout(buttonsInRow, isDark, isPortrait);

{
  new(isDark=false, isPortrait=false):
    {
      [name]: newFloatingKeyboard(floatingKeyboardButtonsDefine[name], isDark, isPortrait)
      for name in std.objectFields(floatingKeyboardButtonsDefine)
    }
}
