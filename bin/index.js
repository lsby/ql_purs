#!/usr/bin/env node

var exec = require("@lsby/exec_cmd").default;
var path = require("path");

async function main() {
  var 命令所在目录 = process.cwd();
  var 临时目录 = path.resolve(命令所在目录, "tmp_ql_ts");
  await exec(`mkdir ${临时目录}`);
  await exec(
    `git clone --depth 1 https://github.com/lsby/Template_Purescript.git ${临时目录}`
  );
  await exec(`rm -rf ${临时目录}/.git`);
  await exec(`mv ${临时目录}/{.[!.],}* ${命令所在目录}/`);
  await exec(`rm -rf ${临时目录}`);
  console.log("安装npm依赖:", "npm i");
  console.log("编译purs:", "spago build");
  console.log("监视编译&运行前端:", "F1 -> 运行任务 -> watch:all");
  console.log("运行app:", "npm run dev:app");
  console.log("运行服务器:", "npm run dev:service");
  console.log("更多命令请看package.json");
}
main();
