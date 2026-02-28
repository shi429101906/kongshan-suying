local buttons = import '../Buttons/LayoutBopomofo.libsonnet';
local commonButtons = import '../Buttons/Common.libsonnet';
local toolbarParams = import '../Buttons/Toolbar.libsonnet';
local settings = import '../Settings.libsonnet';
local basicStyle = import 'BasicStyle.libsonnet';
local preedit = import 'Preedit.libsonnet';
local toolbar = import 'Toolbar.libsonnet';
local utils = import 'Utils.libsonnet';

local portraitNormalButtonSize = {
  size: { width: '3/33' },
};

// 注音佈局
local getRows = [
  [
    buttons.bpmfOneButton,
    buttons.bpmfTwoButton,
    buttons.bpmfThreeButton,
    buttons.bpmfFourButton,
    buttons.bpmfFiveButton,
    buttons.bpmfSixButton,
    buttons.bpmfSevenButton,
    buttons.bpmfEightButton,
    buttons.bpmfNineButton,
    buttons.bpmfZeroButton,
    buttons.bpmfDashButton,
  ],
  [
    buttons.qButton,
    buttons.wButton,
    buttons.eButton,
    buttons.rButton,
    buttons.tButton,
    buttons.yButton,
    buttons.uButton,
    buttons.iButton,
    buttons.oButton,
    buttons.pButton,
  ],
  [
    buttons.aButton,
    buttons.sButton,
    buttons.dButton,
    buttons.fButton,
    buttons.gButton,
    buttons.hButton,
    buttons.jButton,
    buttons.kButton,
    buttons.lButton,
    buttons.bpmfSemicolonButton,
  ],
  [
    buttons.zButton,
    buttons.xButton,
    buttons.cButton,
    buttons.vButton,
    buttons.bButton,
    buttons.nButton,
    buttons.mButton,
    buttons.bpmfCommaButton,
    buttons.bpmfPeriodButton,
    buttons.bpmfSlashButton,
    commonButtons.backspaceButton,
  ],
  [
    commonButtons.numericButton,
    buttons.commaButton,
    buttons.spaceButton,
    commonButtons.alphabeticButton,
    buttons.enterButton,
  ],
];

local getAlphabeticButtonSize(name) =
  local extra = {
    [buttons.qButton.name]: {
      size:
        { width: '4/33' },
      bounds:
        { width: '3/4', alignment: 'right' },
    },
    [buttons.pButton.name]: {
      size:
        { width: '5/33' },
      bounds:
        { width: '3/5', alignment: 'left' },
    },
    [buttons.aButton.name]: {
      size:
        { width: '5/33' },
      bounds:
        { width: '3/5', alignment: 'right' },
    },
    [buttons.bpmfSemicolonButton.name]: {
      size:
        { width: '4/33' },
      bounds:
        { width: '4/5', alignment: 'left' },
    },
  };
  (
  if std.objectHas(extra, name) then
    extra[name]
  else
    portraitNormalButtonSize
  );


local newKeyLayout(isDark=false, isPortrait=true) =
  local rows = getRows;
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
        getAlphabeticButtonSize(button.name) + button.params + basicStyle.hintStyleSize + basicStyle.textCenterWhenShowSwipeText,
        swipeTextFollowSetting=true),
      buttons.letterButtons,
      {})

  + basicStyle.newSystemButton(
    commonButtons.backspaceButton.name,
    isDark,
    portraitNormalButtonSize
    + commonButtons.backspaceButton.params,
  )

  // Last Row
  + basicStyle.newSystemButton(
    commonButtons.numericButton.name,
    isDark,
    { size: { width: { percentage: 0.2 } } }
    + commonButtons.numericButton.params
  )

  + basicStyle.newAlphabeticButton(
    buttons.commaButton.name,
    isDark,
    { size: { width: { percentage: 0.1 } } }
    + buttons.commaButton.params + basicStyle.hintStyleSize
  )
  + basicStyle.newAlphabeticButton(
    buttons.spaceButton.name,
    isDark,
    {
      foregroundStyleName: basicStyle.spaceButtonForegroundStyle,
      foregroundStyle: basicStyle.newSpaceButtonRimeSchemaForegroundStyle('$rimeSchemaName', isDark),
    }
    + buttons.spaceButton.params,
    needHint=false,
  )
  +
  basicStyle.newSystemButton(
    commonButtons.alphabeticButton.name,
    isDark,
    { size: { width: { percentage: 0.1 } } }
    + commonButtons.alphabeticButton.params
  )
  + basicStyle.newColorButton(
    buttons.enterButton.name,
    isDark,
    { size: { width: { percentage: 0.22 } } }
    + buttons.enterButton.params
  )
;

local backgroundInsets = if !settings.iPad then
{
  portrait: { top: 3, left: 2, bottom: 3, right: 2 },
  landscape: { top: 2, left: 2, bottom: 2, right: 2 },
}
else
{
  portrait: { top: 3, left: 3, bottom: 3, right: 3 },
  landscape: { top: 4, left: 6, bottom: 4, right: 6 },
};

{
  new(isDark, isPortrait):
    local insets = if isPortrait then backgroundInsets.portrait else backgroundInsets.landscape;

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
