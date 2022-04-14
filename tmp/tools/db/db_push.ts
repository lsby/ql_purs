import { FileMigrationProvider, Kysely, Migrator, MysqlDialect } from "kysely"
import path from "path"
import { 获得环境变量, 新建数据库 } from "./lib"

async function main() {
  var { host, port, user, password, database } = 获得环境变量()

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
