local numericButtons = import '../Buttons/LayoutNumeric.libsonnet';
local symbolicButtons = import '../Buttons/LayoutSymbolic.libsonnet';
local commonButtons = import '../Buttons/Common.libsonnet';
local toolbarParams = import '../Buttons/Toolbar.libsonnet';
local fonts = import '../Constants/Fonts.libsonnet';
local basicStyle = import 'BasicStyle.libsonnet';
local preedit = import 'Preedit.libsonnet';
local toolbar = import 'Toolbar.libsonnet';
local utils = import 'Utils.libsonnet';
local settings = import '../Settings.libsonnet';

local portraitNormalButtonSize = {
  size: { width: '112.5/1125' },
};

// 布局
local numericRows = [
  [
    numericButtons.oneButton,
    numericButtons.twoButton,
    numericButtons.threeButton,
    numericButtons.fourButton,
    numericButtons.fiveButton,
    numericButtons.sixButton,
    numericButtons.sevenButton,
    numericButtons.eightButton,
    numericButtons.nineButton,
    numericButtons.zeroButton,
  ],
  [
    numericButtons.hyphenButton,
    numericButtons.forwardSlashButton,
    numericButtons.chineseColonButton,
    numericButtons.chineseSemicolonButton,
    numericButtons.leftParenthesisButton,
    numericButtons.rightParenthesisButton,
    numericButtons.rmbButton,
    numericButtons.atButton,
    numericButtons.leftCurlyQuoteButton,
    numericButtons.rightCurlyQuoteButton,
  ],
  [
    commonButtons.symbolicButton,
    numericButtons.plusButton,
    numericButtons.asteriskButton,
    numericButtons.ideographicCommaButton,
    numericButtons.hashButton,
    numericButtons.chineseQuestionMarkButton,
    numericButtons.chineseExclamationMarkButton,
    numericButtons.dotButton,
    commonButtons.backspaceButton,
  ],
  [
    commonButtons.gotoPrimaryKeyboardButton,
    numericButtons.chinesePeriodButton,
    numericButtons.numericSpaceButton,
    numericButtons.numericEqualButton,
    commonButtons.enterButton,
  ],
];

local getButtonSize(name) =
  local extra = {
    [numericButtons.chinesePeriodButton.name]: portraitNormalButtonSize,
    [numericButtons.numericEqualButton.name]: portraitNormalButtonSize,
    [commonButtons.symbolicButton.name]: {
      size:
        { width: '168.75/1125' },
      bounds:
        { width: '151/168.75', alignment: 'left' },
    },
    [commonButtons.backspaceButton.name]: {
      size:
        { width: '168.75/1125' },
      bounds:
        { width: '151/168.75', alignment: 'right' },
    },
    [commonButtons.enterButton.name]: { size: { width: '250/1125' } },
  };
  (
  if std.objectHas(extra, name) then
    extra[name]
  else
    {}
  );


local newKeyLayout(isDark=false, isPortrait=false, extraParams={}) =
  {
    keyboardHeight: if isPortrait then commonButtons.keyboardHeight.portrait else commonButtons.keyboardHeight.landscape,
    keyboardStyle: utils.newBackgroundStyle(style=basicStyle.keyboardBackgroundStyleName),
  }
  + utils.newRowKeyboardLayout(numericRows)
  // number Buttons
  + std.foldl(
    function(acc, button) acc +
      basicStyle.newAlphabeticButton(
        button.name,
        isDark,
        {
          fontSize: fonts.numericButtonTextFontSize,
        }
        + button.params + basicStyle.hintStyleSize
        + (
          if utils.numericActionNeedSymbol(settings.keyboardLayout) then
          {
            action: utils.replaceCharacterToSymbolRecursive(button.params.action),
            whenPreeditChanged: {
              action: button.params.action,
            },
          }
          else {}
        ),
      ),
    numericButtons.numericButtons,
    {})
  + std.foldl(
    function(acc, button) acc +
      basicStyle.newAlphabeticButton(
        button.name,
        isDark,
        getButtonSize(button.name) + button.params + basicStyle.hintStyleSize
      ),
    [
      numericButtons.hyphenButton,
      numericButtons.forwardSlashButton,
      numericButtons.chineseColonButton,
      numericButtons.chineseSemicolonButton,
      numericButtons.leftParenthesisButton,
      numericButtons.rightParenthesisButton,
      numericButtons.rmbButton,
      numericButtons.atButton,
      numericButtons.leftCurlyQuoteButton,
      numericButtons.rightCurlyQuoteButton,

      numericButtons.plusButton,
      numericButtons.asteriskButton,
      numericButtons.ideographicCommaButton,
      numericButtons.hashButton,
      numericButtons.chineseQuestionMarkButton,
      numericButtons.chineseExclamationMarkButton,
      numericButtons.dotButton,

      numericButtons.chinesePeriodButton,
      numericButtons.numericEqualButton,
    ],
    basicStyle.newAlphabeticButton(
      numericButtons.numericSpaceButton.name,
      isDark,
      numericButtons.numericSpaceButton.params,
      needHint=false,
    ))
  + std.foldl(
    function(acc, button) acc +
      basicStyle.newSystemButton(
        button.name,
        isDark,
        button.params + getButtonSize(button.name)
      ),
    [
      commonButtons.symbolicButton,
      commonButtons.backspaceButton,
      commonButtons.enterButton,
    ],
    basicStyle.newColorButton(
      commonButtons.gotoPrimaryKeyboardButton.name,
      isDark,
      commonButtons.gotoPrimaryKeyboardButton.params + { size: { width: '225/1125' } }
    ));

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
    + newKeyLayout(isDark, isPortrait, extraParams)
    // Notifications
}
