<script type="text/javascript" src="/lib/clipboard/clipboard.min.js"></script>

<script>
if (Clipboard.isSupported()) {
  var _clipboard = new Clipboard('.clipboard_button', {
    target: function(trigger) {
      var e = $(trigger);
      e.attr(_clipboard_buttons_tip_label, "");
      e.addClass(_clipboard_buttons_tip_class);
      var next = e.next();
      return next.find(".code")[0] || next.find("code")[0];
    }
  });
  _clipboard.on('success', function(e) {
    e.clearSelection();
    var e = $(e.trigger);
    e.attr(_clipboard_buttons_tip_label, "已复制");
    e.blur();
  });
  _clipboard.on('error', function(e) {
    e.clearSelection();
    var e = $(e.trigger);
    e.attr(_clipboard_buttons_tip_label, "复制失败");
    e.blur();
  });

  _clipboard_buttons_add = function(e) {
    e.wrap('<div class="clipboard-code"></div>');
    e.before('<button class="clipboard_button"><i class="fa fa-clipboard"></i></button>');
    
    _clipboard_buttons = e.prev();
    _clipboard_buttons_tip_class = "tooltipped tooltipped-s";
    _clipboard_buttons_tip_label = "aria-label";
    _clipboard_buttons_tip_remove = function() {
      $(this).removeClass(_clipboard_buttons_tip_class);
    };
    _clipboard_buttons_blur = function() {
      $(this).blur();
    };
    _clipboard_buttons.hover(function(e) {
      _clipboard_buttons_tip_remove.call($(this));
      if (e.buttons == 1) {
        $(this).focus();
      }
    }, _clipboard_buttons_blur);
    _clipboard_buttons.mouseup(_clipboard_buttons_blur);
    _clipboard_buttons.mousedown(_clipboard_buttons_tip_remove);
    _clipboard_buttons.on('touchstart', _clipboard_buttons_tip_remove);
  };
  _clipboard_figures = $("figure");
  _clipboard_buttons_add(_clipboard_figures.add($("pre").not(_clipboard_figures.find("pre"))));
}
</script>
