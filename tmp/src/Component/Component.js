"use strict";

exports._add = function (a) {
  return function (b) {
    var React = require("react");

    return /*#__PURE__*/React.createElement(React.Fragment, null, /*#__PURE__*/React.createElement("div", {
      style: {
        border: 1,
        borderStyle: "solid",
        height: "100%",
        boxSizing: "border-box"
      }
    }, /*#__PURE__*/React.createElement("span", null, a + b)));
  };
};
"use strict";

exports._counter = function (n) {
  return function (add) {
    var React = require("react");

    return /*#__PURE__*/React.createElement(React.Fragment, null, /*#__PURE__*/React.createElement("div", {
      style: {
        border: 1,
        borderStyle: "solid",
        height: "100%",
        boxSizing: "border-box"
      }
    }, /*#__PURE__*/React.createElement("span", null, n), /*#__PURE__*/React.createElement("button", {
      onClick: function onClick() {
        return add();
      }
    }, "\u6309\u94AE")));
  };
};
