var fs = require('fs')
var path = require('path')

module.exports = function (src, dst) {
    // https://blog.csdn.net/coooliang/article/details/89711471
    function mkdirsSync(dirname) {
        if (fs.existsSync(dirname)) {
            return true
        } else {
            if (mkdirsSync(path.dirname(dirname))) {
                fs.mkdirSync(dirname)
                return true
            }
        }
    }
    function _copy(src, dist) {
        var paths = fs.readdirSync(src)
        paths.forEach(function (p) {
            var _src = src + '/' + p
            var _dist = dist + '/' + p
            var stat = fs.statSync(_src)
            if (stat.isFile()) {
                fs.writeFileSync(_dist, fs.readFileSync(_src))
            } else if (stat.isDirectory()) {
                copyDir(_src, _dist)
            }
        })
    }
    function copyDir(src, dist) {
        var b = fs.existsSync(dist)
        if (!b) {
            mkdirsSync(dist)
        }
        _copy(src, dist)
    }
    function createDocs(src, dist) {
        copyDir(src, dist)
    }
    createDocs(src, dst)
}
