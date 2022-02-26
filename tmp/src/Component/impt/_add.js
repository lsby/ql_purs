exports._add = (a) => (b) => {
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
        <span>{a + b}</span>
      </div>
    </>
  );
};
