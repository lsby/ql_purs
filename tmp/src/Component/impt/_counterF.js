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
        <div>这个组件是通过jsx编写的</div>
        <div>{opt.n}</div>
        <button onClick={opt.onClick(opt.n + 1)}>按钮</button>
      </div>
    </>
  );
};
