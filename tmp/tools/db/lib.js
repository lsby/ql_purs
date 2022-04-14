"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.新建数据库 = exports.新建表 = exports.删除所有表 = exports.获得环境变量 = void 0;
const _knex = __importStar(require("knex"));
const mysql_1 = __importDefault(require("mysql"));
const path_1 = __importDefault(require("path"));
const dotenv_1 = __importDefault(require("dotenv"));
function 获得环境变量() {
    if (process.env["NODE_ENV"] == "development") {
        console.log("使用 dev 环境");
        dotenv_1.default.config({ path: path_1.default.resolve(__dirname, "../../.env/dev.env") });
    }
    else if (process.env["NODE_ENV"] == "release") {
        console.log("使用 release 环境");
        dotenv_1.default.config({ path: path_1.default.resolve(__dirname, "../../.env/release.env") });
    }
    else if (process.env["NODE_ENV"] == "production") {
        console.log("使用 production 环境");
        dotenv_1.default.config({ path: path_1.default.resolve(__dirname, "../../.env/prod.env") });
    }
    else {
        throw "没有指定运行环境";
    }
    var host = process.env["DB_HOST"];
    var port = Number(process.env["DB_PORT"]);
    var user = process.env["DB_USER"];
    var password = process.env["DB_PWD"];
    var database = process.env["DB_NAME"];
    if (host == null ||
        port == null ||
        user == null ||
        password == null ||
        database == null) {
        throw "环境变量错误";
    }
    if (isNaN(port)) {
        throw "环境变量错误";
    }
    return { host, port, user, password, database };
}
exports.获得环境变量 = 获得环境变量;
function 删除所有表() {
    return __awaiter(this, void 0, void 0, function* () {
        var { host, port, user, password, database } = 获得环境变量();
        var host = process.env["DB_HOST"];
        var port = Number(process.env["DB_PORT"]);
        var user = process.env["DB_USER"];
        var password = process.env["DB_PWD"];
        var database = process.env["DB_NAME"];
        var knex = _knex.default({
            client: "mysql",
            connection: { host, port, user, password, database },
        });
        try {
            var 所有表 = (yield knex
                .select("TABLE_NAME")
                .from("information_schema.TABLES")
                .where({ table_schema: database })).map((a) => a.TABLE_NAME);
            var 删除所有外键约束 = (yield knex.raw(`
            SELECT concat('alter table ',table_schema,'.',table_name,' DROP FOREIGN KEY ',constraint_name,';')
            FROM information_schema.table_constraints
            WHERE constraint_type='FOREIGN KEY'
            AND table_schema='${database}'
        `))[0].map((a) => Object.values(a)[0].trim());
            for (var sql of 删除所有外键约束) {
                yield knex.raw(sql);
            }
            var 删除所有表 = yield Promise.all(所有表.map((a) => knex.schema.dropTable(a)));
        }
        catch (e) {
            throw e;
        }
        finally {
            yield knex.destroy();
        }
    });
}
exports.删除所有表 = 删除所有表;
function 新建表(schema) {
    return __awaiter(this, void 0, void 0, function* () {
        var { host, port, user, password, database } = 获得环境变量();
        var knex = _knex.default({
            client: "mysql",
            connection: { host, port, user, password, database },
        });
        try {
            var cmd = yield schema(knex).generateDdlCommands();
            var sqlarr = cmd.sql
                .map((a) => a.sql)
                .sort((a, b) => {
                if (a.indexOf("create table") != -1) {
                    return -1;
                }
                if (b.indexOf("create table") != -1) {
                    return 1;
                }
                if (a.indexOf("foreign key") != -1) {
                    return 1;
                }
                if (b.indexOf("foreign key") != -1) {
                    return -1;
                }
                return a - b;
            });
            yield knex.transaction((trx) => __awaiter(this, void 0, void 0, function* () {
                for (var sql of sqlarr) {
                    yield trx.raw(sql);
                }
            }));
        }
        catch (e) {
            throw e;
        }
        finally {
            yield knex.destroy();
        }
    });
}
exports.新建表 = 新建表;
function 新建数据库() {
    return __awaiter(this, void 0, void 0, function* () {
        var { host, port, user, password, database } = 获得环境变量();
        var connection = mysql_1.default.createConnection({
            host,
            port,
            user,
            password,
        });
        connection.connect();
        yield new Promise((res, rej) => {
            connection.query(`create database If Not Exists ${database} DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci`, function (error, results, fields) {
                if (error)
                    return rej(error);
                res(null);
            });
        });
        connection.end();
    });
}
exports.新建数据库 = 新建数据库;
