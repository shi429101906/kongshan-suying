local buttons = import '../../Buttons/Layout17.libsonnet';
local commonButtons = import '../../Buttons/Common.libsonnet';
local toolbarParams = import '../../Buttons/Toolbar.libsonnet';
local settings = import '../../Settings.libsonnet';
local basicStyle = import '../../Styles/BasicStyle.libsonnet';
local preedit = import '../Preedit.libsonnet';
local toolbar = import '../Toolbar.libsonnet';
local utils = import '../../Utils/Utils.libsonnet';

// 功能行按键（光标移动 / 编辑操作）
local funcRow = [
  commonButtons.funcLeftButton,
  commonButtons.funcHeadButton,
  commonButtons.funcSelectButton,
  commonButtons.funcCutButton,
  commonButtons.funcCopyButton,
  commonButtons.funcPasteButton,
  commonButtons.funcTailButton,
  commonButtons.funcRightButton,
];

// 功能行高度，修改这里调整按键行的高低
// 竖屏总高 = keyboardHeight.portrait + funcRowHeight.portrait
local funcRowHeight = {
  portrait: 45,
  landscape: 32,
};

// 乱序17键布局
local keyboardLayout = {
  keyboardLayout: [
    {
      // 通过 style 引用 funcRowStyle，单独控制这一行的高度
      HStack: {
        style: 'funcRowStyle',
        subviews: [
          { Cell: commonButtons.funcLeftButton.name },
          { Cell: commonButtons.funcHeadButton.name },
          { Cell: commonButtons.funcSelectButton.name },
          { Cell: commonButtons.funcCutButton.name },
          { Cell: commonButtons.funcCopyButton.name },
          { Cell: commonButtons.funcPasteButton.name },
          { Cell: commonButtons.funcTailButton.name },
          { Cell: commonButtons.funcRightButton.name },
        ],
      },
    },
    {
      HStack: {
        subviews: [
          { Cell: buttons.hButton.name },
          { Cell: buttons.sButton.name },
          { Cell: buttons.zButton.name },
          { Cell: buttons.bButton.name },
          { Cell: buttons.xButton.name },
          { Cell: buttons.mButton.name },
        ],
      },
    },
    {
      HStack: {
        subviews: [
          { Cell: buttons.lButton.name },
          { Cell: buttons.dButton.name },
          { Cell: buttons.yButton.name },
          { Cell: buttons.wButton.name },
          { Cell: buttons.jButton.name },
          { Cell: buttons.nButton.name },
        ],
      },
    },
    {
      HStack: {
        subviews: [
          { Cell: buttons.cButton.name },
          { Cell: buttons.qButton.name },
          { Cell: buttons.gButton.name },
          { Cell: buttons.fButton.name },
          { Cell: buttons.tButton.name },
          { Cell: commonButtons.backspaceButton.name },
        ],
      },
    },
    {
      HStack: {
        subviews: [
          { Cell: commonButtons.numericButton.name },
          { Cell: commonButtons.commaButton.name },
          { Cell: commonButtons.spaceButton.name },
          { Cell: commonButtons.alphabeticButton.name },
          { Cell: commonButtons.enterButton.name },
        ],
      },
    },
  ],
};

local newKeyLayout(isDark=false, isPortrait=true) =
  local totalKeyboardHeight = if isPortrait then commonButtons.keyboardHeight.portrait else commonButtons.keyboardHeight.landscape;
  local fRowHeight = if isPortrait then funcRowHeight.portrait else funcRowHeight.landscape;
  {
    keyboardHeight: totalKeyboardHeight + fRowHeight,
    keyboardStyle: utils.newBackgroundStyle(style=basicStyle.keyboardBackgroundStyleName),

    // HStack style：用分数字符串表示功能行占总高度的比例
    funcRowStyle: {
      size: {
        height: '%d/%d' % [fRowHeight, totalKeyboardHeight + fRowHeight],
      },
    },
  }
  + keyboardLayout

  // Function Row Buttons
  + std.foldl(function(acc, button)
      acc +
      basicStyle.newAlphabeticButton(
        button.name,
        isDark,
        { fontSize: 16 } + button.params,
        needHint=false,
      ),
      funcRow,
      {})

  // letter Buttons
  + std.foldl(function(acc, button)
      acc +
      basicStyle.newAlphabeticButton(
        button.name,
        isDark,
        button.params + basicStyle.hintStyleSize + basicStyle.textCenterWhenShowSwipeText),
      buttons.letterButtons,
      {})

  // Third Row
  + basicStyle.newSystemButton(
    commonButtons.backspaceButton.name,
    isDark,
    commonButtons.backspaceButton.params,
  )

  // Fourth Row
  + basicStyle.newSystemButton(
    commonButtons.numericButton.name,
    isDark,
    { size: { width: { percentage: 0.2 } } }
    + commonButtons.numericButton.params
  )

  + basicStyle.newAlphabeticButton(
    commonButtons.commaButton.name,
    isDark,
    { size: { width: { percentage: 0.12 } } }
    + commonButtons.commaButton.params + basicStyle.hintStyleSize,
    swipeTextFollowSetting=false,
  )
  + basicStyle.newAlphabeticButton(
    commonButtons.spaceButton.name,
    isDark,
    basicStyle.newSpaceButtonForegroundStyle(commonButtons.spaceButton.params, '$rimeSchemaName', isDark),
    needHint=false,
  )
  + basicStyle.newSystemButton(
    commonButtons.alphabeticButton.name,
    isDark,
    { size: { width: { percentage: 0.12 } } }
    + commonButtons.alphabeticButton.params
  )
  + basicStyle.newColorButton(
    commonButtons.enterButton.name,
    isDark,
    { size: { width: { percentage: 0.22 } } }
    + commonButtons.enterButton.params
  )
;

{
  new(isDark, isPortrait):
    local insets = if isPortrait then commonButtons.backgroundInsets.portrait else commonButtons.backgroundInsets.landscape;

    local extraParams = {
      insets: insets,
    };

    preedit.new(isDark)
    + toolbar.new(isDark, isPortrait, 'pinyin')
    + basicStyle.newKeyboardBackgroundStyle(isDark)
    + basicStyle.newAlphabeticButtonBackgroundStyle(isDark, extraParams)
    + basicStyle.newSystemButtonBackgroundStyle(isDark, extraParams)
    + basicStyle.newColorButtonBackgroundStyle(isDark, extraParams)
    + basicStyle.newAlphabeticHintBackgroundStyle(isDark, { cornerRadius: 10 })
    + basicStyle.newLongPressSymbolsBackgroundStyle(isDark, extraParams)
    + basicStyle.newLongPressSymbolsSelectedBackgroundStyle(isDark, extraParams)
    + basicStyle.newButtonAnimation()
    + newKeyLayout(isDark, isPortrait)
    // Notifications
    + basicStyle.rimeSchemaChangedNotification
}
