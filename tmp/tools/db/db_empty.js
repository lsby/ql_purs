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
const readline_sync_1 = __importDefault(require("readline-sync"));
const lib_1 = require("./lib");
const dotenv_1 = __importDefault(require("dotenv"));
const path_1 = __importDefault(require("path"));
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
        process.stdout.write(`本操作将清除和清空数据库${database}, 所有表结构和数据都将丢失, 确定吗?[y/N]`);
        var yes = readline_sync_1.default.question();
        if (yes != "y" && yes != "Y") {
            console.log("用户取消了操作");
            return;
        }
        console.log("删除所有表...");
        yield (0, lib_1.删除所有表)();
    });
}
main();
