"use strict";
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
exports.main = void 0;
const knex_1 = __importDefault(require("knex"));
const fs_1 = __importDefault(require("fs"));
const path_1 = __importDefault(require("path"));
const dotenv_1 = __importDefault(require("dotenv"));
function main() {
    return __awaiter(this, void 0, void 0, function* () {
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
        var knex = (0, knex_1.default)({
            client: "mysql",
            connection: { host, port, user, password, database },
        });
        try {
            var 描述 = yield knex
                .select()
                .from("information_schema.columns")
                .where({ table_schema: database });
            var 整理 = 描述
                .map((a) => a.TABLE_NAME)
                .map((a) => ({ 表名: a, 描述: 描述.filter((b) => b.TABLE_NAME == a) }))
                .map((a) => (Object.assign(Object.assign({}, a), { 描述: a.描述.map((b) => (Object.assign(Object.assign({}, b), { 翻译类型: (function () {
                        var 结果 = "";
                        var 空补充 = b.IS_NULLABLE == "YES" ? " | null" : "";
                        var 选填标记 = b.EXTRA == "DEFAULT_GENERATED" ||
                            b.EXTRA == "auto_increment" ||
                            b.COLUMN_DEFAULT != null
                            ? true
                            : false;
                        if (b.DATA_TYPE == "int") {
                            结果 = "number";
                        }
                        else if (b.DATA_TYPE == "double") {
                            结果 = "number";
                        }
                        else if (b.DATA_TYPE == "varchar") {
                            结果 = "string";
                        }
                        else if (b.COLUMN_TYPE == "tinyint(1)") {
                            结果 = "0 | 1";
                        }
                        else if (b.DATA_TYPE == "tinyint") {
                            结果 = "number";
                        }
                        else if (b.DATA_TYPE == "decimal") {
                            结果 = "number";
                        }
                        else if (b.DATA_TYPE == "enum") {
                            结果 = b.COLUMN_TYPE
                                .replace(/enum\((.*)\)/, "$1")
                                .split(",")
                                .join(" | ");
                        }
                        else {
                            结果 = "string";
                        }
                        if (选填标记) {
                            结果 = `Generated<${结果}>`;
                        }
                        return 结果 + 空补充;
                    })() }))) })));
            var ts描述 = [
                [`import { Generated } from 'kysely'`],
                [""],
                ["export default interface Database {"],
                [
                    ...new Set(整理.map((a) => `    '${a.表名}': { ${a.描述
                        .map((b) => `'${b.COLUMN_NAME}': ${b.翻译类型}`)
                        .join("; ")} }`)),
                ],
                ["}"],
                [""],
            ]
                .map((a) => a.join("\n"))
                .join("\n");
            fs_1.default.writeFileSync(path_1.default.resolve(__dirname, "../types/Database.ts"), ts描述);
        }
        catch (e) {
            throw e;
        }
        finally {
            yield knex.destroy();
        }
    });
}
exports.main = main;
main();
