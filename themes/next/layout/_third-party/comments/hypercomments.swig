{% if not (theme.duoshuo and theme.duoshuo.shortname) and not theme.duoshuo_shortname and not theme.disqus_shortname %}

	{% if theme.hypercomments_id %}

		{% if page.comments %}
		<script type="text/javascript" src="/js/src/hypercomments.js"></script>
		{% endif %}

		<script type="text/javascript">
		_hcwp = window._hcwp || [];

		_hcwp.push({widget:"Bloggerstream", widget_id: {{ theme.hypercomments_id }}, selector:".hc-comment-count", label: "{\%COUNT%\}" });

		{% if page.comments %}
		_hcwp.push({widget:"Stream", widget_id: {{ theme.hypercomments_id }}, xid: "{{ page.path }}", texts: _hcwp_texts, auth: "eyJpZCI6IjE0OTc4NDkzMTciLCJuaWNrIjoiVGVzdCBOaWNrIiwiZW1haWwiOiJ0ZXN0QGVtYWlsLmNvbSIsImF2YXRhciI6Imh0dHBzOlwvXC93d3cuaHlwZXJjb21tZW50cy5jb21cL3N0YXRpY1wvaW1nXC9oY2xvZ28ucG5nIiwicHJvZmlsZV91cmwiOiJodHRwczpcL1wvcHJvZmlsZS5oeXBlcmNvbW1lbnRzLmNvbSJ9_1497850587_eca1ce7d4dcc0951a0f74c1060ec1145"});
		{% endif %}

		(function() {
		if("HC_LOAD_INIT" in window)return;
		HC_LOAD_INIT = true;
		var lang = "zh";
		var hcc = document.createElement("script"); hcc.type = "text/javascript"; hcc.async = true;
		hcc.src = ("https:" == document.location.protocol ? "https" : "http")+"://w.hypercomments.com/widget/hc/{{ theme.hypercomments_id }}/"+lang+"/widget.js";
		var s = document.getElementsByTagName("script")[0];
		s.parentNode.insertBefore(hcc, s.nextSibling);
		})();
		</script>

	{% endif %}

{% endif %}
