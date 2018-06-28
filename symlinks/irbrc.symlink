require "rubygems"

# Require core.
require "date"
require "time"

# Extend IRB features.
require "irb/completion"
require "irb/ext/save-history"

# Aliases.
alias quit exit
alias q exit

# ANSI colour constants.
ANSI = {}
ANSI[:RESET]     = "\e[0m"
ANSI[:BOLD]      = "\e[1m"
ANSI[:UNDERLINE] = "\e[4m"
ANSI[:LGRAY]     = "\e[0;37m"
ANSI[:GRAY]      = "\e[1;30m"
ANSI[:RED]       = "\e[31m"
ANSI[:GREEN]     = "\e[32m"
ANSI[:YELLOW]    = "\e[33m"
ANSI[:BLUE]      = "\e[34m"
ANSI[:MAGENTA]   = "\e[35m"
ANSI[:CYAN]      = "\e[36m"
ANSI[:WHITE]     = "\e[37m"

# Wrap ANSI escape sequences in Readline ignore markers.
ANSI.each do |_k, v|
  v.replace "\001#{v}\002"
end

# Store IRB history.
IRB.conf[:SAVE_HISTORY] = 1000

# Build a simple colourful IRB prompt.
IRB.conf[:PROMPT][:SIMPLE_COLOR] = {
  PROMPT_I: "#{ANSI[:BLUE]}>>#{ANSI[:RESET]} ",
  PROMPT_N: "#{ANSI[:BLUE]}>>#{ANSI[:RESET]} ",
  PROMPT_C: "#{ANSI[:RED]}?>#{ANSI[:RESET]} ",
  PROMPT_S: "#{ANSI[:YELLOW]}?>#{ANSI[:RESET]} ",
  RETURN:   "#{ANSI[:GREEN]}=>#{ANSI[:RESET]} %s\n"
}
IRB.conf[:PROMPT_MODE] = :SIMPLE_COLOR

# Awesome Print for sexier outputs - https://github.com/michaeldv/awesome_print.
begin
  require "awesome_print"
  AwesomePrint.irb!
rescue LoadError
  puts "Missing gem `awesome_print`"
end

# Ensure terminal is reset at exit.
Kernel.at_exit do
  puts ANSI[:RESET].to_s
end

# Helper to show methods that are defined directly on an object.
class Object
  def local_methods
    (methods - self.class.superclass.instance_methods).sort
  end
end

# Enable route helpers in Rails console.
include Rails.application.routes.url_helpers if defined? Rails
