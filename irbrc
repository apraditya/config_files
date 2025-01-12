require 'rubygems'

# Use Pry everywhere if possible
begin
  require 'pry'
  Pry.start
  exit
rescue LoadError => e
  warn "Couldn't load Pry: #{e}"
end

# Autocomplete
require 'irb/completion'

# amazing_print
begin
  require 'amazing_print'
  AmazingPrint.irb!
rescue LoadError => e
  warn "Couldn't load amazing_print: #{e}"
end

# Prompt behavior
ARGV.concat ['--readline', '--prompt-mode', 'simple']

# History
IRB.conf[:EVAL_HISTORY] = 1000
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"

# load .irbrc_rails in rails environments
railsrc_path = File.expand_path('~/.irbrc_rails')
if (ENV['RAILS_ENV'] || defined? Rails) && File.exist?(railsrc_path)
  begin
    load railsrc_path
  rescue StandardError
    warn "Could not load: #{railsrc_path} because of #{$!.message}"
  end
end

# Easily print methods local to an object's class
class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end

  def interesting_methods
    case self.class
    when Class
      public_methods.sort - Object.public_methods
    when Module
      public_methods.sort - Module.public_methods
    else
      public_methods.sort - Object.new.public_methods
    end
  end
end

# copy a string to the clipboard
def pbcopy(string)
  `echo "#{string}" | pbcopy`
  string
end
