#!/usr/bin/env node

var exec = require("@lsby/exec_cmd").default;
var path = require("path");
var download = require("download");

async function main() {
  var 命令所在目录 = process.cwd();
  var 临时目录 = path.resolve(命令所在目录, "Template_Purescript-main");

  await download(
    "https://github.com/lsby/Template_Purescript/archive/refs/heads/main.zip",
    命令所在目录,
    { extract: true }
  );
  await exec(`mv -f ${临时目录}/{.[!.],}* ${命令所在目录}/`);
  await exec(`rm -rf ${临时目录}`);

  console.log("安装npm依赖:", "npm i");
  console.log("编译purs:", "spago build");
  console.log("监视编译&运行前端:", "F1 -> 运行任务 -> watch:all");
  console.log("运行app:", "npm run dev:app");
  console.log("运行服务器:", "npm run dev:service");
  console.log("更多命令请看package.json");
}
main();
