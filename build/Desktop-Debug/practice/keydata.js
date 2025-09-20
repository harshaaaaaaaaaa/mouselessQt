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
          keys: ['Ctrl', 'Arrowdown'],
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
          keys: ['Ctrl', 'Shift', 'Ctrl', 'ArrowRight'],
        },
        {
          title: 'Shrink AST Selection',
          keys: ['Ctrl', 'Shift', 'Ctrl', 'ArrowLeft'],
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
          keys: ['Alt', 'ArrowDown'],
        },
        {
          title: 'Move Line Up',
          keys: ['Alt', 'ArrowUp'],
        },
        {
          title: 'Copy Line Down',
          keys: ['Shift', 'Alt', 'ArrowDown'],
        },
        {
          title: 'Copy Line Up',
          keys: ['Shift', 'Alt', 'ArrowUp'],
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
          keys: ['Alt', 'Ctrl', 'ArrowDown'],
        },
        {
          title: 'Insert Cursor Above',
          keys: ['Alt', 'Ctrl', 'ArrowUp'],
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
          keys: ['Ctrl', 'ArrowDown'],
        },
        {
          title: 'Go to Beginning of File',
          keys: ['Ctrl', 'ArrowUp'],
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
          keys: ['Ctrl', 'Ctrl', 'ArrowRight'],
        },
        {
          title: 'Move Editor into Previous Group',
          keys: ['Ctrl', 'Ctrl', 'ArrowLeft'],
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
          keys: ['ArrowDown'],
        },
        {
          title: 'Show Previous Search Term',
          keys: ['ArrowUp'],
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
          keys: ['Ctrl', 'Shift', 'Ctrl', 'ArrowRight'],
        },
        {
          title: 'Shrink AST Selection',
          keys: ['Ctrl', 'Shift', 'Ctrl', 'ArrowLeft'],
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
          keys: ['Alt', 'ArrowDown'],
        },
        {
          title: 'Move Line Up',
          keys: ['Alt', 'ArrowUp'],
        },
        {
          title: 'Copy Line Down',
          keys: ['Shift', 'Alt', 'ArrowDown'],
        },
        {
          title: 'Copy Line Up',
          keys: ['Shift', 'Alt', 'ArrowUp'],
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
          keys: ['Alt', 'Ctrl', 'ArrowDown'],
        },
        {
          title: 'Insert Cursor Above',
          keys: ['Alt', 'Ctrl', 'ArrowUp'],
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
          keys: ['Ctrl', 'ArrowDown'],
        },
        {
          title: 'Go to Beginning of File',
          keys: ['Ctrl', 'ArrowUp'],
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
          keys: ['Ctrl', 'Ctrl', 'ArrowRight'],
        },
        {
          title: 'Move Editor into Previous Group',
          keys: ['Ctrl', 'Ctrl', 'ArrowLeft'],
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
          keys: ['ArrowDown'],
        },
        {
          title: 'Show Previous Search Term',
          keys: ['ArrowUp'],
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
                    keys: ['ArrowUp'],
                  },
                  {
                    title: 'Select child element',
                    keys: ['ArrowDown'],
                  },
                  {
                    title: 'Select next element',
                    keys: ['Alt', 'ArrowRight'],
                  },
                  {
                    title: 'Select previous element',
                    keys: ['Alt', 'ArrowLeft'],
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
                keys: ['ArrowUp'],
              },
              {
                title: 'Select child element',
                keys: ['ArrowDown'],
              },
              {
                title: 'Select next element',
                keys: ['Alt', 'ArrowRight'],
              },
              {
                title: 'Select previous element',
                keys: ['Alt', 'ArrowLeft'],
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
                    keys: ['Ctrl', 'ArrowLeft'],
                  },
                  {
                    title: 'Forward',
                    keys: ['Ctrl', 'ArrowRight'],
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
                    keys: ['Ctrl', 'ArrowDown'],
                  },
                  {
                    title: 'Go to Top of Page',
                    keys: ['Ctrl', 'ArrowUp'],
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
                    keys: ['Ctrl', 'Alt', 'ArrowLeft'],
                  },
                  {
                    title: 'Go one Tab to the Right',
                    keys: ['Ctrl', 'Alt', 'ArrowRight'],
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
                    keys: ['ArrowRight'],
                  },
                  {
                    title: 'Previous page',
                    keys: ['ArrowLeft'],
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
                    keys: ['ArrowDown'],
                  },
                  {
                    title: 'Increase volume',
                    keys: ['ArrowUp'],
                  },
                  {
                    title: 'Mute audio',
                    keys: ['Ctrl', 'ArrowDown'],
                  },
                  {
                    title: 'Unmute audio',
                    keys: ['Ctrl', 'ArrowUp'],
                  },
                  {
                    title: 'Seek back 15 seconds',
                    keys: ['ArrowLeft'],
                  },
                  {
                    title: 'Seek back 10 %',
                    keys: ['Ctrl', 'ArrowLeft'],
                  },
                  {
                    title: 'Seek forward 15 seconds',
                    keys: ['ArrowRight'],
                  },
                  {
                    title: 'Seek forward 10 %',
                    keys: ['Ctrl', 'ArrowRight'],
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
                keys: ['Ctrl', 'ArrowLeft'],
              },
              {
                title: 'Forward',
                keys: ['Ctrl', 'ArrowRight'],
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
                keys: ['Ctrl', 'ArrowDown'],
              },
              {
                title: 'Go to Top of Page',
                keys: ['Ctrl', 'ArrowUp'],
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
                keys: ['Ctrl', 'Alt', 'ArrowLeft'],
              },
              {
                title: 'Go one Tab to the Right',
                keys: ['Ctrl', 'Alt', 'ArrowRight'],
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
                keys: ['ArrowRight'],
              },
              {
                title: 'Previous page',
                keys: ['ArrowLeft'],
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
                keys: ['ArrowDown'],
              },
              {
                title: 'Increase volume',
                keys: ['ArrowUp'],
              },
              {
                title: 'Mute audio',
                keys: ['Ctrl', 'ArrowDown'],
              },
              {
                title: 'Unmute audio',
                keys: ['Ctrl', 'ArrowUp'],
              },
              {
                title: 'Seek back 15 seconds',
                keys: ['ArrowLeft'],
              },
              {
                title: 'Seek back 10 %',
                keys: ['Ctrl', 'ArrowLeft'],
              },
              {
                title: 'Seek forward 15 seconds',
                keys: ['ArrowRight'],
              },
              {
                title: 'Seek forward 10 %',
                keys: ['Ctrl', 'ArrowRight'],
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
];


