import * as child_process from 'child_process'
import spawn from 'cross-spawn'
import { ChildProcess } from 'child_process'

function 字符串转数组(s: string) {
    return s
        .toString()
        .replace(/\r/g, '')
        .split('\n')
        .filter((a) => a != null)
        .filter((a) => a != '')
}

export default function fun(cmd: string, opt?: child_process.SpawnOptions): Promise<string[]> {
    return new Promise((res, rej) => {
        var c = cmd.trim().replace(/  /g, ' ').split(' ')
        var 进程: ChildProcess = spawn(c[0], c.slice(1), opt)
        var out日志 = ''
        var err日志 = ''
        var 错误: Error | null = null

        if (进程.stdout == null) throw '创建失败'
        if (进程.stderr == null) throw '创建失败'
        if (进程.stdin == null) throw '创建失败'

        进程.on('close', (code) => {
            if (code == 0) {
                return res(字符串转数组(out日志))
            } else {
                return rej(
                    [错误 ? JSON.stringify(错误) : '', err日志, out日志]
                        .filter((a) => a != '')
                        .join('\n')
                        .trim(),
                )
            }
        })
        进程.on('error', (err) => {
            错误 = err
        })
        进程.stdout.on('data', (data) => {
            out日志 += data.toString()
        })
        进程.stderr.on('data', (data) => {
            err日志 += data.toString()
        })
    })
}
