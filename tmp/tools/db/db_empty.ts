import * as _knex from "knex"
import readlineSync from "readline-sync"
import { 删除所有表 } from "./lib"
import dotenv from "dotenv"
import path from "path"

async function main() {
  if (process.env["NODE_ENV"] == "development") {
    console.log("使用 dev 环境")
    dotenv.config({ path: path.resolve(__dirname, "../../.env/dev.env") })
  } else if (process.env["NODE_ENV"] == "release") {
    console.log("使用 release 环境")
    dotenv.config({ path: path.resolve(__dirname, "../../.env/release.env") })
  } else if (process.env["NODE_ENV"] == "production") {
    console.log("使用 production 环境")
    dotenv.config({ path: path.resolve(__dirname, "../../.env/prod.env") })
  } else {
    throw "没有指定运行环境"
  }

  var host = process.env["DB_HOST"]
  var port = Number(process.env["DB_PORT"])
  var user = process.env["DB_USER"]
  var password = process.env["DB_PWD"]
  var database = process.env["DB_NAME"]

  if (
    host == null ||
    port == null ||
    user == null ||
    password == null ||
    database == null
  ) {
    throw "环境变量错误"
  }
  if (isNaN(port)) {
    throw "环境变量错误"
  }

  process.stdout.write(
    `本操作将清除和清空数据库${database}, 所有表结构和数据都将丢失, 确定吗?[y/N]`
  )
  var yes = readlineSync.question()
  if (yes != "y" && yes != "Y") {
    console.log("用户取消了操作")
    return
  }

  console.log("删除所有表...")

  await 删除所有表()
}
main()
