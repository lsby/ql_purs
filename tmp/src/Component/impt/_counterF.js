exports._counterF = (opt) => {
  var React = require("react");
  return (
    <>
      <div
        style={{
          border: 1,
          borderStyle: "solid",
          height: "100%",
          boxSizing: "border-box",
        }}
      >
        <span>{opt.n}</span>
        <button onClick={() => opt.onClick()}>按钮</button>
      </div>
    </>
  );
};
