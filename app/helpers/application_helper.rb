module ApplicationHelper

  # Helper functions to declare items of interest to mobile layouts.
  #
  # All this really amounts to is setting random instance variables,
  # but it's a little more likely that typos in the names will be
  # caught, rather than causing silent failures...

  def set_mobile_page_id( arg )
    unless @mobile_page_id.nil?
      raise RuntimeError, "Already have mobile_page_id"
    end
    @mobile_page_id = arg
  end

  def set_mobile_page_url( arg )
    unless @mobile_page_url.nil?
      raise RuntimeError, "Already have mobile_page_url"
    end
    @mobile_page_url = arg
  end

  def set_mobile_page_movable_headers_footers( arg )
    @mobile_page_movable_headers_footers = arg
  end

  def on_mobile_page_load
    if @mobile_page_id.nil?
      raise RuntimeError, "Have on_mobile_page_load, but no set_mobile_page_id"
    end
    body = capture do yield end
    <<-END_STUFF.html_safe
    <script>
      $(document).delegate("##{ @mobile_page_id }", "pageinit", #{ body })
    </script>
    END_STUFF
  end

end
