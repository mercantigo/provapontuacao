// Mini servidor local para testar o jogo com o exercicios.json.
// Rode pelo servidor.bat (ou: node servidor.js) e abra http://localhost:8080
const http = require('http');
const fs = require('fs');
const path = require('path');

const PORTA = 8080;
const RAIZ = __dirname;
const TIPOS = {
  '.html': 'text/html; charset=utf-8',
  '.js':   'text/javascript; charset=utf-8',
  '.json': 'application/json; charset=utf-8',
  '.css':  'text/css; charset=utf-8',
  '.png':  'image/png', '.jpg': 'image/jpeg', '.svg': 'image/svg+xml',
  '.ico':  'image/x-icon'
};

http.createServer((req, res) => {
  let rel = decodeURIComponent(req.url.split('?')[0]);
  if (rel === '/' || rel === '') rel = '/index.html';
  // impede sair da pasta do jogo
  const arquivo = path.join(RAIZ, path.normalize(rel));
  if (!arquivo.startsWith(RAIZ)) { res.writeHead(403); return res.end('Proibido'); }
  fs.readFile(arquivo, (err, data) => {
    if (err) { res.writeHead(404); return res.end('Arquivo não encontrado: ' + rel); }
    const tipo = TIPOS[path.extname(arquivo).toLowerCase()] || 'application/octet-stream';
    res.writeHead(200, { 'Content-Type': tipo, 'Cache-Control': 'no-store' });
    res.end(data);
  });
}).listen(PORTA, () => {
  console.log('====================================================');
  console.log('  Jogo rodando!  Abra no navegador:');
  console.log('     http://localhost:' + PORTA);
  console.log('  (deixe esta janela aberta enquanto joga)');
  console.log('  Para parar: feche esta janela ou aperte Ctrl+C');
  console.log('====================================================');
});
