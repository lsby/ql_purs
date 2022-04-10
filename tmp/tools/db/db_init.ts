import dotenv from "dotenv"
import path from "path"
import { Kysely, MysqlDialect } from "kysely"
import DataBase from "../types/Database"

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

  var kysely = new Kysely<DataBase>({
    dialect: new MysqlDialect({ host, port, user, password, database }),
  })

  try {
    await kysely.connection().execute(async (db) => {
      await db.transaction().execute(async (trx) => {
        var _id = await trx
          .insertInto("班级表")
          .values({
            名称: "一班",
          })
          .executeTakeFirst()

        if (!_id.insertId) throw "插入失败"
        var id = Number(_id.insertId)

        await trx
          .insertInto("学生表")
          .values({
            姓名: "王二狗",
            性别: "男",
            所属班级: id,
          })
          .execute()
      })
    })
  } finally {
    kysely.destroy()
  }

  console.log("操作完成")
}

main()
