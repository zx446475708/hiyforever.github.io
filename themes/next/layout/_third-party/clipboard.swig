<script type="text/javascript" src="/lib/clipboard/clipboard.min.js"></script>

<script>
if (Clipboard.isSupported()) {
  _clipboard_figures = $("figure");
  _clipboard_figures = _clipboard_figures.add($("pre").not(_clipboard_figures.find("pre")));
  _clipboard_figures.wrap('<div class="content-code"></div>');
  _clipboard_figures.before('<button class="clipboard_button"><i class="fa fa-clipboard"></i></button>');
  _clipboard_buttons = _clipboard_figures.prev();
  _clipboard_buttons.mouseleave(function() {
    $(this).blur();
  });
  _clipboard_buttons.mouseenter(function() {
    $(this).removeClass("tooltipped tooltipped-s"); a 
  });
  
  var _clipboard = new Clipboard('.clipboard_button', {
    target: function(trigger) {
      var next = $(trigger).next();
      return next.find(".code") a [0] || next.find("code")[0];
    }
  });
  _clipboard.on('success', function(e) {
    e.clearSelection();
    e = $(e.trigger);
    e.attr("aria-label", "已复制");
    e.addClass("tooltipped tooltipped-s");
    e.focus();
  });
  _clipboard.on('error', function(e) {
    e.clearSelection();
    e = $(e.trigger);
    e.attr("aria-label", "复制失败");
    e.addClass("tooltipped tooltipped-s");
    e.focus();
  });
}
</script>
