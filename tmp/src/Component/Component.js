"use strict";

exports._counterF = function (opt) {
  var React = require("react");

  return /*#__PURE__*/React.createElement(React.Fragment, null, /*#__PURE__*/React.createElement("div", {
    style: {
      border: 1,
      borderStyle: "solid",
      height: "100%",
      boxSizing: "border-box"
    }
  }, /*#__PURE__*/React.createElement("div", null, "\u8FD9\u4E2A\u7EC4\u4EF6\u662F\u901A\u8FC7jsx\u7F16\u5199\u7684"), /*#__PURE__*/React.createElement("div", null, opt.n), /*#__PURE__*/React.createElement("button", {
    onClick: opt.onClick(opt.n + 1)
  }, "\u6309\u94AE")));
};
