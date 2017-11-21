import electron from 'electron'
import elm from '../../src/Main.elm'


const container = document.getElementById('app');
const elmApp = elm.Main.embed(container);
