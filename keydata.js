var appsdata=[
  {
  id: 'vscode',
  appicon:"qrc:/Images/vscode.png",
  title: 'VsCode',
  category: 'Development',
  description: 'Visual Studio Code is an open source code editor that runs everywhere. VS Code comes with many features and has an amazing support for keyboard shortcuts. Tip: Learn one or two every week.',
  sets: [
    {
      title: 'Essentials',
      id: 'essentials',
      version: 1,
      shortcuts: [
        {
          title: 'Find',
          keys: ['Ctrl', 'F'],
        },
        {
          title: 'Replace',
          keys: ['Alt', 'Ctrl', 'F'],
        },
        {
          title: 'Find Next',
          keys: ['Enter'],
        },
        {
          title: 'Find Previous',
          keys: ['Shift', 'Ctrl', 'G'],
        },
        {
          title: 'Toggle Line Comment',
          keys: ['Ctrl', '/'],
        },
        {
          title: 'Toggle Block Comment',
          keys: ['Shift', 'Alt', 'A'],
        },
        {
          title: 'Scroll Page Down',
          keys: ['Ctrl', 'down'],
        },
        {
          title: 'Scroll Page Up',
          keys: ['Ctrl', 'PageUp'],
        },
      ],
    },
    {
      title: 'Selections',
      id: 'selections',
      version: 1,
      shortcuts: [
        {
          title: 'Select current line',
          keys: ['Ctrl', 'L'],
        },
        {
          title: 'Add Selection To Next Find Match',
          keys: ['Ctrl', 'D'],
        },
        {
          title: 'Select all occurrences of current word',
          keys: ['Ctrl', 'F2'],
        },
        {
          title: 'Select all occurrences of find match',
          keys: ['Alt', 'Enter'],
        },
        {
          title: 'Select all occurrences of current selection',
          keys: ['Shift', 'Ctrl', 'L'],
        },
        {
          title: 'Expand AST Selection',
          keys: ['Ctrl', 'Shift', 'Ctrl', 'right'],
        },
        {
          title: 'Shrink AST Selection',
          keys: ['Ctrl', 'Shift', 'Ctrl', 'left'],
        },
      ],
    },
    {
      title: 'Lines',
      id: 'lines',
      version: 1,
      shortcuts: [
        {
          title: 'Cut line (empty selection)',
          keys: ['Ctrl', 'X'],
        },
        {
          title: 'Copy line (empty selection)',
          keys: ['Ctrl', 'C'],
        },
        {
          title: 'Delete Line',
          keys: ['Shift', 'Ctrl', 'K'],
        },
        {
          title: 'Insert Line Below',
          keys: ['Ctrl', 'Enter'],
        },
        {
          title: 'Insert Line Above',
          keys: ['Shift', 'Ctrl', 'Enter'],
        },
        {
          title: 'Move Line Down',
          keys: ['Alt', 'down'],
        },
        {
          title: 'Move Line Up',
          keys: ['Alt', 'up'],
        },
        {
          title: 'Copy Line Down',
          keys: ['Shift', 'Alt', 'down'],
        },
        {
          title: 'Copy Line Up',
          keys: ['Shift', 'Alt', 'up'],
        },
        {
          title: 'Indent Line',
          keys: ['Ctrl', ']'],
        },
        {
          title: 'Outdent Line',
          keys: ['Ctrl', '['],
        },
        {
          title: 'Go to End of Line',
          keys: ['End'],
        },
      ],
    },
    {
      title: 'Cursors',
      id: 'cursors',
      version: 1,
      shortcuts: [
        {
          title: 'Undo last cursor operation',
          keys: ['Ctrl', 'U'],
        },
        {
          title: 'Insert cursor at end of each line selected',
          keys: ['Shift', 'Alt', 'I'],
        },
        {
          title: 'Insert Cursor Below',
          keys: ['Alt', 'Ctrl', 'down'],
        },
        {
          title: 'Insert Cursor Above',
          keys: ['Alt', 'Ctrl', 'up'],
        },
      ],
    },
    {
      title: 'Rich Languages Editing',
      id: 'rich',
      version: 1,
      shortcuts: [
        {
          title: 'Trigger Suggest',
          keys: ['Ctrl', 'Space'],
        },
        {
          title: 'Trigger Parameter Hints',
          keys: ['Shift', 'Ctrl', 'Space'],
        },
        {
          title: 'Format Document',
          keys: ['Shift', 'Alt', 'F'],
        },
        {
          title: 'Go to Definition',
          keys: ['F12'],
        },
        {
          title: 'Peek Definition',
          keys: ['Alt', 'F12'],
        },
        {
          title: 'Quick Fix',
          keys: ['Ctrl', '.'],
        },
        {
          title: 'Peek References',
          keys: ['Shift', 'F12'],
        },
        {
          title: 'Rename Symbol',
          keys: ['F2'],
        },
        {
          title: 'Replace with Next Value',
          keys: ['Shift', 'Ctrl', '.'],
        },
        {
          title: 'Replace with Previous Value',
          keys: ['Shift', 'Ctrl', ','],
        },
      ],
    },
    {
      title: 'Navigation',
      id: 'navigation',
      version: 1,
      shortcuts: [
        {
          title: 'Show All Symbols',
          keys: ['Ctrl', 'T'],
        },
        {
          title: 'Go to Line…',
          keys: ['Ctrl', 'G'],
        },
        {
          title: 'Go to File…, Quick Open',
          keys: ['Ctrl', 'P'],
        },
        {
          title: 'Go to Symbol…',
          keys: ['Shift', 'Ctrl', 'O'],
        },
        {
          title: 'Show Problems',
          keys: ['Shift', 'Ctrl', 'M'],
        },
        {
          title: 'Go to Next Error or Warning',
          keys: ['F8'],
        },
        {
          title: 'Go to Previous Error or Warning',
          keys: ['Shift', 'F8'],
        },
        {
          title: 'Show All Commands',
          keys: ['Shift', 'Ctrl', 'P'],
        },
        {
          title: 'Navigate Editor Group History',
          keys: ['Ctrl', 'Shift', 'Tab'],
        },
        {
          title: 'Go Back',
          keys: ['Ctrl', '-'],
        },
        {
          title: 'Go Forward',
          keys: ['Ctrl', 'Shift', '-'],
        },
        {
          title: 'Go to End of File',
          keys: ['Ctrl', 'down'],
        },
        {
          title: 'Go to Beginning of File',
          keys: ['Ctrl', 'up'],
        },
      ],
    },
    {
      title: 'Window Management',
      id: 'window',
      version: 1,
      shortcuts: [
        {
          title: 'New Window',
          keys: ['Shift', 'Ctrl', 'N'],
        },
        {
          title: 'Close Window',
          keys: ['Shift', 'Ctrl', 'W'],
        },
        {
          title: 'Close Editor',
          keys: ['Ctrl', 'W'],
        },
        {
          title: 'Split Editor',
          keys: ['Ctrl', '\\'],
        },
        {
          title: 'Focus into First Editor Group',
          keys: ['Ctrl', '1'],
        },
        {
          title: 'Focus into Second Editor Group',
          keys: ['Ctrl', '2'],
        },
        {
          title: 'Focus into Third Editor Group',
          keys: ['Ctrl', '3'],
        },
        {
          title: 'Move Editor into Next Group',
          keys: ['Ctrl', 'Ctrl', 'right'],
        },
        {
          title: 'Move Editor into Previous Group',
          keys: ['Ctrl', 'Ctrl', 'left'],
        },
      ],
    },
    {
      title: 'File Management',
      id: 'files',
      version: 1,
      shortcuts: [
        {
          title: 'New File',
          keys: ['Ctrl', 'N'],
        },
        {
          title: 'Save',
          keys: ['Ctrl', 'S'],
        },
        {
          title: 'Save All',
          keys: ['Alt', 'Ctrl', 'S'],
        },
        {
          title: 'Save As…',
          keys: ['Shift', 'Ctrl', 'S'],
        },
        {
          title: 'Close',
          keys: ['Ctrl', 'W'],
        },
        {
          title: 'Close Others',
          keys: ['Alt', 'Ctrl', 'T'],
        },
        {
          title: 'Reopen Closed Editor',
          keys: ['Shift', 'Ctrl', 'T'],
        },
        {
          title: 'Open Next',
          keys: ['Ctrl', 'Tab'],
        },
        {
          title: 'Open Previous',
          keys: ['Ctrl', 'Shift', 'Tab'],
        },
      ],
    },
    {
      title: 'Display',
      id: 'display',
      version: 1,
      shortcuts: [
        {
          title: 'Toggle Full Screen',
          keys: ['Ctrl', 'Ctrl', 'F'],
        },
        {
          title: 'Zoom in',
          keys: [
            ['Ctrl', '='],
            ['Ctrl', '+'],
          ],
        },
        {
          title: 'Zoom out',
          keys: ['Ctrl', '-'],
        },
        {
          title: 'Toggle Sidebar Visibility',
          keys: ['Ctrl', 'B'],
        },
        {
          title: 'Show Explorer / Toggle Focus',
          keys: ['Shift', 'Ctrl', 'E'],
        },
        {
          title: 'Show Search',
          keys: ['Shift', 'Ctrl', 'F'],
        },
        {
          title: 'Show Source Ctrl',
          keys: ['Ctrl', 'Shift', 'G'],
        },
        {
          title: 'Show Debug',
          keys: ['Shift', 'Ctrl', 'D'],
        },
        {
          title: 'Show Extensions',
          keys: ['Shift', 'Ctrl', 'X'],
        },
        {
          title: 'Show Output',
          keys: ['Shift', 'Ctrl', 'U'],
        },
        {
          title: 'Quick Open View',
          keys: ['Ctrl', 'Q'],
        },
        {
          title: 'Open New Command Prompt',
          keys: ['Shift', 'Ctrl', 'C'],
        },
        {
          title: 'Toggle Markdown Preview',
          keys: ['Shift', 'Ctrl', 'V'],
        },
        {
          title: 'Toggle Integrated Terminal',
          keys: ['Ctrl', '`'],
        },
      ],
    },
    {
      title: 'Search',
      id: 'search',
      version: 1,
      shortcuts: [
        {
          title: 'Show Search',
          keys: ['Shift', 'Ctrl', 'F'],
        },
        {
          title: 'Replace in Files',
          keys: ['Shift', 'Ctrl', 'H'],
        },
        {
          title: 'Toggle Match Case',
          keys: ['Alt', 'Ctrl', 'C'],
        },
        {
          title: 'Toggle Match Whole Word',
          keys: ['Alt', 'Ctrl', 'W'],
        },
        {
          title: 'Toggle Use Regular Expression',
          keys: ['Alt', 'Ctrl', 'R'],
        },
        {
          title: 'Toggle Search Details',
          keys: ['Shift', 'Ctrl', 'J'],
        },
        {
          title: 'Focus Next Search Result',
          keys: ['F4'],
        },
        {
          title: 'Focus Previous Search Result',
          keys: ['Shift', 'F4'],
        },
        {
          title: 'Show Next Search Term',
          keys: ['down'],
        },
        {
          title: 'Show Previous Search Term',
          keys: ['up'],
        },
      ],
    },
    {
      title: 'Debug',
      id: 'debug',
      version: 1,
      shortcuts: [
        {
          title: 'Toggle Breakpoint',
          keys: ['F9'],
        },
        {
          title: 'Start',
          keys: ['F5'],
        },
        {
          title: 'Start (without debugging)',
          keys: ['Ctrl', 'F5'],
        },
        {
          title: 'Pause',
          keys: ['F6'],
        },
        {
          title: 'Step Into',
          keys: ['F11'],
        },
        {
          title: 'Step Out',
          keys: ['Shift', 'F11'],
        },
        {
          title: 'Step Over',
          keys: ['F10'],
        },
        {
          title: 'Stop',
          keys: ['Shift', 'F5'],
        },
      ],
    },
    {
      title: 'Miscellaneous',
      id: 'miscellaneous',
      version: 1,
      shortcuts: [
        {
          title: 'Jump to matching bracket',
          keys: ['Shift', 'Ctrl', '\\'],
        },
        {
          title: 'Fold (collapse) region',
          keys: ['Alt', 'Ctrl', '['],
        },
        {
          title: 'Unfold (uncollapse) region',
          keys: ['Alt', 'Ctrl', ']'],
        },
        {
          title: 'Toggle Find Case Sensitive',
          keys: ['Alt', 'Ctrl', 'C'],
        },
        {
          title: 'Toggle Find Regex',
          keys: ['Alt', 'Ctrl', 'R'],
        },
        {
          title: 'Toggle Find Whole Word',
          keys: ['Alt', 'Ctrl', 'W'],
        },
        {
          title: 'Toggle Use of Tab Key for Setting Focus',
          keys: ['Ctrl', 'Shift', 'M'],
        },
        {
          title: 'Toggle Word Wrap',
          keys: ['Alt', 'Z'],
        },
      ],
    },
  ],
  test:[
        {
          title: 'Find',
          keys: ['Ctrl', 'F'],
        },
        {
          title: 'Replace',
          keys: ['Alt', 'Ctrl', 'F'],
        },
        {
          title: 'Find Next',
          keys: ['Enter'],
        },
        {
          title: 'Find Previous',
          keys: ['Shift', 'Ctrl', 'G'],
        },
        {
          title: 'Toggle Line Comment',
          keys: ['Ctrl', '/'],
        },
        {
          title: 'Toggle Block Comment',
          keys: ['Shift', 'Alt', 'A'],
        },
        {
          title: 'Scroll Line Down',
          keys: ['Ctrl', 'PageDown'],
        },
        {
          title: 'Scroll Line Up',
          keys: ['Ctrl', 'PageUp'],
        },
        {
          title: 'Scroll Page Down',
          keys: ['Ctrl', 'PageDown'],
        },
        {
          title: 'Scroll Page Up',
          keys: ['Ctrl', 'PageUp'],
        },
        {
          title: 'Select current line',
          keys: ['Ctrl', 'L'],
        },
        {
          title: 'Add Selection To Next Find Match',
          keys: ['Ctrl', 'D'],
        },
        {
          title: 'Select all occurrences of current word',
          keys: ['Ctrl', 'F2'],
        },
        {
          title: 'Select all occurrences of find match',
          keys: ['Alt', 'Enter'],
        },
        {
          title: 'Select all occurrences of current selection',
          keys: ['Shift', 'Ctrl', 'L'],
        },
        {
          title: 'Expand AST Selection',
          keys: ['Ctrl', 'Shift', 'Ctrl', 'right'],
        },
        {
          title: 'Shrink AST Selection',
          keys: ['Ctrl', 'Shift', 'Ctrl', 'left'],
        },
        {
          title: 'Cut line (empty selection)',
          keys: ['Ctrl', 'X'],
        },
        {
          title: 'Copy line (empty selection)',
          keys: ['Ctrl', 'C'],
        },
        {
          title: 'Delete Line',
          keys: ['Shift', 'Ctrl', 'K'],
        },
        {
          title: 'Insert Line Below',
          keys: ['Ctrl', 'Enter'],
        },
        {
          title: 'Insert Line Above',
          keys: ['Shift', 'Ctrl', 'Enter'],
        },
        {
          title: 'Move Line Down',
          keys: ['Alt', 'down'],
        },
        {
          title: 'Move Line Up',
          keys: ['Alt', 'up'],
        },
        {
          title: 'Copy Line Down',
          keys: ['Shift', 'Alt', 'down'],
        },
        {
          title: 'Copy Line Up',
          keys: ['Shift', 'Alt', 'up'],
        },
        {
          title: 'Indent Line',
          keys: ['Ctrl', ']'],
        },
        {
          title: 'Outdent Line',
          keys: ['Ctrl', '['],
        },
        {
          title: 'Go to End of Line',
          keys: ['End'],
        },
        {
          title: 'Undo last cursor operation',
          keys: ['Ctrl', 'U'],
        },
        {
          title: 'Insert cursor at end of each line selected',
          keys: ['Shift', 'Alt', 'I'],
        },
        {
          title: 'Insert Cursor Below',
          keys: ['Alt', 'Ctrl', 'down'],
        },
        {
          title: 'Insert Cursor Above',
          keys: ['Alt', 'Ctrl', 'up'],
        },
        {
          title: 'Trigger Suggest',
          keys: ['Ctrl', 'Space'],
        },
        {
          title: 'Trigger Parameter Hints',
          keys: ['Shift', 'Ctrl', 'Space'],
        },
        {
          title: 'Format Document',
          keys: ['Shift', 'Alt', 'F'],
        },
        {
          title: 'Go to Definition',
          keys: ['F12'],
        },
        {
          title: 'Peek Definition',
          keys: ['Alt', 'F12'],
        },
        {
          title: 'Quick Fix',
          keys: ['Ctrl', '.'],
        },
        {
          title: 'Peek References',
          keys: ['Shift', 'F12'],
        },
        {
          title: 'Rename Symbol',
          keys: ['F2'],
        },
        {
          title: 'Replace with Next Value',
          keys: ['Shift', 'Ctrl', '.'],
        },
        {
          title: 'Replace with Previous Value',
          keys: ['Shift', 'Ctrl', ','],
        },
        {
          title: 'Show All Symbols',
          keys: ['Ctrl', 'T'],
        },
        {
          title: 'Go to Line…',
          keys: ['Ctrl', 'G'],
        },
        {
          title: 'Go to File…, Quick Open',
          keys: ['Ctrl', 'P'],
        },
        {
          title: 'Go to Symbol…',
          keys: ['Shift', 'Ctrl', 'O'],
        },
        {
          title: 'Show Problems',
          keys: ['Shift', 'Ctrl', 'M'],
        },
        {
          title: 'Go to Next Error or Warning',
          keys: ['F8'],
        },
        {
          title: 'Go to Previous Error or Warning',
          keys: ['Shift', 'F8'],
        },
        {
          title: 'Show All Commands',
          keys: ['Shift', 'Ctrl', 'P'],
        },
        {
          title: 'Navigate Editor Group History',
          keys: ['Ctrl', 'Shift', 'Tab'],
        },
        {
          title: 'Go Back',
          keys: ['Ctrl', '-'],
        },
        {
          title: 'Go Forward',
          keys: ['Ctrl', 'Shift', '-'],
        },
        {
          title: 'Go to End of File',
          keys: ['Ctrl', 'down'],
        },
        {
          title: 'Go to Beginning of File',
          keys: ['Ctrl', 'up'],
        },
        {
          title: 'New Window',
          keys: ['Shift', 'Ctrl', 'N'],
        },
        {
          title: 'Close Window',
          keys: ['Shift', 'Ctrl', 'W'],
        },
        {
          title: 'Close Editor',
          keys: ['Ctrl', 'W'],
        },
        {
          title: 'Split Editor',
          keys: ['Ctrl', '\\'],
        },
        {
          title: 'Focus into First Editor Group',
          keys: ['Ctrl', '1'],
        },
        {
          title: 'Focus into Second Editor Group',
          keys: ['Ctrl', '2'],
        },
        {
          title: 'Focus into Third Editor Group',
          keys: ['Ctrl', '3'],
        },
        {
          title: 'Move Editor into Next Group',
          keys: ['Ctrl', 'Ctrl', 'right'],
        },
        {
          title: 'Move Editor into Previous Group',
          keys: ['Ctrl', 'Ctrl', 'left'],
        },
        {
          title: 'New File',
          keys: ['Ctrl', 'N'],
        },
        {
          title: 'Save',
          keys: ['Ctrl', 'S'],
        },
        {
          title: 'Save All',
          keys: ['Alt', 'Ctrl', 'S'],
        },
        {
          title: 'Save As…',
          keys: ['Shift', 'Ctrl', 'S'],
        },
        {
          title: 'Close',
          keys: ['Ctrl', 'W'],
        },
        {
          title: 'Close Others',
          keys: ['Alt', 'Ctrl', 'T'],
        },
        {
          title: 'Reopen Closed Editor',
          keys: ['Shift', 'Ctrl', 'T'],
        },
        {
          title: 'Open Next',
          keys: ['Ctrl', 'Tab'],
        },
        {
          title: 'Open Previous',
          keys: ['Ctrl', 'Shift', 'Tab'],
        },
        {
          title: 'Toggle Full Screen',
          keys: ['Ctrl', 'Ctrl', 'F'],
        },
        {
          title: 'Zoom in',
          keys: ['Ctrl', '='],
        },
        {
          title: 'Zoom out',
          keys: ['Ctrl', '-'],
        },
        {
          title: 'Toggle Sidebar Visibility',
          keys: ['Ctrl', 'B'],
        },
        {
          title: 'Show Explorer / Toggle Focus',
          keys: ['Shift', 'Ctrl', 'E'],
        },
        {
          title: 'Show Search',
          keys: ['Shift', 'Ctrl', 'F'],
        },
        {
          title: 'Show Source Ctrl',
          keys: ['Ctrl', 'Shift', 'G'],
        },
        {
          title: 'Show Debug',
          keys: ['Shift', 'Ctrl', 'D'],
        },
        {
          title: 'Show Extensions',
          keys: ['Shift', 'Ctrl', 'X'],
        },
        {
          title: 'Show Output',
          keys: ['Shift', 'Ctrl', 'U'],
        },
        {
          title: 'Quick Open View',
          keys: ['Ctrl', 'Q'],
        },
        {
          title: 'Open New Command Prompt',
          keys: ['Shift', 'Ctrl', 'C'],
        },
        {
          title: 'Toggle Markdown Preview',
          keys: ['Shift', 'Ctrl', 'V'],
        },
        {
          title: 'Toggle Integrated Terminal',
          keys: ['Ctrl', '`'],
        },
        {
          title: 'Show Search',
          keys: ['Shift', 'Ctrl', 'F'],
        },
        {
          title: 'Replace in Files',
          keys: ['Shift', 'Ctrl', 'H'],
        },
        {
          title: 'Toggle Match Case',
          keys: ['Alt', 'Ctrl', 'C'],
        },
        {
          title: 'Toggle Match Whole Word',
          keys: ['Alt', 'Ctrl', 'W'],
        },
        {
          title: 'Toggle Use Regular Expression',
          keys: ['Alt', 'Ctrl', 'R'],
        },
        {
          title: 'Toggle Search Details',
          keys: ['Shift', 'Ctrl', 'J'],
        },
        {
          title: 'Focus Next Search Result',
          keys: ['F4'],
        },
        {
          title: 'Focus Previous Search Result',
          keys: ['Shift', 'F4'],
        },
        {
          title: 'Show Next Search Term',
          keys: ['down'],
        },
        {
          title: 'Show Previous Search Term',
          keys: ['up'],
        },
        {
          title: 'Toggle Breakpoint',
          keys: ['F9'],
        },
        {
          title: 'Start',
          keys: ['F5'],
        },
        {
          title: 'Start (without debugging)',
          keys: ['Ctrl', 'F5'],
        },
        {
          title: 'Pause',
          keys: ['F6'],
        },
        {
          title: 'Step Into',
          keys: ['F11'],
        },
        {
          title: 'Step Out',
          keys: ['Shift', 'F11'],
        },
        {
          title: 'Step Over',
          keys: ['F10'],
        },
        {
          title: 'Stop',
          keys: ['Shift', 'F5'],
        },
        {
          title: 'Jump to matching bracket',
          keys: ['Shift', 'Ctrl', '\\'],
        },
        {
          title: 'Fold (collapse) region',
          keys: ['Alt', 'Ctrl', '['],
        },
        {
          title: 'Unfold (uncollapse) region',
          keys: ['Alt', 'Ctrl', ']'],
        },
        {
          title: 'Toggle Find Case Sensitive',
          keys: ['Alt', 'Ctrl', 'C'],
        },
        {
          title: 'Toggle Find Regex',
          keys: ['Alt', 'Ctrl', 'R'],
        },
        {
          title: 'Toggle Find Whole Word',
          keys: ['Alt', 'Ctrl', 'W'],
        },
        {
          title: 'Toggle Use of Tab Key for Setting Focus',
          keys: ['Ctrl', 'Shift', 'M'],
        },
        {
          title: 'Toggle Word Wrap',
          keys: ['Alt', 'Z'],
        },
  ],
},

{
  id: 'webflow',
  appicon:"qrc:/Images/webflow.png",
  title: 'Webflow',
  category: 'Productivity',
  sets: [
              {
                title: 'Essentials',
                id: 'essentials',
                version: 1,
                shortcuts: [
                  {
                    title: 'Show shortcut cheatsheet',
                    keys: ['Shift', '/'],
                  },
                  {
                    title: 'Save as Snapshot',
                    keys: ['Shift', 'Ctrl', 'S'],
                  },
                  {
                    title: 'Deselect/Abort',
                    keys: ['Escape'],
                  },
                  {
                    title: 'Delete Element',
                    keys: ['Backspace'],
                  },
                  {
                    title: 'Show Publish Dialog',
                    keys: ['Shift', 'P'],
                  },
                  {
                    title: 'Show Export Code Dialog',
                    keys: ['Shift', 'E'],
                  },
                  {
                    title: 'Edit element',
                    keys: ['Enter'],
                  },
                  {
                    title: '‍Copy',
                    keys: ['Ctrl', 'C'],
                  },
                  {
                    title: 'Cut',
                    keys: ['Ctrl', 'X'],
                  },
                  {
                    title: 'Paste',
                    keys: ['Ctrl', 'V'],
                  },
                  {
                    title: 'Undo',
                    keys: ['Ctrl', 'Z'],
                  },
                  {
                    title: 'Redo',
                    keys: ['Shift', 'Ctrl', 'Z'],
                  },
                ],
              },
              {
                title: 'View',
                id: 'view',
                version: 1,
                shortcuts: [
                  {
                    title: 'Preview mode',
                    keys: ['Shift', 'Ctrl', 'P'],
                  },
                  {
                    title: 'Guide overlay',
                    keys: ['Shift', 'Ctrl', 'G'],
                  },
                  {
                    title: 'Show element edges',
                    keys: ['Shift', 'Ctrl', 'E'],
                  },
                  {
                    title: 'X-ray mode',
                    keys: ['Shift', 'Ctrl', 'X'],
                  },
                  {
                    title: 'Desktop view',
                    keys: ['1'],
                  },
                  {
                    title: 'Tablet view',
                    keys: ['2'],
                  },
                  {
                    title: 'Phone (landscape) view',
                    keys: ['3'],
                  },
                  {
                    title: 'Phone (portrait) view',
                    keys: ['4'],
                  },
                ],
              },
              {
                title: 'Left-hand Toolbar',
                id: 'toolbar',
                version: 1,
                shortcuts: [
                  {
                    title: 'Show Add panel',
                    keys: ['A'],
                  },
                  {
                    title: 'Show Navigator tab',
                    keys: ['Z'],
                  },
                  {
                    title: 'Show Pages panel',
                    keys: ['P'],
                  },
                  {
                    title: 'Show Symbols panel',
                    keys: ['Shift', 'A'],
                  },
                  {
                    title: 'Make selected element a Symbol',
                    keys: ['Ctrl', 'Shift', 'A'],
                  },
                  {
                    title: 'Show Asset Manager',
                    keys: ['J'],
                  },
                ],
              },
              {
                title: 'Right-hand Tabs',
                id: 'tabs',
                version: 1,
                shortcuts: [
                  {
                    title: '‍Show Style tab',
                    keys: ['S'],
                  },
                  {
                    title: 'Show Settings tab',
                    keys: ['D'],
                  },
                  {
                    title: 'Show Style Manager tab',
                    keys: ['G'],
                  },
                  {
                    title: 'Show Interactions tab',
                    keys: ['H'],
                  },
                ],
              },
              {
                title: 'Style Panel',
                id: 'style',
                version: 1,
                shortcuts: [
                  {
                    title: 'Add class to selected element',
                    keys: ['Ctrl', 'Enter'],
                  },
                  {
                    title: 'Rename Last Class on Selected Element',
                    keys: ['Ctrl', 'Shift', 'Enter'],
                  },
                ],
              },
              {
                title: 'Miscellaneous',
                id: 'miscellaneous',
                version: 1,
                shortcuts: [
                  {
                    title: 'Select parent element',
                    keys: ['up'],
                  },
                  {
                    title: 'Select child element',
                    keys: ['down'],
                  },
                  {
                    title: 'Select next element',
                    keys: ['Alt', 'right'],
                  },
                  {
                    title: 'Select previous element',
                    keys: ['Alt', 'left'],
                  },
                  {
                    title: 'Toggle Collaborators on selected element',
                    keys: ['Ctrl', 'Shift', 'L'],
                  },
                  {
                    title: 'Quick Find',
                    keys: ['Ctrl', 'E'],
                  },
                ],
              },
  ],
  test:[
              {
                title: 'Show shortcut cheatsheet',
                keys: ['Shift', '/'],
              },
              {
                title: 'Save as Snapshot',
                keys: ['Shift', 'Ctrl', 'S'],
              },
              {
                title: 'Deselect/Abort',
                keys: ['Escape'],
              },
              {
                title: 'Delete Element',
                keys: ['Backspace'],
              },
              {
                title: 'Show Publish Dialog',
                keys: ['Shift', 'P'],
              },
              {
                title: 'Show Export Code Dialog',
                keys: ['Shift', 'E'],
              },
              {
                title: 'Edit element',
                keys: ['Enter'],
              },
              {
                title: '‍Copy',
                keys: ['Ctrl', 'C'],
              },
              {
                title: 'Cut',
                keys: ['Ctrl', 'X'],
              },
              {
                title: 'Paste',
                keys: ['Ctrl', 'V'],
              },
              {
                title: 'Undo',
                keys: ['Ctrl', 'Z'],
              },
              {
                title: 'Redo',
                keys: ['Shift', 'Ctrl', 'Z'],
              },
              {
                title: 'Preview mode',
                keys: ['Shift', 'Ctrl', 'P'],
              },
              {
                title: 'Guide overlay',
                keys: ['Shift', 'Ctrl', 'G'],
              },
              {
                title: 'Show element edges',
                keys: ['Shift', 'Ctrl', 'E'],
              },
              {
                title: 'X-ray mode',
                keys: ['Shift', 'Ctrl', 'X'],
              },
              {
                title: 'Desktop view',
                keys: ['1'],
              },
              {
                title: 'Tablet view',
                keys: ['2'],
              },
              {
                title: 'Phone (landscape) view',
                keys: ['3'],
              },
              {
                title: 'Phone (portrait) view',
                keys: ['4'],
              },
              {
                title: 'Show Add panel',
                keys: ['A'],
              },
              {
                title: 'Show Navigator tab',
                keys: ['Z'],
              },
              {
                title: 'Show Pages panel',
                keys: ['P'],
              },
              {
                title: 'Show Symbols panel',
                keys: ['Shift', 'A'],
              },
              {
                title: 'Make selected element a Symbol',
                keys: ['Ctrl', 'Shift', 'A'],
              },
              {
                title: 'Show Asset Manager',
                keys: ['J'],
              },
              {
                title: '‍Show Style tab',
                keys: ['S'],
              },
              {
                title: 'Show Settings tab',
                keys: ['D'],
              },
              {
                title: 'Show Style Manager tab',
                keys: ['G'],
              },
              {
                title: 'Show Interactions tab',
                keys: ['H'],
              },
              {
                title: 'Add class to selected element',
                keys: ['Ctrl', 'Enter'],
              },
              {
                title: 'Rename Last Class on Selected Element',
                keys: ['Ctrl', 'Shift', 'Enter'],
              },
              {
                title: 'Select parent element',
                keys: ['up'],
              },
              {
                title: 'Select child element',
                keys: ['down'],
              },
              {
                title: 'Select next element',
                keys: ['Alt', 'right'],
              },
              {
                title: 'Select previous element',
                keys: ['Alt', 'left'],
              },
              {
                title: 'Toggle Collaborators on selected element',
                keys: ['Ctrl', 'Shift', 'L'],
              },
              {
                title: 'Quick Find',
                keys: ['Ctrl', 'E'],
              },
  ],
},

{
  id: 'firefox',
  appicon:"qrc:/Images/figma.png",
  title: 'Firefox',
  category: 'Utility',
  description: null,
  sets: [
              {
                title: 'Navigation',
                id: 'navigation',
                version: 1,
                shortcuts: [
                  {
                    title: 'Back',
                    keys: ['Ctrl', 'left'],
                  },
                  {
                    title: 'Forward',
                    keys: ['Ctrl', 'right'],
                  },
                  {
                    title: 'Open File',
                    keys: ['Ctrl', 'O'],
                  },
                  {
                    title: 'Reload',
                    keys: ['Ctrl', 'R'],
                  },
                  {
                    title: 'Reload (override cache)',
                    keys: ['Ctrl', 'Shift', 'R'],
                  },
                  {
                    title: 'Stop',
                    keys: ['Escape'],
                  },
                ],
              },
              {
                title: 'Current Page',
                id: 'current',
                version: 1,
                shortcuts: [
                  {
                    title: 'Focus Next Link or Input Field',
                    keys: ['Tab'],
                  },
                  {
                    title: 'Focus Previous Link or Input Field',
                    keys: ['Shift', 'Tab'],
                  },
                  {
                    title: 'Go Down a Screen',
                    keys: ['Space'],
                  },
                  {
                    title: 'Go Up a Screen',
                    keys: ['Shift', 'Space'],
                  },
                  {
                    title: 'Go to Bottom of Page',
                    keys: ['Ctrl', 'down'],
                  },
                  {
                    title: 'Go to Top of Page',
                    keys: ['Ctrl', 'up'],
                  },
                  {
                    title: 'Move to Next Frame',
                    keys: ['F6'],
                  },
                  {
                    title: 'Move to Previous Frame',
                    keys: ['Shift', 'F6'],
                  },
                  {
                    title: 'Print',
                    keys: ['Ctrl', 'P'],
                  },
                  {
                    title: 'Save Page As',
                    keys: ['Ctrl', 'S'],
                  },
                ],
              },
              {
                title: 'Editing',
                id: 'editing',
                version: 1,
                shortcuts: [
                  {
                    title: 'Copy',
                    keys: ['Ctrl', 'C'],
                  },
                  {
                    title: 'Cut',
                    keys: ['Ctrl', 'X'],
                  },
                  {
                    title: 'Delete',
                    keys: ['Backspace'],
                  },
                  {
                    title: 'Go to End of Line',
                    keys: ['End'],
                  },
                  {
                    title: 'Paste',
                    keys: ['Ctrl', 'V'],
                  },
                  {
                    title: 'Paste as plain text',
                    keys: ['Ctrl', 'Shift', 'V'],
                  },
                  {
                    title: 'Redo',
                    keys: ['Ctrl', 'Shift', 'Z'],
                  },
                  {
                    title: 'Select All',
                    keys: ['Ctrl', 'A'],
                  },
                  {
                    title: 'Undo',
                    keys: ['Ctrl', 'Z'],
                  },
                ],
              },
              {
                title: 'Search',
                id: 'search',
                version: 1,
                shortcuts: [
                  {
                    title: 'Find',
                    keys: ['Ctrl', 'F'],
                  },
                  {
                    title: 'Find Again',
                    keys: ['Ctrl', 'G'],
                  },
                  {
                    title: 'Find Previous',
                    keys: ['Ctrl', 'Shift', 'G'],
                  },
                  {
                    title: 'Quick Find within link-text only',
                    keys: ['\''],
                  },
                  {
                    title: 'Quick Find',
                    keys: ['/'],
                  },
                  {
                    title: 'Close the Find or Quick Find bar',
                    keys: ['Escape'],
                  },
                  {
                    title: 'Focus Search bar',
                    keys: ['Ctrl', 'K'],
                  },
                ],
              },
              {
                title: 'Tabs',
                id: 'tabs',
                version: 1,
                shortcuts: [
                  {
                    title: 'Close Tab',
                    keys: ['Ctrl', 'W'],
                  },
                  {
                    title: 'Cycle through Tabs in Recently Used Order',
                    keys: ['Ctrl', 'Tab'],
                  },
                  {
                    title: 'Go one Tab to the Left',
                    keys: ['Ctrl', 'Alt', 'left'],
                  },
                  {
                    title: 'Go one Tab to the Right',
                    keys: ['Ctrl', 'Alt', 'right'],
                  },
                  {
                    title: 'Move Tab Left',
                    keys: ['Ctrl', 'Shift', 'PageUp'],
                  },
                  {
                    title: 'Move Tab Right',
                    keys: ['Ctrl', 'Shift', 'PageDown'],
                  },
                  {
                    title: 'Move Tab in focus to end',
                    keys: ['Ctrl', 'Shift', 'End'],
                  },
                  {
                    title: 'Mute/Unmute Audio',
                    keys: ['Ctrl', 'M'],
                  },
                  {
                    title: 'New Tab',
                    keys: ['Ctrl', 'T'],
                  },
                  {
                    title: 'Open Address or Search in New Foreground Tab',
                    keys: ['Alt', 'Enter'],
                  },
                  {
                    title: 'Select Tab 1',
                    keys: ['Ctrl', '1'],
                  },
                  {
                    title: 'Select Tab 8',
                    keys: ['Ctrl', '8'],
                  },
                  {
                    title: 'Select Last Tab',
                    keys: ['Ctrl', '9'],
                  },
                  {
                    title: 'Undo Close Tab',
                    keys: ['Ctrl', 'Shift', 'T'],
                  },
                ],
              },
              {
                title: 'Windows',
                id: 'windows',
                version: 1,
                shortcuts: [
                  {
                    title: 'Close Window',
                    keys: ['Ctrl', 'Shift', 'W'],
                  },
                  {
                    title: 'New Window',
                    keys: ['Ctrl', 'N'],
                  },
                  {
                    title: 'New Private Window',
                    keys: ['Ctrl', 'Shift', 'P'],
                  },
                  {
                    title: 'Open Address or Search in New Window',
                    keys: ['Shift', 'Enter'],
                  },
                  {
                    title: 'Undo Close Window',
                    keys: ['Ctrl', 'Shift', 'N'],
                  },
                  {
                    title: 'Moves the URL left or right',
                    keys: ['Ctrl', 'Shift', 'X'],
                  },
                ],
              },
              {
                title: 'Layout',
                id: 'layout',
                version: 1,
                shortcuts: [
                  {
                    title: 'Zoom In',
                    keys: [
                      ['Ctrl', '='],
                      ['Ctrl', '+'],
                    ],
                  },
                  {
                    title: 'Zoom Out',
                    keys: ['Ctrl', '-'],
                  },
                  {
                    title: 'Zoom Reset',
                    keys: ['Ctrl', '0'],
                  },
                ],
              },
              {
                title: 'History',
                id: 'history',
                version: 1,
                shortcuts: [
                  {
                    title: 'History sidebar',
                    keys: ['Ctrl', 'Shift', 'H'],
                  },
                  {
                    title: 'Clear Recent History',
                    keys: ['Ctrl', 'Shift', 'Backspace'],
                  },
                ],
              },
              {
                title: 'Bookmarks',
                id: 'bookmarks',
                version: 1,
                shortcuts: [
                  {
                    title: 'Bookmark All Tabs',
                    keys: ['Ctrl', 'Shift', 'D'],
                  },
                  {
                    title: 'Bookmark This Page',
                    keys: ['Ctrl', 'D'],
                  },
                  {
                    title: 'Bookmarks sidebar',
                    keys: ['Ctrl', 'B'],
                  },
                  {
                    title: 'Bookmarks',
                    keys: ['Ctrl', 'Shift', 'B'],
                  },
                  {
                    title: 'Show List of All Bookmarks',
                    keys: ['Space'],
                  },
                ],
              },
              {
                title: 'Tools',
                id: 'tools',
                version: 1,
                shortcuts: [
                  {
                    title: 'Downloads',
                    keys: ['Ctrl', 'J'],
                  },
                  {
                    title: 'Add-ons',
                    keys: ['Ctrl', 'Shift', 'A'],
                  },
                  {
                    title: 'PageSource',
                    keys: ['Ctrl', 'U'],
                  },
                  {
                    title: 'PageInfo',
                    keys: ['Ctrl', 'I'],
                  },
                ],
              },
              {
                title: 'PDF viewer',
                id: 'pdf',
                version: 1,
                shortcuts: [
                  {
                    title: 'Next page',
                    keys: ['right'],
                  },
                  {
                    title: 'Previous page',
                    keys: ['left'],
                  },
                  {
                    title: 'Zoom in',
                    keys: ['Ctrl', '+'],
                  },
                  {
                    title: 'Zoom out',
                    keys: ['Ctrl', '-'],
                  },
                  {
                    title: 'Automatic Zoom',
                    keys: ['Ctrl', '0'],
                  },
                  {
                    title: 'Rotate the document clockwise',
                    keys: ['R'],
                  },
                  {
                    title: 'Rotate counterclockwise',
                    keys: ['Shift', 'R'],
                  },
                  {
                    title: 'Switch to Presentation Mode',
                    keys: ['Ctrl', 'Alt', 'P'],
                  },
                  {
                    title: 'Choose Text Selection Tool',
                    keys: ['S'],
                  },
                  {
                    title: 'Choose Hand Tool',
                    keys: ['H'],
                  },
                  {
                    title: 'Focus the Page Number input box',
                    keys: ['Ctrl', 'Alt', 'G'],
                  },
                ],
              },
              {
                title: 'Miscellaneous',
                id: 'misc',
                version: 1,
                shortcuts: [
                  {
                    title: 'Complete .com Address',
                    keys: ['Ctrl', 'Enter'],
                  },
                  {
                    title: 'Delete Selected Autocomplete Entry',
                    keys: ['Shift', 'Backspace'],
                  },
                  {
                    title: 'Toggle Full Screen',
                    keys: ['Ctrl', 'Shift', 'F'],
                  },
                  {
                    title: 'Toggle Reader Mode',
                    keys: ['Ctrl', 'Alt', 'R'],
                  },
                  {
                    title: 'Caret Browsing',
                    keys: ['F7'],
                  },
                  {
                    title: 'Select Location Bar',
                    keys: ['Ctrl', 'L'],
                  },
                  {
                    title: 'Go to Search Field in Library',
                    keys: ['Ctrl', 'F'],
                  },
                ],
              },
              {
                title: 'Media shortcuts',
                id: 'media',
                version: 1,
                shortcuts: [
                  {
                    title: 'Toggle Play / Pause',
                    keys: ['Space'],
                  },
                  {
                    title: 'Decrease volume',
                    keys: ['down'],
                  },
                  {
                    title: 'Increase volume',
                    keys: ['up'],
                  },
                  {
                    title: 'Mute audio',
                    keys: ['Ctrl', 'down'],
                  },
                  {
                    title: 'Unmute audio',
                    keys: ['Ctrl', 'up'],
                  },
                  {
                    title: 'Seek back 15 seconds',
                    keys: ['left'],
                  },
                  {
                    title: 'Seek back 10 %',
                    keys: ['Ctrl', 'left'],
                  },
                  {
                    title: 'Seek forward 15 seconds',
                    keys: ['right'],
                  },
                  {
                    title: 'Seek forward 10 %',
                    keys: ['Ctrl', 'right'],
                  },
                  {
                    title: 'Seek to the end',
                    keys: ['End'],
                  },
                ],
              },
              {
                title: 'Developer shortcuts',
                id: 'developer',
                version: 1,
                shortcuts: [
                  {
                    title: 'Toggle Developer Tools',
                    keys: ['Ctrl', 'Alt', 'I'],
                  },
                  {
                    title: 'Open Web Console 1',
                    keys: ['Ctrl', 'Alt', 'K'],
                  },
                  {
                    title: 'Toggle “Pick an element from the page”',
                    keys: ['Ctrl', 'Alt', 'C'],
                  },
                  {
                    title: 'Open Style Editor',
                    keys: ['Shift', 'F7'],
                  },
                  {
                    title: 'Open Profiler',
                    keys: ['Shift', 'F5'],
                  },
                  {
                    title: 'Open Network Monitor',
                    keys: ['Ctrl', 'Alt', 'E'],
                  },
                  {
                    title: 'Toggle Responsive Design Mode',
                    keys: ['Ctrl', 'Alt', 'M'],
                  },
                  {
                    title: 'Open Browser Console',
                    keys: ['Ctrl', 'Shift', 'J'],
                  },
                  {
                    title: 'Open Browser Toolbox',
                    keys: ['Ctrl', 'Alt', 'Shift', 'I'],
                  },
                  {
                    title: 'Open WebIDE',
                    keys: ['Shift', 'F8'],
                  },
                  {
                    title: 'Storage Inspector',
                    keys: ['Shift', 'F9'],
                  },
                  {
                    title: 'Open Debugger 3',
                    keys: ['Ctrl', 'Alt', 'Z'],
                  },
                ],
              },
  ],
  test:[
              {
                title: 'Back',
                keys: ['Ctrl', 'left'],
              },
              {
                title: 'Forward',
                keys: ['Ctrl', 'right'],
              },
              {
                title: 'Open File',
                keys: ['Ctrl', 'O'],
              },
              {
                title: 'Reload',
                keys: ['Ctrl', 'R'],
              },
              {
                title: 'Reload (override cache)',
                keys: ['Ctrl', 'Shift', 'R'],
              },
              {
                title: 'Stop',
                keys: ['Escape'],
              },
              {
                title: 'Focus Next Link or Input Field',
                keys: ['Tab'],
              },
              {
                title: 'Focus Previous Link or Input Field',
                keys: ['Shift', 'Tab'],
              },
              {
                title: 'Go Down a Screen',
                keys: ['Space'],
              },
              {
                title: 'Go Up a Screen',
                keys: ['Shift', 'Space'],
              },
              {
                title: 'Go to Bottom of Page',
                keys: ['Ctrl', 'down'],
              },
              {
                title: 'Go to Top of Page',
                keys: ['Ctrl', 'up'],
              },
              {
                title: 'Move to Next Frame',
                keys: ['F6'],
              },
              {
                title: 'Move to Previous Frame',
                keys: ['Shift', 'F6'],
              },
              {
                title: 'Print',
                keys: ['Ctrl', 'P'],
              },
              {
                title: 'Save Page As',
                keys: ['Ctrl', 'S'],
              },
              {
                title: 'Copy',
                keys: ['Ctrl', 'C'],
              },
              {
                title: 'Cut',
                keys: ['Ctrl', 'X'],
              },
              {
                title: 'Delete',
                keys: ['Backspace'],
              },
              {
                title: 'Go to End of Line',
                keys: ['End'],
              },
              {
                title: 'Paste',
                keys: ['Ctrl', 'V'],
              },
              {
                title: 'Paste as plain text',
                keys: ['Ctrl', 'Shift', 'V'],
              },
              {
                title: 'Redo',
                keys: ['Ctrl', 'Shift', 'Z'],
              },
              {
                title: 'Select All',
                keys: ['Ctrl', 'A'],
              },
              {
                title: 'Undo',
                keys: ['Ctrl', 'Z'],
              },
              {
                title: 'Find',
                keys: ['Ctrl', 'F'],
              },
              {
                title: 'Find Again',
                keys: ['Ctrl', 'G'],
              },
              {
                title: 'Find Previous',
                keys: ['Ctrl', 'Shift', 'G'],
              },
              {
                title: 'Quick Find within link-text only',
                keys: ['\''],
              },
              {
                title: 'Quick Find',
                keys: ['/'],
              },
              {
                title: 'Close the Find or Quick Find bar',
                keys: ['Escape'],
              },
              {
                title: 'Focus Search bar',
                keys: ['Ctrl', 'K'],
              },
              {
                title: 'Close Tab',
                keys: ['Ctrl', 'W'],
              },
              {
                title: 'Cycle through Tabs in Recently Used Order',
                keys: ['Ctrl', 'Tab'],
              },
              {
                title: 'Go one Tab to the Left',
                keys: ['Ctrl', 'Alt', 'left'],
              },
              {
                title: 'Go one Tab to the Right',
                keys: ['Ctrl', 'Alt', 'right'],
              },
              {
                title: 'Move Tab Left',
                keys: ['Ctrl', 'Shift', 'PageUp'],
              },
              {
                title: 'Move Tab Right',
                keys: ['Ctrl', 'Shift', 'PageDown'],
              },
              {
                title: 'Move Tab in focus to end',
                keys: ['Ctrl', 'Shift', 'End'],
              },
              {
                title: 'Mute/Unmute Audio',
                keys: ['Ctrl', 'M'],
              },
              {
                title: 'New Tab',
                keys: ['Ctrl', 'T'],
              },
              {
                title: 'Open Address or Search in New Foreground Tab',
                keys: ['Alt', 'Enter'],
              },
              {
                title: 'Select Tab 1',
                keys: ['Ctrl', '1'],
              },
              {
                title: 'Select Tab 8',
                keys: ['Ctrl', '8'],
              },
              {
                title: 'Select Last Tab',
                keys: ['Ctrl', '9'],
              },
              {
                title: 'Undo Close Tab',
                keys: ['Ctrl', 'Shift', 'T'],
              },
              {
                title: 'Close Window',
                keys: ['Ctrl', 'Shift', 'W'],
              },
              {
                title: 'New Window',
                keys: ['Ctrl', 'N'],
              },
              {
                title: 'New Private Window',
                keys: ['Ctrl', 'Shift', 'P'],
              },
              {
                title: 'Open Address or Search in New Window',
                keys: ['Shift', 'Enter'],
              },
              {
                title: 'Undo Close Window',
                keys: ['Ctrl', 'Shift', 'N'],
              },
              {
                title: 'Moves the URL left or right',
                keys: ['Ctrl', 'Shift', 'X'],
              },
              {
                title: 'Zoom In',
                keys: ['Ctrl', '+'],
              },
              {
                title: 'Zoom Out',
                keys: ['Ctrl', '-'],
              },
              {
                title: 'Zoom Reset',
                keys: ['Ctrl', '0'],
              },
              {
                title: 'History sidebar',
                keys: ['Ctrl', 'Shift', 'H'],
              },
              {
                title: 'Clear Recent History',
                keys: ['Ctrl', 'Shift', 'Backspace'],
              },
              {
                title: 'Bookmark All Tabs',
                keys: ['Ctrl', 'Shift', 'D'],
              },
              {
                title: 'Bookmark This Page',
                keys: ['Ctrl', 'D'],
              },
              {
                title: 'Bookmarks sidebar',
                keys: ['Ctrl', 'B'],
              },
              {
                title: 'Bookmarks',
                keys: ['Ctrl', 'Shift', 'B'],
              },
              {
                title: 'Show List of All Bookmarks',
                keys: ['Space'],
              },
              {
                title: 'Downloads',
                keys: ['Ctrl', 'J'],
              },
              {
                title: 'Add-ons',
                keys: ['Ctrl', 'Shift', 'A'],
              },
              {
                title: 'PageSource',
                keys: ['Ctrl', 'U'],
              },
              {
                title: 'PageInfo',
                keys: ['Ctrl', 'I'],
              },
              {
                title: 'Next page',
                keys: ['right'],
              },
              {
                title: 'Previous page',
                keys: ['left'],
              },
              {
                title: 'Zoom in',
                keys: ['Ctrl', '+'],
              },
              {
                title: 'Zoom out',
                keys: ['Ctrl', '-'],
              },
              {
                title: 'Automatic Zoom',
                keys: ['Ctrl', '0'],
              },
              {
                title: 'Rotate the document clockwise',
                keys: ['R'],
              },
              {
                title: 'Rotate counterclockwise',
                keys: ['Shift', 'R'],
              },
              {
                title: 'Switch to Presentation Mode',
                keys: ['Ctrl', 'Alt', 'P'],
              },
              {
                title: 'Choose Text Selection Tool',
                keys: ['S'],
              },
              {
                title: 'Choose Hand Tool',
                keys: ['H'],
              },
              {
                title: 'Focus the Page Number input box',
                keys: ['Ctrl', 'Alt', 'G'],
              },
              {
                title: 'Complete .com Address',
                keys: ['Ctrl', 'Enter'],
              },
              {
                title: 'Delete Selected Autocomplete Entry',
                keys: ['Shift', 'Backspace'],
              },
              {
                title: 'Toggle Full Screen',
                keys: ['Ctrl', 'Shift', 'F'],
              },
              {
                title: 'Toggle Reader Mode',
                keys: ['Ctrl', 'Alt', 'R'],
              },
              {
                title: 'Caret Browsing',
                keys: ['F7'],
              },
              {
                title: 'Select Location Bar',
                keys: ['Ctrl', 'L'],
              },
              {
                title: 'Go to Search Field in Library',
                keys: ['Ctrl', 'F'],
              },
              {
                title: 'Toggle Play / Pause',
                keys: ['Space'],
              },
              {
                title: 'Decrease volume',
                keys: ['down'],
              },
              {
                title: 'Increase volume',
                keys: ['up'],
              },
              {
                title: 'Mute audio',
                keys: ['Ctrl', 'down'],
              },
              {
                title: 'Unmute audio',
                keys: ['Ctrl', 'up'],
              },
              {
                title: 'Seek back 15 seconds',
                keys: ['left'],
              },
              {
                title: 'Seek back 10 %',
                keys: ['Ctrl', 'left'],
              },
              {
                title: 'Seek forward 15 seconds',
                keys: ['right'],
              },
              {
                title: 'Seek forward 10 %',
                keys: ['Ctrl', 'right'],
              },
              {
                title: 'Seek to the end',
                keys: ['End'],
              },
              {
                title: 'Toggle Developer Tools',
                keys: ['Ctrl', 'Alt', 'I'],
              },
              {
                title: 'Open Web Console 1',
                keys: ['Ctrl', 'Alt', 'K'],
              },
              {
                title: 'Toggle “Pick an element from the page”',
                keys: ['Ctrl', 'Alt', 'C'],
              },
              {
                title: 'Open Style Editor',
                keys: ['Shift', 'F7'],
              },
              {
                title: 'Open Profiler',
                keys: ['Shift', 'F5'],
              },
              {
                title: 'Open Network Monitor',
                keys: ['Ctrl', 'Alt', 'E'],
              },
              {
                title: 'Toggle Responsive Design Mode',
                keys: ['Ctrl', 'Alt', 'M'],
              },
              {
                title: 'Open Browser Console',
                keys: ['Ctrl', 'Shift', 'J'],
              },
              {
                title: 'Open Browser Toolbox',
                keys: ['Ctrl', 'Alt', 'Shift', 'I'],
              },
              {
                title: 'Open WebIDE',
                keys: ['Shift', 'F8'],
              },
              {
                title: 'Storage Inspector',
                keys: ['Shift', 'F9'],
              },
              {
                title: 'Open Debugger 3',
                keys: ['Ctrl', 'Alt', 'Z'],
              },
  ],
},
  {
    id: 'chrome',
    appicon: 'qrc:/Images/chrome.png',
    title: 'Chrome',
    category: 'Browser',
    description: 'Google Chrome is a fast, secure web browser. Master these shortcuts to browse faster and become a power user.',
    sets: [
      {
        title: 'Tabs & Windows',
        id: 'tabs',
        version: 1,
        shortcuts: [
          {
            title: 'New Tab',
            keys: ['Ctrl', 'T'],
          },
          {
            title: 'New Window',
            keys: ['Ctrl', 'N'],
          },
          {
            title: 'New Incognito Window',
            keys: ['Ctrl', 'Shift', 'N'],
          },
          {
            title: 'Close Tab',
            keys: ['Ctrl', 'W'],
          },
          {
            title: 'Close Window',
            keys: ['Ctrl', 'Shift', 'W'],
          },
          {
            title: 'Reopen Closed Tab',
            keys: ['Ctrl', 'Shift', 'T'],
          },
          {
            title: 'Next Tab',
            keys: ['Ctrl', 'Tab'],
          },
          {
            title: 'Previous Tab',
            keys: ['Ctrl', 'Shift', 'Tab'],
          },
          {
            title: 'Jump to Tab 1-8',
            keys: ['Ctrl', '1'],
          },
          {
            title: 'Jump to Last Tab',
            keys: ['Ctrl', '9'],
          },
        ],
      },
      {
        title: 'Navigation',
        id: 'navigation',
        version: 1,
        shortcuts: [
          {
            title: 'Back',
            keys: ['Alt', 'left'],
          },
          {
            title: 'Forward',
            keys: ['Alt', 'right'],
          },
          {
            title: 'Reload',
            keys: ['Ctrl', 'R'],
          },
          {
            title: 'Hard Reload',
            keys: ['Ctrl', 'Shift', 'R'],
          },
          {
            title: 'Home',
            keys: ['Alt', 'Home'],
          },
          {
            title: 'Focus Address Bar',
            keys: ['Ctrl', 'L'],
          },
          {
            title: 'Search Tabs',
            keys: ['Ctrl', 'Shift', 'A'],
          },
        ],
      },
      {
        title: 'Page Actions',
        id: 'page',
        version: 1,
        shortcuts: [
          {
            title: 'Find in Page',
            keys: ['Ctrl', 'F'],
          },
          {
            title: 'Find Next',
            keys: ['Ctrl', 'G'],
          },
          {
            title: 'Find Previous',
            keys: ['Ctrl', 'Shift', 'G'],
          },
          {
            title: 'Save Page',
            keys: ['Ctrl', 'S'],
          },
          {
            title: 'Print',
            keys: ['Ctrl', 'P'],
          },
          {
            title: 'Zoom In',
            keys: ['Ctrl', '+'],
          },
          {
            title: 'Zoom Out',
            keys: ['Ctrl', '-'],
          },
          {
            title: 'Reset Zoom',
            keys: ['Ctrl', '0'],
          },
          {
            title: 'Scroll Down',
            keys: ['Space'],
          },
          {
            title: 'Scroll Up',
            keys: ['Shift', 'Space'],
          },
        ],
      },
      {
        title: 'Developer Tools',
        id: 'devtools',
        version: 1,
        shortcuts: [
          {
            title: 'Open DevTools',
            keys: ['F12'],
          },
          {
            title: 'Inspect Element',
            keys: ['Ctrl', 'Shift', 'C'],
          },
          {
            title: 'Console',
            keys: ['Ctrl', 'Shift', 'J'],
          },
          {
            title: 'Sources',
            keys: ['Ctrl', 'Shift', 'O'],
          },
          {
            title: 'View Source',
            keys: ['Ctrl', 'U'],
          },
        ],
      },
    ],
  },
  {
    id: 'gimp',
    appicon: 'qrc:/Images/gimp.png',
    title: 'GIMP',
    category: 'Graphics',
    description: 'GIMP is a free and open-source image editor. These shortcuts will speed up your photo editing and design workflow.',
    sets: [
      {
        title: 'File Operations',
        id: 'file',
        version: 1,
        shortcuts: [
          {
            title: 'New Image',
            keys: ['Ctrl', 'N'],
          },
          {
            title: 'Open Image',
            keys: ['Ctrl', 'O'],
          },
          {
            title: 'Save',
            keys: ['Ctrl', 'S'],
          },
          {
            title: 'Save As',
            keys: ['Ctrl', 'Shift', 'S'],
          },
          {
            title: 'Export',
            keys: ['Ctrl', 'Shift', 'E'],
          },
          {
            title: 'Close',
            keys: ['Ctrl', 'W'],
          },
          {
            title: 'Quit',
            keys: ['Ctrl', 'Q'],
          },
        ],
      },
      {
        title: 'Tools',
        id: 'tools',
        version: 1,
        shortcuts: [
          {
            title: 'Selection Tool',
            keys: ['R'],
          },
          {
            title: 'Free Select',
            keys: ['F'],
          },
          {
            title: 'Fuzzy Select',
            keys: ['U'],
          },
          {
            title: 'Select by Color',
            keys: ['Shift', 'O'],
          },
          {
            title: 'Scissors Select',
            keys: ['I'],
          },
          {
            title: 'Move Tool',
            keys: ['M'],
          },
          {
            title: 'Crop Tool',
            keys: ['Shift', 'C'],
          },
          {
            title: 'Rotate Tool',
            keys: ['Shift', 'R'],
          },
          {
            title: 'Scale Tool',
            keys: ['Shift', 'T'],
          },
          {
            title: 'Text Tool',
            keys: ['T'],
          },
          {
            title: 'Fill Tool',
            keys: ['Shift', 'B'],
          },
          {
            title: 'Gradient Tool',
            keys: ['G'],
          },
          {
            title: 'Paintbrush',
            keys: ['P'],
          },
          {
            title: 'Eraser',
            keys: ['Shift', 'E'],
          },
          {
            title: 'Clone Tool',
            keys: ['C'],
          },
        ],
      },
      {
        title: 'View',
        id: 'view',
        version: 1,
        shortcuts: [
          {
            title: 'Zoom In',
            keys: ['+'],
          },
          {
            title: 'Zoom Out',
            keys: ['-'],
          },
          {
            title: 'Fit in Window',
            keys: ['Shift', 'Ctrl', 'E'],
          },
          {
            title: 'Zoom 100%',
            keys: ['1'],
          },
          {
            title: 'Toggle Selection',
            keys: ['Ctrl', 'T'],
          },
          {
            title: 'Toggle Guides',
            keys: ['Shift', 'Ctrl', 'T'],
          },
          {
            title: 'Fullscreen',
            keys: ['F11'],
          },
        ],
      },
      {
        title: 'Layers',
        id: 'layers',
        version: 1,
        shortcuts: [
          {
            title: 'New Layer',
            keys: ['Shift', 'Ctrl', 'N'],
          },
          {
            title: 'Duplicate Layer',
            keys: ['Shift', 'Ctrl', 'D'],
          },
          {
            title: 'Merge Down',
            keys: ['Ctrl', 'M'],
          },
          {
            title: 'Flatten Image',
            keys: ['Ctrl', 'Shift', 'M'],
          },
          {
            title: 'Anchor Layer',
            keys: ['Ctrl', 'H'],
          },
        ],
      },
      {
        title: 'Edit',
        id: 'edit',
        version: 1,
        shortcuts: [
          {
            title: 'Undo',
            keys: ['Ctrl', 'Z'],
          },
          {
            title: 'Redo',
            keys: ['Ctrl', 'Y'],
          },
          {
            title: 'Cut',
            keys: ['Ctrl', 'X'],
          },
          {
            title: 'Copy',
            keys: ['Ctrl', 'C'],
          },
          {
            title: 'Paste',
            keys: ['Ctrl', 'V'],
          },
          {
            title: 'Fill with FG Color',
            keys: ['Ctrl', ';'],
          },
          {
            title: 'Fill with BG Color',
            keys: ['Ctrl', ':'],
          },
        ],
      },
    ],
  },
  {
    id: 'slack',
    appicon: 'qrc:/Images/slack.png',
    title: 'Slack',
    category: 'Communication',
    description: 'Slack is a messaging app for teams. Navigate conversations and channels faster with these keyboard shortcuts.',
    sets: [
      {
        title: 'Navigation',
        id: 'navigation',
        version: 1,
        shortcuts: [
          {
            title: 'Quick Switcher',
            keys: ['Ctrl', 'K'],
          },
          {
            title: 'Direct Messages',
            keys: ['Ctrl', 'Shift', 'K'],
          },
          {
            title: 'All Unreads',
            keys: ['Ctrl', 'Shift', 'A'],
          },
          {
            title: 'All Threads',
            keys: ['Ctrl', 'Shift', 'T'],
          },
          {
            title: 'Browse Channels',
            keys: ['Ctrl', 'Shift', 'L'],
          },
          {
            title: 'Previous Channel',
            keys: ['Alt', 'up'],
          },
          {
            title: 'Next Channel',
            keys: ['Alt', 'down'],
          },
          {
            title: 'Previous Unread',
            keys: ['Alt', 'Shift', 'up'],
          },
          {
            title: 'Next Unread',
            keys: ['Alt', 'Shift', 'down'],
          },
        ],
      },
      {
        title: 'Messaging',
        id: 'messaging',
        version: 1,
        shortcuts: [
          {
            title: 'Mark as Read',
            keys: ['Esc'],
          },
          {
            title: 'Mark Channel as Read',
            keys: ['Esc', 'Esc'],
          },
          {
            title: 'New Message',
            keys: ['Ctrl', 'N'],
          },
          {
            title: 'Edit Last Message',
            keys: ['Ctrl', 'up'],
          },
          {
            title: 'Emoji Reactions',
            keys: ['Ctrl', 'Shift', '\\'],
          },
          {
            title: 'Thread Reply',
            keys: ['Ctrl', 'Shift', 'T'],
          },
          {
            title: 'Add Formatting',
            keys: ['Ctrl', 'Shift', 'F'],
          },
        ],
      },
      {
        title: 'Search & Files',
        id: 'search',
        version: 1,
        shortcuts: [
          {
            title: 'Search',
            keys: ['Ctrl', 'F'],
          },
          {
            title: 'Search Current Channel',
            keys: ['Ctrl', 'G'],
          },
          {
            title: 'Upload File',
            keys: ['Ctrl', 'U'],
          },
          {
            title: 'Snippets',
            keys: ['Ctrl', 'Shift', 'Enter'],
          },
        ],
      },
      {
        title: 'Calls & Preferences',
        id: 'calls',
        version: 1,
        shortcuts: [
          {
            title: 'Toggle Mute',
            keys: ['M'],
          },
          {
            title: 'Toggle Video',
            keys: ['V'],
          },
          {
            title: 'Preferences',
            keys: ['Ctrl', ','],
          },
          {
            title: 'Help',
            keys: ['Ctrl', '/'],
          },
        ],
      },
    ],
  },
  {
    id: 'libreoffice',
    appicon: 'qrc:/Images/libreoffice.png',
    title: 'LibreOffice Writer',
    category: 'Productivity',
    description: 'LibreOffice Writer is a powerful word processor. These shortcuts will help you format documents and write faster.',
    sets: [
      {
        title: 'Document',
        id: 'document',
        version: 1,
        shortcuts: [
          {
            title: 'New Document',
            keys: ['Ctrl', 'N'],
          },
          {
            title: 'Open',
            keys: ['Ctrl', 'O'],
          },
          {
            title: 'Save',
            keys: ['Ctrl', 'S'],
          },
          {
            title: 'Save As',
            keys: ['Ctrl', 'Shift', 'S'],
          },
          {
            title: 'Print',
            keys: ['Ctrl', 'P'],
          },
          {
            title: 'Close',
            keys: ['Ctrl', 'W'],
          },
          {
            title: 'Quit',
            keys: ['Ctrl', 'Q'],
          },
        ],
      },
      {
        title: 'Editing',
        id: 'editing',
        version: 1,
        shortcuts: [
          {
            title: 'Undo',
            keys: ['Ctrl', 'Z'],
          },
          {
            title: 'Redo',
            keys: ['Ctrl', 'Y'],
          },
          {
            title: 'Cut',
            keys: ['Ctrl', 'X'],
          },
          {
            title: 'Copy',
            keys: ['Ctrl', 'C'],
          },
          {
            title: 'Paste',
            keys: ['Ctrl', 'V'],
          },
          {
            title: 'Paste Special',
            keys: ['Ctrl', 'Shift', 'V'],
          },
          {
            title: 'Select All',
            keys: ['Ctrl', 'A'],
          },
          {
            title: 'Find',
            keys: ['Ctrl', 'F'],
          },
          {
            title: 'Find & Replace',
            keys: ['Ctrl', 'H'],
          },
        ],
      },
      {
        title: 'Formatting',
        id: 'formatting',
        version: 1,
        shortcuts: [
          {
            title: 'Bold',
            keys: ['Ctrl', 'B'],
          },
          {
            title: 'Italic',
            keys: ['Ctrl', 'I'],
          },
          {
            title: 'Underline',
            keys: ['Ctrl', 'U'],
          },
          {
            title: 'Strikethrough',
            keys: ['Alt', 'Shift', '5'],
          },
          {
            title: 'Superscript',
            keys: ['Ctrl', 'Shift', 'P'],
          },
          {
            title: 'Subscript',
            keys: ['Ctrl', 'Shift', 'B'],
          },
          {
            title: 'Align Left',
            keys: ['Ctrl', 'L'],
          },
          {
            title: 'Align Center',
            keys: ['Ctrl', 'E'],
          },
          {
            title: 'Align Right',
            keys: ['Ctrl', 'R'],
          },
          {
            title: 'Justify',
            keys: ['Ctrl', 'J'],
          },
        ],
      },
      {
        title: 'Styles & Heading',
        id: 'styles',
        version: 1,
        shortcuts: [
          {
            title: 'Heading 1',
            keys: ['Ctrl', '1'],
          },
          {
            title: 'Heading 2',
            keys: ['Ctrl', '2'],
          },
          {
            title: 'Heading 3',
            keys: ['Ctrl', '3'],
          },
          {
            title: 'Default Style',
            keys: ['Ctrl', '0'],
          },
          {
            title: 'Apply Style',
            keys: ['Ctrl', 'Shift', 'S'],
          },
        ],
      },
      {
        title: 'Tables & Objects',
        id: 'tables',
        version: 1,
        shortcuts: [
          {
            title: 'Insert Table',
            keys: ['Ctrl', 'F12'],
          },
          {
            title: 'Insert Row Above',
            keys: ['Alt', 'Insert'],
          },
          {
            title: 'Insert Column Before',
            keys: ['Ctrl', 'Alt', 'Insert'],
          },
          {
            title: 'Delete Row',
            keys: ['Ctrl', 'Delete'],
          },
          {
            title: 'Hyperlink',
            keys: ['Ctrl', 'K'],
          },
        ],
      },
    ],
  },
  {
    id: 'terminal',
    appicon: 'qrc:/Images/terminal.png',
    title: 'Terminal',
    category: 'Development',
    description: 'Master the Linux terminal with these essential shortcuts for faster command-line navigation and editing.',
    sets: [
      {
        title: 'Navigation',
        id: 'navigation',
        version: 1,
        shortcuts: [
          {
            title: 'Beginning of Line',
            keys: ['Ctrl', 'A'],
          },
          {
            title: 'End of Line',
            keys: ['Ctrl', 'E'],
          },
          {
            title: 'Forward One Word',
            keys: ['Alt', 'F'],
          },
          {
            title: 'Backward One Word',
            keys: ['Alt', 'B'],
          },
          {
            title: 'Clear Screen',
            keys: ['Ctrl', 'L'],
          },
        ],
      },
      {
        title: 'Editing',
        id: 'editing',
        version: 1,
        shortcuts: [
          {
            title: 'Delete Word Before Cursor',
            keys: ['Ctrl', 'W'],
          },
          {
            title: 'Delete to End of Line',
            keys: ['Ctrl', 'K'],
          },
          {
            title: 'Delete to Beginning',
            keys: ['Ctrl', 'U'],
          },
          {
            title: 'Paste Last Cut',
            keys: ['Ctrl', 'Y'],
          },
          {
            title: 'Transpose Characters',
            keys: ['Ctrl', 'T'],
          },
          {
            title: 'Transpose Words',
            keys: ['Alt', 'T'],
          },
        ],
      },
      {
        title: 'History',
        id: 'history',
        version: 1,
        shortcuts: [
          {
            title: 'Previous Command',
            keys: ['Ctrl', 'P'],
          },
          {
            title: 'Next Command',
            keys: ['Ctrl', 'N'],
          },
          {
            title: 'Search History',
            keys: ['Ctrl', 'R'],
          },
          {
            title: 'Reverse Search',
            keys: ['Ctrl', 'S'],
          },
          {
            title: 'End History Search',
            keys: ['Ctrl', 'G'],
          },
        ],
      },
      {
        title: 'Control',
        id: 'control',
        version: 1,
        shortcuts: [
          {
            title: 'Interrupt Process',
            keys: ['Ctrl', 'C'],
          },
          {
            title: 'End of File',
            keys: ['Ctrl', 'D'],
          },
          {
            title: 'Suspend Process',
            keys: ['Ctrl', 'Z'],
          },
          {
            title: 'Exit Terminal',
            keys: ['Ctrl', 'D'],
          },
        ],
      },
      {
        title: 'Terminal Window',
        id: 'window',
        version: 1,
        shortcuts: [
          {
            title: 'New Tab',
            keys: ['Ctrl', 'Shift', 'T'],
          },
          {
            title: 'Close Tab',
            keys: ['Ctrl', 'Shift', 'W'],
          },
          {
            title: 'Next Tab',
            keys: ['Ctrl', 'PageDown'],
          },
          {
            title: 'Previous Tab',
            keys: ['Ctrl', 'PageUp'],
          },
          {
            title: 'Copy',
            keys: ['Ctrl', 'Shift', 'C'],
          },
          {
            title: 'Paste',
            keys: ['Ctrl', 'Shift', 'V'],
          },
          {
            title: 'Zoom In',
            keys: ['Ctrl', '+'],
          },
          {
            title: 'Zoom Out',
            keys: ['Ctrl', '-'],
          },
        ],
      },
    ],
  },
  {
    id: 'figma',
    appicon: 'qrc:/Images/figma.png',
    title: 'Figma',
    category: 'Design',
    description: 'Figma is a collaborative design tool. Master these shortcuts to design faster and work more efficiently.',
    sets: [
      {
        title: 'Tools',
        id: 'tools',
        version: 1,
        shortcuts: [
          {
            title: 'Move Tool',
            keys: ['V'],
          },
          {
            title: 'Frame Tool',
            keys: ['F'],
          },
          {
            title: 'Rectangle',
            keys: ['R'],
          },
          {
            title: 'Ellipse',
            keys: ['O'],
          },
          {
            title: 'Line',
            keys: ['L'],
          },
          {
            title: 'Pen Tool',
            keys: ['P'],
          },
          {
            title: 'Text Tool',
            keys: ['T'],
          },
          {
            title: 'Hand Tool',
            keys: ['H'],
          },
          {
            title: 'Comment',
            keys: ['C'],
          },
          {
            title: 'Eyedropper',
            keys: ['I'],
          },
        ],
      },
      {
        title: 'View',
        id: 'view',
        version: 1,
        shortcuts: [
          {
            title: 'Zoom In',
            keys: ['Ctrl', '+'],
          },
          {
            title: 'Zoom Out',
            keys: ['Ctrl', '-'],
          },
          {
            title: 'Zoom to 100%',
            keys: ['Ctrl', '0'],
          },
          {
            title: 'Zoom to Fit',
            keys: ['Ctrl', '1'],
          },
          {
            title: 'Zoom to Selection',
            keys: ['Ctrl', '2'],
          },
          {
            title: 'Toggle UI',
            keys: ['Ctrl', '\\'],
          },
          {
            title: 'Toggle Rulers',
            keys: ['Shift', 'R'],
          },
          {
            title: 'Toggle Grid',
            keys: ['Ctrl', "'"],
          },
          {
            title: 'Toggle Layout Grids',
            keys: ['Ctrl', 'G'],
          },
        ],
      },
      {
        title: 'Objects',
        id: 'objects',
        version: 1,
        shortcuts: [
          {
            title: 'Group Selection',
            keys: ['Ctrl', 'G'],
          },
          {
            title: 'Ungroup',
            keys: ['Ctrl', 'Shift', 'G'],
          },
          {
            title: 'Frame Selection',
            keys: ['Ctrl', 'Alt', 'G'],
          },
          {
            title: 'Duplicate',
            keys: ['Ctrl', 'D'],
          },
          {
            title: 'Bring Forward',
            keys: ['Ctrl', ']'],
          },
          {
            title: 'Bring to Front',
            keys: ['Ctrl', 'Shift', ']'],
          },
          {
            title: 'Send Backward',
            keys: ['Ctrl', '['],
          },
          {
            title: 'Send to Back',
            keys: ['Ctrl', 'Shift', '['],
          },
          {
            title: 'Lock/Unlock',
            keys: ['Ctrl', 'Shift', 'L'],
          },
          {
            title: 'Hide/Show',
            keys: ['Ctrl', 'Shift', 'H'],
          },
        ],
      },
      {
        title: 'Edit',
        id: 'edit',
        version: 1,
        shortcuts: [
          {
            title: 'Undo',
            keys: ['Ctrl', 'Z'],
          },
          {
            title: 'Redo',
            keys: ['Ctrl', 'Shift', 'Z'],
          },
          {
            title: 'Copy',
            keys: ['Ctrl', 'C'],
          },
          {
            title: 'Paste',
            keys: ['Ctrl', 'V'],
          },
          {
            title: 'Copy as PNG',
            keys: ['Ctrl', 'Shift', 'C'],
          },
          {
            title: 'Paste over Selection',
            keys: ['Ctrl', 'Shift', 'V'],
          },
          {
            title: 'Delete',
            keys: ['Delete'],
          },
          {
            title: 'Select All',
            keys: ['Ctrl', 'A'],
          },
        ],
      },
      {
        title: 'Components',
        id: 'components',
        version: 1,
        shortcuts: [
          {
            title: 'Create Component',
            keys: ['Ctrl', 'Alt', 'K'],
          },
          {
            title: 'Detach Instance',
            keys: ['Ctrl', 'Alt', 'B'],
          },
          {
            title: 'Go to Main Component',
            keys: ['Ctrl', 'Alt', 'E'],
          },
          {
            title: 'Create Component Set',
            keys: ['Ctrl', 'Alt', 'Shift', 'K'],
          },
        ],
      },
    ],
  },
  {
    id: 'discord',
    appicon: 'qrc:/Images/discord.png',
    title: 'Discord',
    category: 'Communication',
    description: 'Discord is a voice, video and text communication platform. Navigate servers and channels efficiently with these shortcuts.',
    sets: [
      {
        title: 'Navigation',
        id: 'navigation',
        version: 1,
        shortcuts: [
          {
            title: 'Quick Switcher',
            keys: ['Ctrl', 'K'],
          },
          {
            title: 'Previous Server',
            keys: ['Ctrl', 'Alt', 'up'],
          },
          {
            title: 'Next Server',
            keys: ['Ctrl', 'Alt', 'down'],
          },
          {
            title: 'Previous Channel',
            keys: ['Alt', 'up'],
          },
          {
            title: 'Next Channel',
            keys: ['Alt', 'down'],
          },
          {
            title: 'Previous Unread Channel',
            keys: ['Alt', 'Shift', 'up'],
          },
          {
            title: 'Next Unread Channel',
            keys: ['Alt', 'Shift', 'down'],
          },
          {
            title: 'Mark Server as Read',
            keys: ['Shift', 'Esc'],
          },
          {
            title: 'Mark Channel as Read',
            keys: ['Esc'],
          },
        ],
      },
      {
        title: 'Messaging',
        id: 'messaging',
        version: 1,
        shortcuts: [
          {
            title: 'Focus Text Area',
            keys: ['Tab'],
          },
          {
            title: 'Upload File',
            keys: ['Ctrl', 'Shift', 'U'],
          },
          {
            title: 'Edit Last Message',
            keys: ['up'],
          },
          {
            title: 'Mark as Unread',
            keys: ['Alt', 'Enter'],
          },
          {
            title: 'Pin Message',
            keys: ['Ctrl', 'Shift', 'P'],
          },
          {
            title: 'Add Reaction',
            keys: ['Ctrl', 'Shift', '+'],
          },
        ],
      },
      {
        title: 'Voice & Video',
        id: 'voice',
        version: 1,
        shortcuts: [
          {
            title: 'Toggle Mute',
            keys: ['Ctrl', 'Shift', 'M'],
          },
          {
            title: 'Toggle Deafen',
            keys: ['Ctrl', 'Shift', 'D'],
          },
          {
            title: 'Answer Incoming Call',
            keys: ['Ctrl', 'Enter'],
          },
          {
            title: 'Decline Incoming Call',
            keys: ['Esc'],
          },
          {
            title: 'Start Voice Call',
            keys: ['Ctrl', "'"],
          },
          {
            title: 'Start Video Call',
            keys: ['Ctrl', 'Shift', "'"],
          },
        ],
      },
      {
        title: 'Search & Settings',
        id: 'search',
        version: 1,
        shortcuts: [
          {
            title: 'Search',
            keys: ['Ctrl', 'F'],
          },
          {
            title: 'User Settings',
            keys: ['Ctrl', ','],
          },
          {
            title: 'Create/Join Server',
            keys: ['Ctrl', 'Shift', 'N'],
          },
          {
            title: 'Toggle Emoji Picker',
            keys: ['Ctrl', 'E'],
          },
          {
            title: 'Toggle GIF Picker',
            keys: ['Ctrl', 'G'],
          },
        ],
      },
    ],
  },
  {
    id: 'thunderbird',
    appicon: 'qrc:/Images/thunderbird.png',
    title: 'Thunderbird',
    category: 'Productivity',
    description: 'Thunderbird is a free email client. Manage your emails faster with these essential keyboard shortcuts.',
    sets: [
      {
        title: 'Navigation',
        id: 'navigation',
        version: 1,
        shortcuts: [
          {
            title: 'Next Message',
            keys: ['F'],
          },
          {
            title: 'Previous Message',
            keys: ['B'],
          },
          {
            title: 'Next Unread',
            keys: ['N'],
          },
          {
            title: 'Go to Inbox',
            keys: ['Ctrl', '1'],
          },
          {
            title: 'Quick Filter Bar',
            keys: ['Ctrl', 'Shift', 'K'],
          },
          {
            title: 'Search Messages',
            keys: ['Ctrl', 'K'],
          },
        ],
      },
      {
        title: 'Message Actions',
        id: 'actions',
        version: 1,
        shortcuts: [
          {
            title: 'New Message',
            keys: ['Ctrl', 'N'],
          },
          {
            title: 'Reply',
            keys: ['Ctrl', 'R'],
          },
          {
            title: 'Reply All',
            keys: ['Ctrl', 'Shift', 'R'],
          },
          {
            title: 'Forward',
            keys: ['Ctrl', 'L'],
          },
          {
            title: 'Archive',
            keys: ['A'],
          },
          {
            title: 'Delete',
            keys: ['Delete'],
          },
          {
            title: 'Mark as Junk',
            keys: ['J'],
          },
          {
            title: 'Mark as Read',
            keys: ['M'],
          },
          {
            title: 'Mark as Unread',
            keys: ['Shift', 'M'],
          },
        ],
      },
      {
        title: 'Compose',
        id: 'compose',
        version: 1,
        shortcuts: [
          {
            title: 'Send Now',
            keys: ['Ctrl', 'Enter'],
          },
          {
            title: 'Send Later',
            keys: ['Ctrl', 'Shift', 'Enter'],
          },
          {
            title: 'Save as Draft',
            keys: ['Ctrl', 'S'],
          },
          {
            title: 'Attach File',
            keys: ['Ctrl', 'Shift', 'A'],
          },
          {
            title: 'Address Book',
            keys: ['Ctrl', 'Shift', 'B'],
          },
        ],
      },
      {
        title: 'Folders',
        id: 'folders',
        version: 1,
        shortcuts: [
          {
            title: 'New Folder',
            keys: ['Ctrl', 'Shift', 'N'],
          },
          {
            title: 'Rename Folder',
            keys: ['F2'],
          },
          {
            title: 'Delete Folder',
            keys: ['Shift', 'Delete'],
          },
          {
            title: 'Get Messages',
            keys: ['Ctrl', 'T'],
          },
        ],
      },
    ],
  },
  {
    id: 'obsidian',
    appicon: 'qrc:/Images/obsidian.png',
    title: 'Obsidian',
    category: 'Productivity',
    description: 'Obsidian is a powerful knowledge base and note-taking app. Navigate your notes faster with these shortcuts.',
    sets: [
      {
        title: 'File Operations',
        id: 'file',
        version: 1,
        shortcuts: [
          {
            title: 'New Note',
            keys: ['Ctrl', 'N'],
          },
          {
            title: 'Open Quick Switcher',
            keys: ['Ctrl', 'O'],
          },
          {
            title: 'Open Command Palette',
            keys: ['Ctrl', 'P'],
          },
          {
            title: 'Search in All Files',
            keys: ['Ctrl', 'Shift', 'F'],
          },
          {
            title: 'Graph View',
            keys: ['Ctrl', 'G'],
          },
          {
            title: 'Star Current File',
            keys: ['Ctrl', 'Shift', 'S'],
          },
        ],
      },
      {
        title: 'Editing',
        id: 'editing',
        version: 1,
        shortcuts: [
          {
            title: 'Bold',
            keys: ['Ctrl', 'B'],
          },
          {
            title: 'Italic',
            keys: ['Ctrl', 'I'],
          },
          {
            title: 'Insert Link',
            keys: ['Ctrl', 'K'],
          },
          {
            title: 'Insert Internal Link',
            keys: ['Ctrl', 'Shift', 'K'],
          },
          {
            title: 'Toggle Checkbox',
            keys: ['Ctrl', 'Enter'],
          },
          {
            title: 'Delete Paragraph',
            keys: ['Ctrl', 'D'],
          },
          {
            title: 'Find in Current File',
            keys: ['Ctrl', 'F'],
          },
          {
            title: 'Replace in Current File',
            keys: ['Ctrl', 'H'],
          },
        ],
      },
      {
        title: 'Navigation',
        id: 'navigation',
        version: 1,
        shortcuts: [
          {
            title: 'Navigate Back',
            keys: ['Ctrl', 'Alt', 'left'],
          },
          {
            title: 'Navigate Forward',
            keys: ['Ctrl', 'Alt', 'right'],
          },
          {
            title: 'Follow Link',
            keys: ['Ctrl', 'Click'],
          },
          {
            title: 'Open in New Pane',
            keys: ['Ctrl', 'Shift', 'Click'],
          },
          {
            title: 'Toggle Left Sidebar',
            keys: ['Ctrl', 'Shift', 'left'],
          },
          {
            title: 'Toggle Right Sidebar',
            keys: ['Ctrl', 'Shift', 'right'],
          },
        ],
      },
      {
        title: 'View',
        id: 'view',
        version: 1,
        shortcuts: [
          {
            title: 'Toggle Edit/Preview',
            keys: ['Ctrl', 'E'],
          },
          {
            title: 'Toggle Reading View',
            keys: ['Ctrl', 'Shift', 'E'],
          },
          {
            title: 'Close Active Pane',
            keys: ['Ctrl', 'W'],
          },
          {
            title: 'Split Vertical',
            keys: ['Ctrl', '\\'],
          },
          {
            title: 'Zoom In',
            keys: ['Ctrl', '+'],
          },
          {
            title: 'Zoom Out',
            keys: ['Ctrl', '-'],
          },
        ],
      },
    ],
  },
  {
    id: 'spotify',
    appicon: 'qrc:/Images/spotify.png',
    title: 'Spotify',
    category: 'Media',
    description: 'Spotify is a music streaming service. Control your music without touching the mouse using these shortcuts.',
    sets: [
      {
        title: 'Playback',
        id: 'playback',
        version: 1,
        shortcuts: [
          {
            title: 'Play/Pause',
            keys: ['Space'],
          },
          {
            title: 'Next Track',
            keys: ['Ctrl', 'right'],
          },
          {
            title: 'Previous Track',
            keys: ['Ctrl', 'left'],
          },
          {
            title: 'Volume Up',
            keys: ['Ctrl', 'up'],
          },
          {
            title: 'Volume Down',
            keys: ['Ctrl', 'down'],
          },
          {
            title: 'Mute',
            keys: ['Ctrl', 'M'],
          },
          {
            title: 'Seek Forward',
            keys: ['Shift', 'right'],
          },
          {
            title: 'Seek Backward',
            keys: ['Shift', 'left'],
          },
          {
            title: 'Toggle Shuffle',
            keys: ['Ctrl', 'S'],
          },
          {
            title: 'Toggle Repeat',
            keys: ['Ctrl', 'R'],
          },
        ],
      },
      {
        title: 'Navigation',
        id: 'navigation',
        version: 1,
        shortcuts: [
          {
            title: 'Search',
            keys: ['Ctrl', 'L'],
          },
          {
            title: 'Home',
            keys: ['Ctrl', 'H'],
          },
          {
            title: 'Go to Artist',
            keys: ['Ctrl', 'Alt', 'A'],
          },
          {
            title: 'Go to Album',
            keys: ['Ctrl', 'Alt', 'L'],
          },
          {
            title: 'Queue',
            keys: ['Ctrl', 'G'],
          },
          {
            title: 'Browse',
            keys: ['Ctrl', 'Shift', 'B'],
          },
        ],
      },
      {
        title: 'Playlists',
        id: 'playlists',
        version: 1,
        shortcuts: [
          {
            title: 'New Playlist',
            keys: ['Ctrl', 'N'],
          },
          {
            title: 'Like Song',
            keys: ['Ctrl', 'Alt', 'L'],
          },
          {
            title: 'Add to Playlist',
            keys: ['Ctrl', 'D'],
          },
          {
            title: 'Copy Song Link',
            keys: ['Ctrl', 'Alt', 'C'],
          },
        ],
      },
      {
        title: 'View',
        id: 'view',
        version: 1,
        shortcuts: [
          {
            title: 'Zoom In',
            keys: ['Ctrl', '+'],
          },
          {
            title: 'Zoom Out',
            keys: ['Ctrl', '-'],
          },
          {
            title: 'Reset Zoom',
            keys: ['Ctrl', '0'],
          },
          {
            title: 'Toggle Fullscreen',
            keys: ['F11'],
          },
        ],
      },
    ],
  },
];


