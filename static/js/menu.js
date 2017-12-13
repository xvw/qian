const remote = require('electron').remote;
const Menu = remote.Menu;
const MenuItem = remote.MenuItem;

const template =
  [
    {
      label: 'qian',
      submenu: [{role: 'about'}, {role: 'quit'}]
    },
    {
      label: 'tools',
      submenu: [
        {
          label: 'reload',
          accelerator: 'CmdOrCtrl+R',
          click: function(item, focusedWindow) {
            if (focusedWindow) focusedWindow.reload();
          }
        }
      ]
    }
  ];

const menu = Menu.buildFromTemplate(template)
Menu.setApplicationMenu(menu)
