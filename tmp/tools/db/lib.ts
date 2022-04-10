import * as _knex from "knex"
import mysql from "mysql"

export async function 删除所有表() {
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

  var knex = _knex.default({
    client: "mysql",
    connection: { host, port, user, password, database },
  })

  try {
    var 所有表: string[] = (
      await knex
        .select("TABLE_NAME")
        .from("information_schema.TABLES")
        .where({ table_schema: database })
    ).map((a: any) => a.TABLE_NAME)

    var 删除所有外键约束: string[] = (
      await knex.raw(`
            SELECT concat('alter table ',table_schema,'.',table_name,' DROP FOREIGN KEY ',constraint_name,';')
            FROM information_schema.table_constraints
            WHERE constraint_type='FOREIGN KEY'
            AND table_schema='${database}'
        `)
    )[0].map((a: any) => (Object.values(a)[0] as string).trim())
    for (var sql of 删除所有外键约束) {
      await knex.raw(sql)
    }

    var 删除所有表 = await Promise.all(
      所有表.map((a) => knex.schema.dropTable(a))
    )
  } catch (e) {
    throw e
  } finally {
    await knex.destroy()
  }
}

export async function 新建表(
  schema: (knex: _knex.Knex<any, unknown[]>) => _knex.Knex.SchemaBuilder
) {
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

  var knex = _knex.default({
    client: "mysql",
    connection: { host, port, user, password, database },
  })

  try {
    var cmd = await schema(knex).generateDdlCommands()
    var sqlarr: string[] = cmd.sql
      .map((a) => (a as any).sql)
      .sort((a, b) => {
        if (a.indexOf("create table") != -1) {
          return -1
        }
        if (b.indexOf("create table") != -1) {
          return 1
        }
        if (a.indexOf("foreign key") != -1) {
          return 1
        }
        if (b.indexOf("foreign key") != -1) {
          return -1
        }
        return a - b
      })

    await knex.transaction(async (trx) => {
      for (var sql of sqlarr) {
        await trx.raw(sql)
      }
    })
  } catch (e) {
    throw e
  } finally {
    await knex.destroy()
  }
}

export async function 新建数据库() {
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

  var connection = mysql.createConnection({
    host,
    port,
    user,
    password,
  })

  connection.connect()

  await new Promise((res, rej) => {
    connection.query(
      `create database If Not Exists ${database} DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci`,
      function (error: any, results: any, fields: any) {
        if (error) return rej(error)
        res(null)
      }
    )
  })

  connection.end()
}
