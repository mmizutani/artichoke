# frozen_string_literal: true

def spec
  reinitialize_frozen_regexp_literal

  true
end

# Since Ruby 3.0, Regexp literals are frozen by default.
# https://github.com/ruby/ruby/pull/2705
def reinitialize_frozen_regexp_literal
  r = /abc/
  begin
    r.send(:initialize, /xyz/) && raise
  rescue StandardError => e
    raise unless e.is_a?(FrozenError) && e.message == 'can\'t modify literal regexp'
  end

  r = /abc/
  begin
    r.send(:initialize, Regexp.compile('abc')) && raise
  rescue StandardError => e
    raise unless e.is_a?(FrozenError) && e.message == 'can\'t modify literal regexp'
  end
end

spec if $PROGRAM_NAME == __FILE__
