local buttons = import '../Buttons/Layout18.libsonnet';
local commonButtons = import '../Buttons/Common.libsonnet';
local toolbarParams = import '../Buttons/Toolbar.libsonnet';
local settings = import '../Settings.libsonnet';
local basicStyle = import 'BasicStyle.libsonnet';
local preedit = import 'Preedit.libsonnet';
local toolbar = import 'Toolbar.libsonnet';
local utils = import 'Utils.libsonnet';

// 18键布局
local rows = [
  [
    buttons.qButton,
    buttons.wButton,
    buttons.rButton,
    buttons.yButton,
    buttons.uButton,
    buttons.iButton,
    buttons.pButton,
  ],
  [
    buttons.aButton,
    buttons.sButton,
    buttons.fButton,
    buttons.hButton,
    buttons.jButton,
    buttons.lButton,
  ],
  [
    commonButtons.shiftButton,
    buttons.zButton,
    buttons.xButton,
    buttons.vButton,
    buttons.bButton,
    buttons.mButton,
    commonButtons.backspaceButton,
  ],
  [
    commonButtons.numericButton,
    commonButtons.commaButton,
    commonButtons.spaceButton,
    commonButtons.alphabeticButton,
    commonButtons.enterButton,
  ],
];

local getAlphabeticButtonSize(name) =
  local extra = {
    [buttons.aButton.name]: {
      size:
        { width: '1.5/7' },
      bounds:
        { width: '1/1.5', alignment: 'right' },
    },
    [buttons.lButton.name]: {
      size:
        { width: '1.5/7' },
      bounds:
        { width: '1/1.5', alignment: 'left' },
    },
  };
  (
  if std.objectHas(extra, name) then
    extra[name]
  else
    {}
  );


local newKeyLayout(isDark=false, isPortrait=true) =
  {
    keyboardHeight: if isPortrait then commonButtons.keyboardHeight.portrait else commonButtons.keyboardHeight.landscape,
    keyboardStyle: utils.newBackgroundStyle(style=basicStyle.keyboardBackgroundStyleName),
  }
  + utils.newRowKeyboardLayout(rows)

  // letter Buttons
  + std.foldl(function(acc, button)
      acc +
      basicStyle.newAlphabeticButton(
        button.name,
        isDark,
        getAlphabeticButtonSize(button.name) + button.params + basicStyle.hintStyleSize + basicStyle.textCenterWhenShowSwipeText +
        {
          [if settings.uppercaseForChinese then 'text']: std.asciiUpper(button.params.text)
        }),
      buttons.letterButtons,
      {})

  // Third Row
  + basicStyle.newSystemButton(
    commonButtons.shiftButton.name,
    isDark,
    commonButtons.shiftButton.params
  )

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
    + toolbar.new(isDark, isPortrait)
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
    + basicStyle.returnKeyTypeChangedNotification,
}
