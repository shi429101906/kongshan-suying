local toolbarParams = import '../Buttons/Toolbar.libsonnet';
local basicStyle = import 'BasicStyle.libsonnet';
local utils = import 'Utils.libsonnet';

local keyboardLayout = {
  keyboardLayout: [
    {
      HStack: {
        subviews: [
          { Cell: toolbarParams.toolbarButton.toolbarHamster3Button.name }, // 设置
          { Cell: toolbarParams.toolbarButton.toolbarRimeInputSchemaButton.name }, // 方案切换
          { Cell: toolbarParams.toolbarButton.toolbarSkinPreference.name }, // 微调
          { Cell: toolbarParams.toolbarButton.toolbarFeedbackButton.name }, // 震动
        ],
      },
    },
    {
      HStack: {
        subviews: [
          { Cell: toolbarParams.toolbarButton.toolbarSkinButton.name }, // 皮肤
          { Cell: toolbarParams.toolbarButton.toolbarRimeDeployButton.name }, // 部署
          { Cell: toolbarParams.toolbarButton.toolbarRimeSyncButton.name }, // 同步
          { Cell: toolbarParams.toolbarButton.toolbarToggleEmbeddedButton.name }, // 内嵌
        ],
      },
    },
  ],
};

local newKeyLayout(isDark=false, isPortrait=false) =
  local floatTargetScale = if isPortrait then toolbarParams.floatingKeyboard.floatTargetScale.portrait else toolbarParams.floatingKeyboard.floatTargetScale.landscape;
  {
    floatTargetScale: floatTargetScale,
    keyboardStyle: {
        insets: toolbarParams.floatingKeyboard.insets,
      }
      + utils.newBackgroundStyle(style=basicStyle.keyboardBackgroundStyleName),
  }
  + keyboardLayout
  + std.foldl(function(acc, button) acc +
      basicStyle.newFloatingKeyboardButton(button.name, isDark, button.params),
      [
        toolbarParams.toolbarButton.toolbarHamster3Button,
        toolbarParams.toolbarButton.toolbarRimeInputSchemaButton,
        toolbarParams.toolbarButton.toolbarSkinPreference,
        toolbarParams.toolbarButton.toolbarFeedbackButton,
        toolbarParams.toolbarButton.toolbarSkinButton,
        toolbarParams.toolbarButton.toolbarRimeDeployButton,
        toolbarParams.toolbarButton.toolbarRimeSyncButton,
        toolbarParams.toolbarButton.toolbarToggleEmbeddedButton,
      ],
      {});

{
  new(isDark=false, isPortrait=false):
    basicStyle.newKeyboardBackgroundStyle(isDark)
    + basicStyle.newFloatingKeyboardButtonBackgroundStyle(isDark)
    + newKeyLayout(isDark, isPortrait),
}
