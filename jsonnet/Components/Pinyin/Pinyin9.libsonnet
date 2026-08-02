local fonts = import '../../Constants/Fonts.libsonnet';
local pinyin9Buttons = import '../../Buttons/Layout9.libsonnet';
local commonButtons = import '../../Buttons/Common.libsonnet';
local settings = import '../../Settings.libsonnet';
local basicStyle = import '../../Styles/BasicStyle.libsonnet';
local preedit = import '../Preedit.libsonnet';
local toolbar = import '../Toolbar.libsonnet';
local utils = import '../../Utils/Utils.libsonnet';


// 窄 VStack 宽度样式
local narrowVStackStyle = {
  local this = self,
  name: 'narrowVStackStyle',
  style: {
    [this.name]: {
      size: {
        width: { percentage: 0.18 },
      },
    },
  },
};

// 半宽 VStack 宽度样式，横屏时一半显示拼音输入，一半显示候选字
local halfVStackStyle = {
  local this = self,
  name: 'halfVStackStyle',
  style: {
    [this.name]: {
      size: {
        width: { percentage: 0.48 },
      },
    },
  },
};

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

// 功能行高度，修改这里调整按键行的高低（仅竖屏；横屏是左右分栏结构，不加这一行）
// 竖屏总高 = keyboardHeight.portrait + funcRowHeight.portrait
local funcRowHeight = {
  portrait: 45,
};

// 9 键主体：3 个并排的 VStack（左窄列 / 中间九宫格 / 右窄列）
local t9KeyboardLayout = {
  keyboardLayout: [
    {
      VStack: {
        style: narrowVStackStyle.name,
        subviews: [
          { Cell: pinyin9Buttons.t9SymbolsCollection.name, },
          { Cell: commonButtons.numericButton.name, },
        ],
      },
    },
    {
      VStack: {
        subviews: [
          {
            HStack: {
              subviews: [
                { Cell: pinyin9Buttons.t9OneButton.name, },
                { Cell: pinyin9Buttons.t9TwoButton.name, },
                { Cell: pinyin9Buttons.t9ThreeButton.name, },
              ],
            },
          },
          {
            HStack: {
              subviews: [
                { Cell: pinyin9Buttons.t9FourButton.name, },
                { Cell: pinyin9Buttons.t9FiveButton.name, },
                { Cell: pinyin9Buttons.t9SixButton.name, },
              ],
            },
          },
          {
            HStack: {
              subviews: [
                { Cell: pinyin9Buttons.t9SevenButton.name, },
                { Cell: pinyin9Buttons.t9EightButton.name, },
                { Cell: pinyin9Buttons.t9NineButton.name, },
              ],
            },
          },
          {
            HStack: {
              subviews: [
                { Cell: pinyin9Buttons.cursorRightButton.name, },
                { Cell: pinyin9Buttons.spaceButton.name, },
                { Cell: commonButtons.alphabeticButton.name, },
              ],
            },
          },
        ],
      },
    },
    {
      VStack: {
        style: narrowVStackStyle.name,
        subviews: [
          { Cell: commonButtons.backspaceButton.name, },
          { Cell: commonButtons.clearPreeditButton.name, },
          { Cell: commonButtons.enterButton.name, },
        ],
      },
    },
  ],
};

local totalKeyboardLayout(isPortrait=false) =
  if isPortrait then
    // 不再额外套一层 VStack。根数组直接放 2 个 HStack（功能行 + 主体），
    // 跟 26/14/17/18 键的「根数组是若干 HStack 行」完全同构，用的是已验证能正常按
    // style 高度分数生效的路径。主体 HStack 的 subviews 里塞 3 个 VStack（9 键的
    // 左/中/右列），这是文档里 VStack 嵌 HStack 的反方向嵌套，同样是允许的自由嵌套。
    {
      keyboardLayout: [
        {
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
            style: 'mainBodyRowStyle',
            subviews: t9KeyboardLayout.keyboardLayout,
          },
        },
      ],
    }
  else {
    keyboardLayout: [
      // 候选字区
      {
        VStack: {
          style: halfVStackStyle.name,
          subviews: [
            {
              VStack: {
                style: narrowVStackStyle.name,
                subviews: [
                  {
                    Cell: pinyin9Buttons.t9SymbolsCollection.name,
                  },
                ],
              },
            },
            {
              VStack: {
                subviews: [
                  {
                    Cell: pinyin9Buttons.t9CandidatesCollection.name,
                  },
                ],
              },
            },
          ],
        }
      },

      // 中间留白
      {
        VStack: {},
      },

      {
        VStack: {
          style: halfVStackStyle.name,
          subviews: t9KeyboardLayout.keyboardLayout,
        }
      },
    ]
  };


local newKeyLayout(isDark=false, isPortrait=false, extraParams={}) =
  local totalKeyboardHeight = if isPortrait then commonButtons.keyboardHeight.portrait else commonButtons.keyboardHeight.landscape;
  local fRowHeight = if isPortrait then funcRowHeight.portrait else 0;
  {
    // 横屏没有功能行，fRowHeight 为 0，高度不变。
    // 竖屏撑大总高度腾出功能行的空间，主体（九宫格）保持原有高度不被压缩——
    // 之前试过不撑大、让功能行从固定预算里切一块出来，结果主体被压缩了，
    // 功能行的形状问题依然没解决，纯属倒退，所以退回这个版本。
    keyboardHeight: totalKeyboardHeight + fRowHeight,
    keyboardStyle: utils.newBackgroundStyle(style=basicStyle.keyboardBackgroundStyleName),
  }
  + (
    // 只有竖屏需要这两个 style，横屏没引用它们，写了也没坏处，但没必要
    if isPortrait then {
      funcRowStyle: {
        size: {
          height: { percentage: fRowHeight / (totalKeyboardHeight + fRowHeight) },
        },
      },
      mainBodyRowStyle: {
        size: {
          height: { percentage: totalKeyboardHeight / (totalKeyboardHeight + fRowHeight) },
        },
      },
    } else {}
  )

  + totalKeyboardLayout(isPortrait)

  // Function Row Buttons（仅竖屏用到；横屏没有这一行，不生成对应样式，避免产生未引用样式的警告）
  + (
    if isPortrait then
      std.foldl(function(acc, button)
          acc +
          basicStyle.newAlphabeticButton(
            button.name,
            isDark,
            { fontSize: 16 } + button.params,
            needHint=false,
          ),
          funcRow,
          {})
    else {}
  )

  + {
    [pinyin9Buttons.t9SymbolsCollection.name]:
      utils.newBackgroundStyle(style=basicStyle.systemButtonBackgroundStyleName)
      + pinyin9Buttons.t9SymbolsCollection.params + extraParams,

    [if !isPortrait then pinyin9Buttons.t9CandidatesCollection.name]:
      utils.newBackgroundStyle(style=basicStyle.systemButtonBackgroundStyleName)
      + pinyin9Buttons.t9CandidatesCollection.params + extraParams,
  }

  // t9 Buttons
  + std.foldl(
    function(acc, button) acc +
      basicStyle.newAlphabeticButton(
        button.name,
        isDark,
        basicStyle.textCenterWhenShowSwipeText + {
          fontSize: fonts.t9ButtonTextFontSize,
        } + button.params + (
          if settings.uppercaseForChinese then
            { text: std.asciiUpper(button.params.text) }
          else {}
        ),
        needHint=false,
      ),
    pinyin9Buttons.t9Buttons,
    {})

  + basicStyle.newSystemButton(
    commonButtons.numericButton.name,
    isDark,
    {
      size: { height: '1/4' },
    } + commonButtons.numericButton.params
  )

  + basicStyle.newSystemButton(
    pinyin9Buttons.cursorRightButton.name,
    isDark,
    pinyin9Buttons.cursorRightButton.params +
    {
      size: { width: { percentage: 0.2 } },
    },
  )

  + basicStyle.newAlphabeticButton(
    pinyin9Buttons.spaceButton.name,
    isDark,
    basicStyle.newSpaceButtonForegroundStyle(pinyin9Buttons.spaceButton.params, '$rimeSchemaName', isDark),
    needHint=false,
  )

  + basicStyle.newSystemButton(
    commonButtons.alphabeticButton.name,
    isDark, commonButtons.alphabeticButton.params +
    {
      size: { width: { percentage: 0.2 } },
    }
  )

  + basicStyle.newSystemButton(
    commonButtons.backspaceButton.name,
    isDark,
    commonButtons.backspaceButton.params,
  )

  + basicStyle.newSystemButton(
    commonButtons.clearPreeditButton.name,
    isDark,
    commonButtons.clearPreeditButton.params,
  )

  + basicStyle.newColorButton(
    commonButtons.enterButton.name,
    isDark,
    {
      size: { height: '2/4' },
    } + commonButtons.enterButton.params
  );

local backgroundInsets = if !settings.iPad then
{
  portrait: { top: 3, left: 4, bottom: 3, right: 4 },
  landscape: { top: 3, left: 3, bottom: 3, right: 3 },
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
    + toolbar.new(isDark, isPortrait, 'pinyin')
    + (
      if !isPortrait then halfVStackStyle.style else {}
    )
    + narrowVStackStyle.style
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
    + basicStyle.rimeSchemaChangedNotification
}
