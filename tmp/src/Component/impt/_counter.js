exports._counter = (n) => (add) => {
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
        <span>{n}</span>
        <button onClick={() => add()}>按钮</button>
      </div>
    </>
  );
};
