# =====================================
# 此文件用于自定义键盘按键功能。
# 可根据需要修改下方内容，调整各类按键的行为
# 修改完成后，保存本文件，然后回到皮肤界面，
# 长按皮肤，选择「运行 main.jsonnet」生效。
#
# 包含中文26键布局和英文26键布局中的字母键
# =====================================

local colors = import '../Constants/Colors.libsonnet';
local fonts = import '../Constants/Fonts.libsonnet';
local settings = import '../Settings.libsonnet';

{
  local root = self,

  // 按键定义
  qButton: {
    name: 'qButton',
    params: {
      action: { character: 'q' },
      whenKeyboardAction: [
        { notificationKeyboardAction: { sendKeys: 'backslash' }, text: '(q)' },
      ],
      uppercased: { action: { character: 'Q' } },
      swipeUp: { action: { character: '1' } },
      longPress: [
        { action: { character: 'Q' } },
      ],
    },
  },
  wButton: {
    name: 'wButton',
    params: {
      action: { character: 'w' },
      whenKeyboardAction: [
        { notificationKeyboardAction: { sendKeys: 'backslash' }, text: '（w）' },
      ],
      uppercased: { action: { character: 'W' } },
      swipeUp: { action: { character: '2' } },
      longPress: [
        { action: { character: 'W' } },
      ],
    },
  },
  eButton: {
    name: 'eButton',
    params: {
      action: { character: 'e' },
      whenKeyboardAction: [
        { notificationKeyboardAction: { sendKeys: 'backslash' }, text: '⟮e⟯' },
      ],
      uppercased: { action: { character: 'E' } },
      swipeUp: { action: { character: '3' } },
      longPress: [
        { action: { sendKeys: '/emo' }, text: '颜' },
        { action: { sendKeys: '/bq' }, text: '表情' },
        { action: { character: 'E' }, selected: true },
        { action: { sendKeys: '/aa' }, text: '动物' },
        { action: { sendKeys: '/ss' }, text: '手势' },
      ],
    },
  },
  rButton: {
    name: 'rButton',
    params: {
      action: { character: 'r' },
      whenKeyboardAction: [
        { notificationKeyboardAction: { sendKeys: 'backslash' }, text: '儿' },
      ],
      uppercased: { action: { character: 'R' } },
      swipeUp: { action: { character: '4' } },
      longPress: [
        { action: { character: 'R' } },
      ],
    },
  },
  tButton: {
    name: 'tButton',
    params: {
      action: { character: 't' },
      whenKeyboardAction: [
        { notificationKeyboardAction: { sendKeys: 'backslash' }, text: '⟨t⟩' },
      ],
      uppercased: { action: { character: 'T' } },
      swipeUp: { action: { character: '5' } },
      longPress: [
        { action: { character: 'T' } },
      ],
    },
  },
  yButton: {
    name: 'yButton',
    params: {
      action: { character: 'y' },
      whenKeyboardAction: [
        { notificationKeyboardAction: { sendKeys: 'backslash' }, text: '⟪y⟫' },
      ],
      uppercased: { action: { character: 'Y' } },
      swipeUp: { action: { character: '6' } },
      longPress: [
        { action: { character: 'Y' } },
      ],
    },
  },
  uButton: {
    name: 'uButton',
    params: {
      action: { character: 'u' },
      whenKeyboardAction: [
        { notificationKeyboardAction: { sendKeys: 'backslash' }, text: '〈u〉' },
      ],
      uppercased: { action: { character: 'U' } },
      swipeUp: { action: { character: '7' } },
      longPress: [
        { action: { character: 'U' } },
      ],
    },
  },
  iButton: {
    name: 'iButton',
    params: {
      action: { character: 'i' },
      whenKeyboardAction: [
        { notificationKeyboardAction: { sendKeys: 'backslash' }, text: '『i』' },
      ],
      uppercased: { action: { character: 'I' } },
      swipeUp: { action: { character: '8' } },
      swipeDown: { action: { character: '|' } },
      longPress: [
        { action: { character: 'I' } },
      ],
    },
  },
  oButton: {
    name: 'oButton',
    params: {
      action: { character: 'o' },
      whenKeyboardAction: [
        { notificationKeyboardAction: { sendKeys: 'backslash' }, text: '⦅o⦆' },
      ],
      uppercased: { action: { character: 'O' } },
      swipeUp: { action: { character: '9' } },
      swipeDown: { action: { character: '<' } },
      longPress: [
        { action: { character: 'O' } },
      ],
    },
  },
  pButton: {
    name: 'pButton',
    params: {
      action: { character: 'p' },
      whenKeyboardAction: [
        { notificationKeyboardAction: { sendKeys: 'backslash' }, text: '⦇p⦈' },
      ],
      uppercased: { action: { character: 'P' } },
      swipeUp: { action: { character: '0' } },
      swipeDown: { action: { character: '>' } },
      longPress: [
        { action: { character: 'P' } },
      ],
    },
  },

  // 第二行字母键 (ASDF)
  aButton: {
    name: 'aButton',
    params: {
      action: { character: 'a' },
      whenKeyboardAction: [
        { notificationKeyboardAction: { sendKeys: 'backslash' }, text: '[a]' },
      ],
      uppercased: { action: { character: 'A' } },
      swipeUp: { action: { character: '!' } },
      longPress: [
        { action: { character: 'A' }, selected: true },
        { action: { shortcut: '#左手模式' }, systemImageName: 'keyboard.onehanded.left' },
      ],
    },
  },
  sButton: {
    name: 'sButton',
    params: {
      action: { character: 's' },
      whenKeyboardAction: [
        { notificationKeyboardAction: { sendKeys: 'backslash' }, text: '［s］' },
      ],
      uppercased: { action: { character: 'S' } },
      swipeUp: { action: { character: '^' } },
      swipeDown: { action: { character: '%' } },
      longPress: [
        { action: { character: 'S' } },
      ],
    },
  },
  dButton: {
    name: 'dButton',
    params: {
      action: { character: 'd' },
      whenKeyboardAction: [
        { notificationKeyboardAction: { sendKeys: 'backslash' }, text: '〔d〕' },
      ],
      uppercased: { action: { character: 'D' } },
      swipeUp: { action: { character: '@' } },
      swipeDown: { action: { character: '\\' } },
      longPress: [
        { action: { sendKeys: '/date' }, text: '日期' },
        { action: { sendKeys: '/time' }, text: '时间' },
        { action: { character: 'D' }, selected: true  },
        { action: { sendKeys: '/cdate' }, text: '农历' },
        { action: { sendKeys: '/fjq' }, text: '节气' },
        { action: { sendKeys: '/week' }, text: '周' },
      ],
    },
  },
  fButton: {
    name: 'fButton',
    params: {
      action: { character: 'f' },
      whenKeyboardAction: [
        { notificationKeyboardAction: { sendKeys: 'backslash' }, text: '⟦f⟧' },
      ],
      uppercased: { action: { character: 'F' } },
      swipeUp: { action: { character: '*' } },
      swipeDown: { action: { character: '~' } },
      longPress: [
        { action: { shortcut: '#showPhraseView' }, text: '短语' },
        { action: { character: 'F' }, selected: true   },
        { action: { shortcut: '#showPasteboardView' }, text: '剪切' },
      ],
    },
  },
  gButton: {
    name: 'gButton',
    params: {
      action: { character: 'g' },
      whenKeyboardAction: [
        { notificationKeyboardAction: { sendKeys: 'backslash' }, text: '「g」' },
      ],
      uppercased: { action: { character: 'G' } },
      swipeUp: { action: { character: '(' } },
      swipeDown: { action: { character: ')' } },
      longPress: [
        { action: { character: 'G' } },
      ],
    },
  },
  hButton: {
    name: 'hButton',
    params: {
      action: { character: 'h' },
      whenKeyboardAction: [
        { notificationKeyboardAction: { sendKeys: 'backslash' }, text: '#' },
      ],
      uppercased: { action: { character: 'H' } },
      swipeUp: { action: { character: '-' } },
      swipeDown: { action: { character: '_' } },
      longPress: [
        { action: { character: 'H' } },
      ],
    },
  },
  jButton: {
    name: 'jButton',
    params: {
      action: { character: 'j' },
      whenKeyboardAction: [
        { notificationKeyboardAction: { sendKeys: 'backslash' }, text: '<j>' },
      ],
      uppercased: { action: { character: 'J' } },
      swipeUp: { action: { character: '#' } },
      swipeDown: { action: { character: '+' } },
      longPress: [
        { action: { character: 'J' } },
      ],
    },
  },
  kButton: {
    name: 'kButton',
    params: {
      action: { character: 'k' },
      whenKeyboardAction: [
        { notificationKeyboardAction: { sendKeys: 'backslash' }, text: '《k》' },
      ],
      uppercased: { action: { character: 'K' } },
      swipeUp: { action: { character: '{' } },
      swipeDown: { action: { character: '}' } },
      longPress: [
        { action: { sendKeys: '/em' }, text: '邮箱' },
        { action: { sendKeys: '/ph' }, text: '手机' },
        { action: { character: 'K' } },
        { action: { sendKeys: '/fh' }, text: '符号' },
      ],
    },
  },
  lButton: {
    name: 'lButton',
    params: {
      action: { character: 'l' },
      whenKeyboardAction: [
        { notificationKeyboardAction: { sendKeys: 'backslash' }, text: '〈l〉' },
      ],
      uppercased: { action: { character: 'L' } },
      swipeUp: { action: { character: '"' } },
      swipeDown: { action: { character: "&" } },
      longPress: [
        { action: { shortcut: '#右手模式' }, systemImageName: 'keyboard.onehanded.right' },
        { action: { character: 'L' }, selected: true },
      ],
    },
  },

  // 第三行字母键 (ZXCV)
  zButton: {
    name: 'zButton',
    params: {
      action: { character: 'z' },
      whenKeyboardAction: [
        { notificationKeyboardAction: { sendKeys: 'backslash' }, text: '{z}' },
      ],
      uppercased: { action: { character: 'Z' } },
      swipeUp: { action: { character: '`' } },
      longPress: [
        { action: { character: 'Z' } },
      ],
    },
  },
  xButton: {
    name: 'xButton',
    params: {
      action: { character: 'x' },
      whenKeyboardAction: [
        { notificationKeyboardAction: { sendKeys: 'backslash' }, text: '｛x｝' },
      ],
      uppercased: { action: { character: 'X' } },
      swipeUp: { action: { character: '/' } },
      longPress: [
        { action: { character: 'X' } },
      ],
    },
  },
  cButton: {
    name: 'cButton',
    params: {
      action: { character: 'c' },
      whenKeyboardAction: [
        { notificationKeyboardAction: { sendKeys: 'backslash' }, text: '❲c❳' },
      ],
      uppercased: { action: { character: 'C' } },
      swipeUp: { action: { character: "'" } },
      longPress: [
        { action: { character: 'C' } },
      ],
    },
  },
  vButton: {
    name: 'vButton',
    params: {
      action: { character: 'v' },
      whenKeyboardAction: [
        { notificationKeyboardAction: { sendKeys: 'backslash' }, text: '❰v❱' },
      ],
      uppercased: { action: { character: 'V' } },
      swipeUp: { action: { character: '=' } },
      longPress: [
        { action: { character: 'V' } },
      ],
    },
  },
  bButton: {
    name: 'bButton',
    params: {
      action: { character: 'b' },
      whenKeyboardAction: [
        { notificationKeyboardAction: { sendKeys: 'backslash' }, text: '【b】' },
      ],
      uppercased: { action: { character: 'B' } },
      swipeUp: { action: { character: '[' } },
      swipeDown: { action: { character: ']' } },
      longPress: [
        { action: { character: 'B' } },
      ],
    },
  },
  nButton: {
    name: 'nButton',
    params: {
      action: { character: 'n' },
      whenKeyboardAction: [
        { notificationKeyboardAction: { sendKeys: 'backslash' }, text: '«n»' },
      ],
      uppercased: { action: { character: 'N' } },
      swipeUp: { action: { character: ';' } },
      swipeDown: { action: { character: ':' } },
      longPress: [
        { action: { character: 'N' } },
      ],
    },
  },
  mButton: {
    name: 'mButton',
    params: {
      action: { character: 'm' },
      whenKeyboardAction: [
        { notificationKeyboardAction: { sendKeys: 'backslash' }, text: '‹m›' },
      ],
      uppercased: { action: { character: 'M' } },
      swipeUp: { action: { character: '?' } },
      swipeDown: { action: { character: '$' } },
      longPress: [
        { action: { character: 'M' } },
      ],
    },
  },

  letterButtons: [
    self.qButton, self.wButton, self.eButton, self.rButton, self.tButton,
    self.yButton, self.uButton, self.iButton, self.oButton, self.pButton,
    self.aButton, self.sButton, self.dButton, self.fButton, self.gButton,
    self.hButton, self.jButton, self.kButton, self.lButton,
    self.zButton, self.xButton, self.cButton, self.vButton, self.bButton,
    self.nButton, self.mButton,
  ],
}
