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
const dotenv_1 = __importDefault(require("dotenv"));
const path_1 = __importDefault(require("path"));
// testFun :: Task Unit
exports.testFun = () => {
    return f();
    function f() {
        return __awaiter(this, void 0, void 0, function* () {
            console.log("这是用ts写的文件");
        });
    }
};
// initEnv :: Task Unit
exports.initEnv = () => {
    return f();
    function f() {
        return __awaiter(this, void 0, void 0, function* () {
            if (process.env["NODE_ENV"] == "development") {
                console.log("使用 dev 环境");
                dotenv_1.default.config({ path: path_1.default.resolve(__dirname, "../../.env/dev.env") });
            }
            else if (process.env["NODE_ENV"] == "release") {
                console.log("使用 release 环境");
                dotenv_1.default.config({
                    path: path_1.default.resolve(__dirname, "../../.env/release.env"),
                });
            }
            else if (process.env["NODE_ENV"] == "production") {
                console.log("使用 production 环境");
                dotenv_1.default.config({ path: path_1.default.resolve(__dirname, "../../.env/prod.env") });
            }
            else {
                throw "没有指定运行环境";
            }
            if (process.env["NODE_ENV"] != "development") {
                console.log("环境变量:", process.env);
            }
        });
    }
};
