import { FileMigrationProvider, Kysely, Migrator, MysqlDialect } from "kysely"
import path from "path"
import dotenv from "dotenv"
import { 新建数据库 } from "./lib"

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

  await 新建数据库()

  var db = new Kysely<any>({
    dialect: new MysqlDialect({ host, port, user, password, database }),
  })

  var migrator = new Migrator({
    db,
    provider: new FileMigrationProvider(
      path.resolve(__dirname, "../migrations")
    ),
  })

  var { error, results } = await migrator.migrateToLatest()

  if (results?.length == 0) {
    console.log("没有要更新的描述")
    db.destroy()
  }

  results?.forEach((it) => {
    if (it.status === "Success") {
      console.log(`migration "${it.migrationName}" was executed successfully`)
    } else if (it.status === "Error") {
      console.error(`failed to execute migration "${it.migrationName}"`)
    }
    db.destroy()
  })

  if (error) {
    console.error("failed to run `migrateToLatest`")
    console.error(error)
    db.destroy()
  }
}

main()
