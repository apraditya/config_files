# Pry config to work with RubyMine
# Pry.config.editor = proc { |file, line| "mine --line #{line} #{file}" }
Pry.config.editor = 'vim'
Pry.config.correct_indent = true
Pry.config.auto_indent = true

unless defined?(Pry::Prompt)
  Pry.config.prompt =  Pry::NAV_PROMPT
end

# === HISTORY ===
Pry::Commands.command /^$/, "repeat last command" do
  _pry_.run_command Pry.history.to_a.last
end

# Shortcut for calling pry_debug
def pd
  Pry.commands.alias_command 't', 'backtrace'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 'f', 'finish'
  Pry.commands.alias_command 'ff', 'frame'
  Pry.commands.alias_command 'u', 'up'
  Pry.commands.alias_command 'd', 'down'
  Pry.commands.alias_command 'b', 'break'
  Pry.commands.alias_command 'w', 'whereami'
  display_shortcuts
end

Pry.config.commands.alias_command "h", "hist -T 20", desc: "Last 20 commands"
Pry.config.commands.alias_command "hg", "hist -T 20 -G", desc: "Up to 20 commands matching expression"
Pry.config.commands.alias_command "hG", "hist -G", desc: "Commands matching expression ever used"
Pry.config.commands.alias_command "hr", "hist -r", desc: "hist -r <command number> to run a command"

if defined?(PryByebug)
   def pry_debug
     puts "You can also call 'pd' to save typing!"
     pd
   end

   def pp(obj)
    Pry::ColorPrinter.pp(obj)
   end
end

# Use amazing_print
begin
  require 'amazing_print'
  AmazingPrint.pry!
rescue LoadError => err
  puts "no amazing_print :( #{err}"
end

# Hit Enter to repeat last command
Pry::Commands.command /^$/, "repeat last command" do
  pry_instance.run_command Pry.history.to_a.last
end

before_session_hook = Pry::Hooks.new.add_hook(:before_session, :add_dirs_to_load_path) do
  # adds the directories /spec and /test directories to the path if they exist and not already included
  current_dir = `pwd`.chomp
  dirs_added = %w(spec test presenters lib).
    map{ |d| "#{current_dir}/#{d}" }.
    map do |path|
    if File.exist?(path) && !$:.include?(path)
      i$: << path
      path
    end
  end.compact
  puts "Added #{ dirs_added.join(", ") } to load path per hook in ~/.pryrc." unless dirs_added.empty?
end
before_session_hook.exec_hook(:before_session)

def more_help
  puts "Helpful shortcuts:"
  puts "hh  : hist -T 20       Last 20 commands"
  puts "hg : hist -T 20 -G    Up to 20 commands matching expression"
  puts "hG : hist -G          Commands matching expression ever used"
  puts "hr : hist -r          hist -r <command number> to run a command"
  puts

  puts "Samples variables"
  puts "a_array  :  [1, 2, 3, 4, 5, 6]"
  puts "a_hash   :  { hello: \"world\", free: \"of charge\" }"
  puts
  puts "helper   : Access Rails helpers"
  puts "app      : Access url_helpers"
  puts
  puts "require \"rails_helper\"              : To include Factory Girl Syntax"
  puts "include FactoryGirl::Syntax::Methods  : To include Factory Girl Syntax"
  puts
  puts "or if you defined one..."
  puts "require \"pry_helper\""
  puts
  puts "Sidekiq::Queue.new.clear              : To clear sidekiq"
  puts "Sidekiq.redis { |r| puts r.flushall } : Another clear of sidekiq"
  puts
  puts "Run `require 'factory_bot'; FactoryBot.find_definitions` for FactoryBot"
  puts
  display_shortcuts

  puts "Debugging Shortcuts"
  puts
  puts
  ""
end

def display_shortcuts
  puts "Installed debugging Shortcuts"
  puts 'w  :  whereami'
  puts 's  :  step'
  puts 'n  :  next'
  puts 'c  :  continue'
  puts 'f  :  finish'
  puts 'pp(obj)  :  pretty print object'
  puts ''
  puts 'Stack movement'
  puts 't  :  backtrace'
  puts 'ff :  frame'
  puts 'u  :  up'
  puts 'd  :  down'
  puts 'b  :  break'
  puts
  puts "Introspection"
  puts '$    :  show whole method of current context'
  puts '$ foo:  show definition of foo'
  puts '? foo:  show docs for for'
  puts
  puts "Be careful not to use shortcuts for temp vars, like 'u = User.first`"
  puts "Run `help` to see all the pry commands that would conflict (and lots good info)"
  puts "Run `more_help to see many helpful tips from the ~/.pryrc`"
  ""
end

def do_time(repetitions = 100, &block)
  require 'benchmark'
  Benchmark.bm{|b| b.report{repetitions.times(&block)}}
end

# Easily print methods local to an object's class
class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end

  def interesting_methods
    case self.class
    when Class
      self.public_methods.sort - Object.public_methods
    when Module
      self.public_methods.sort - Module.public_methods
    else
      self.public_methods.sort - Object.new.public_methods
    end
  end
end

# copy a string to the clipboard
def pbcopy(string)
  `echo "#{string}" | pbcopy`
  string
end
