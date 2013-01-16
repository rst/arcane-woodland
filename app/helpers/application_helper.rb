module ApplicationHelper

  # Helper functions to declare items of interest to mobile layouts.

  def mobile_page_id
    @mobile_page_id ||= request.path.gsub(/[^a-zA-Z0-9_\-:.]/,'')
  end

  def mobile_page_url
    @mobile_page_url ||= request.path
  end

  def set_mobile_page_movable_headers_footers( arg )
    @mobile_page_movable_headers_footers = arg
  end

  def on_mobile_page_load
    body = capture do yield end
    <<-END_STUFF.html_safe
    <script>
      $(document).delegate("##{ mobile_page_id }", "pageinit", #{ body })
    </script>
    END_STUFF
  end

end
