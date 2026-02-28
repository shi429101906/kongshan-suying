local buttons = import '../Buttons/Layout26.libsonnet';
local commonButtons = import '../Buttons/Common.libsonnet';
local toolbarParams = import '../Buttons/Toolbar.libsonnet';
local settings = import '../Settings.libsonnet';
local basicStyle = import 'BasicStyle.libsonnet';
local preedit = import 'Preedit.libsonnet';
local toolbar = import 'Toolbar.libsonnet';
local utils = import 'Utils.libsonnet';

local portraitNormalButtonSize = {
  size: { width: '112.5/1125' },
};

// 枚举键盘类型
local KeyboardType = {
  Chinese: 0,
  English: 1,
  Temp26Key: 2,
};

// 标准26键布局
local getRows(keyboardType) = [
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
  ],
  [
    commonButtons.shiftButton,
    buttons.zButton,
    buttons.xButton,
    buttons.cButton,
    buttons.vButton,
    buttons.bButton,
    buttons.nButton,
    buttons.mButton,
    commonButtons.backspaceButton,
  ],
  [
    commonButtons.numericButton,
    commonButtons.commaButton,
    commonButtons.spaceButton,
    if keyboardType == KeyboardType.English then commonButtons.pinyinButton
    else if keyboardType == KeyboardType.Temp26Key then commonButtons.goBackButton
    else commonButtons.alphabeticButton,
    commonButtons.enterButton,
  ],
];

local getAlphabeticButtonSize(name) =
  local extra = {
    [buttons.aButton.name]: {
      size:
        { width: '168.75/1125' },
      bounds:
        { width: '111/168.75', alignment: 'right' },
    },
    [buttons.lButton.name]: {
      size:
        { width: '168.75/1125' },
      bounds:
        { width: '111/168.75', alignment: 'left' },
    },
  };
  (
  if std.objectHas(extra, name) then
    extra[name]
  else
    portraitNormalButtonSize
  );

// 英文键盘下，对按键的 params 进行处理
// 1. 将 character 替换为 symbol
//    处理方式为 params = replaceCharacterToSymbolRecursive(params)
// 2. 将 params 中的 whenAlphabetic 合并到 params
//    处理方式为 params = std.objectRemoveKey(params + std.get(params, 'whenAlphabetic', default={}), 'whenAlphabetic') 的内容
local processButtonParams(keyboardType, params) =
  if keyboardType == KeyboardType.English then
    local paramsWithSymbol = utils.replaceCharacterToSymbolRecursive(params);
    utils.deepMerge(paramsWithSymbol, std.get(paramsWithSymbol, 'whenAlphabetic', default={}))
  else
    params;

local newKeyLayout(isDark=false, isPortrait=true, keyboardType=KeyboardType.Chinese) =
  local rows = getRows(keyboardType);
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
        getAlphabeticButtonSize(button.name) +
        processButtonParams(keyboardType, button.params) + basicStyle.hintStyleSize + basicStyle.textCenterWhenShowSwipeText +
        (
          if keyboardType != KeyboardType.English && settings.uppercaseForChinese then
            basicStyle.newAlphabeticButtonUppercaseForegroundStyle(isDark, button.params) + basicStyle.getKeyboardActionText(button.params.uppercased)
          else {}
        )
        ,
        swipeTextFollowSetting=true),
      buttons.letterButtons,
      {})

  // Third Row
  + basicStyle.newSystemButton(
    commonButtons.shiftButton.name,
    isDark,
    (
      if settings.keyboardLayout=='26b' then portraitNormalButtonSize else
      {
        size:
          { width: '168.75/1125' },
        bounds:
          { width: '151/168.75', alignment: 'left' },
      }
    )
    + processButtonParams(keyboardType, commonButtons.shiftButton.params)
  )

  + basicStyle.newSystemButton(
    commonButtons.backspaceButton.name,
    isDark,
    (
      if settings.keyboardLayout=='26b' then
      {
        size: { width: '225/1125' },
      }
      else
      {
        size:
          { width: '168.75/1125' },
        bounds:
          { width: '151/168.75', alignment: 'right' },
      }
    )
    + processButtonParams(keyboardType, commonButtons.backspaceButton.params),
  )

  // Fourth Row
  + basicStyle.newSystemButton(
    commonButtons.numericButton.name,
    isDark,
    { size: { width: '225/1125' } }
    + processButtonParams(keyboardType, commonButtons.numericButton.params)
  )

  + basicStyle.newAlphabeticButton(
    commonButtons.commaButton.name,
    isDark,
    portraitNormalButtonSize + processButtonParams(keyboardType, commonButtons.commaButton.params) + basicStyle.hintStyleSize
  )
  + basicStyle.newAlphabeticButton(
    commonButtons.spaceButton.name,
    isDark,
    {
      foregroundStyleName: basicStyle.spaceButtonForegroundStyle,
      foregroundStyle: basicStyle.newSpaceButtonRimeSchemaForegroundStyle(
		if keyboardType == KeyboardType.English then
		  'English'
		else if keyboardType == KeyboardType.Temp26Key then
		  '临时中文'
		else
		  '$rimeSchemaName',
		isDark),
    }
    + processButtonParams(keyboardType, commonButtons.spaceButton.params),
    needHint=false,
  )
  +
  (
    if keyboardType == KeyboardType.English then
      basicStyle.newSystemButton(
        commonButtons.pinyinButton.name,
        isDark,
        portraitNormalButtonSize
        + processButtonParams(keyboardType, commonButtons.pinyinButton.params)
      )
    else if keyboardType == KeyboardType.Temp26Key then
      basicStyle.newSystemButton(
        commonButtons.goBackButton.name,
        isDark,
        portraitNormalButtonSize
        + commonButtons.goBackButton.params
      )
    else
      basicStyle.newSystemButton(
        commonButtons.alphabeticButton.name,
        isDark,
        portraitNormalButtonSize
        + commonButtons.alphabeticButton.params
      )
  )
  + basicStyle.newColorButton(
    commonButtons.enterButton.name,
    isDark,
    {
      size: { width: '250/1125' },
    } + processButtonParams(keyboardType, commonButtons.enterButton.params)
  )
;

{
  // 枚举键盘类型
  KeyboardType:: KeyboardType,

  // keyboardType=Temp26Key 表示这个26键布局是临时使用的，比如当前是拼音17键布局，但是想使用雾凇方案中的 V 模式
  // 只在非26键布局下额外生成一个26键布局，action 使用 character，把动作发给 Rime 处理
  // 和主键盘的区别在于"中英切换键"改为"返回"键
  new(isDark, isPortrait, keyboardType=KeyboardType.Chinese):
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
    + newKeyLayout(isDark, isPortrait, keyboardType)
    // Notifications
    + basicStyle.rimeSchemaChangedNotification
    + basicStyle.returnKeyTypeChangedNotification,
}
