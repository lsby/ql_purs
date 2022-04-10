"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const ramda_1 = __importDefault(require("ramda"));
// testFun :: Effect Unit
exports.testFun = () => {
    var x = ramda_1.default.range(0, 3);
    console.log("这是用ts写的文件");
};
