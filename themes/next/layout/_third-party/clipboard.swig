<script type="text/javascript" src="/lib/clipboard/clipboard.min.js"></script>

<script>
if (Clipboard.isSupported()) {
  _clipboard_figures = $("figure");
  _clipboard_figures = _clipboard_figures.add($("pre").not(_clipboard_figures.find("pre")));
  _clipboard_figures.wrap('<div class="content-code"></div>');
  _clipboard_figures.before('<button class="clipboard_button tooltipped tooltipped-s"><i class="fa fa-clipboard"></i></button>');
  _clipboard_figures.prev().mouseleave(function() {
    var e = $(this);
    e.blur();
    e.removeAttr("aria-label");
  });
  
  var _clipboard = new Clipboard('.clipboard_button', {
    target: function(trigger) {
      var e = $(trigger);
      e.attr("aria-label", "正在复制");
      var next = e.next();
      return next.find(".code")[0] || next.find("code")[0];
    }
  });
  _clipboard.on('success', function(e) {
    e.clearSelection();
    e = $(e.trigger);
    e.attr("aria-label", "已复制");
    e.focus();
  });
  _clipboard.on('error', function(e) {
    e.clearSelection();
    e = $(e.trigger);
    e.attr("aria-label", "复制失败");
    e.focus();
  });
}
</script>
