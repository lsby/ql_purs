import 'mocha'
import lib from '../dist/'
import * as tools from '@lsby/js_tools'
import path from 'path'

describe('测试组', async function () {
    it('测试1', async function () {
        var r = await lib('ls')
        tools.断言相等(r.includes('tsconfig.json'), true)
    })
    it('测试2', async function () {
        var r = await lib('ls', { cwd: path.resolve(__dirname, '.') })
        tools.断言相等(r.includes('index.test.ts'), true)
    })
    it('测试3', async function () {
        try {
            await lib('aaa')
        } catch (e) {
            return
        }
        throw '不应该到这里'
    })
})
