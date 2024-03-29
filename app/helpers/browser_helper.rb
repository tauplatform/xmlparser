module BrowserHelper

  def placeholder(label=nil)
    "placeholder='#{label}'" if platform == 'apple'
  end

  def platform
    System::get_property('platform').downcase
  end

  def selected(option_value,object_value)
    "selected=\"yes\"" if option_value == object_value
  end

  def checked(option_value,object_value)
    "checked=\"yes\"" if option_value == object_value
  end

  def is_bb6
    platform == 'blackberry' && (Rho::System.getProperty('os_version').split('.')[0].to_i >= 6)
  end

  private
  HTML_ESCAPE = {'&' => '&amp;', '>' => '&gt;', '<' => '&lt;', '"' => '&quot;', "'" => '&#39;'}
  HTML_ESCAPE_REGEXP = /[&"'><]/
  public
  def html_escape(s)
    s.to_s.gsub(HTML_ESCAPE_REGEXP, HTML_ESCAPE)
  end

  alias h html_escape
end