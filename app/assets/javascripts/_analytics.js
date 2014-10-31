window.track = function (category, action) {
  ga("send", "event", category, action);
}
