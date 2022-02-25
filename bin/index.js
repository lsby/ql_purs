#!/usr/bin/env node

var path = require("path");
var 复制文件 = require("../lib/复制文件");
var 复制文件夹 = require("../lib/复制文件夹");

var 命令所在目录 = process.cwd();
var 模板目录 = path.join(__dirname, "../tmp");

复制文件夹(模板目录, 命令所在目录);
复制文件(path.join(__dirname, "../tmp/.npmignore"))(
  `${命令所在目录}/.gitignore`
);

console.log("安装npm依赖:", "npm i");
console.log("编译purs:", "spago build");
console.log("监视编译&运行前端:", "F1 -> 运行任务 -> watch:all");
console.log("运行app:", "npm run dev:app");
console.log("运行服务器:", "npm run dev:service");
