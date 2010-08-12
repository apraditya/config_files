require 'rake'
require 'erb'

desc "Install the config files into user's home directory"
task :install do
  replace_all = false
  Dir[ '*' ].each do |file|
    next if %w[ Rakefile README.rdoc LICENSE ].include? file

    if File.exist?( File.join(ENV['HOME'], ".#{file.sub('.erb', '')}") )
      if File.identical? file, File.join(ENV['HOME'], ".#{file.sub('.erb', '')}" )
        puts "identical ~/.#{file.sub('.erb', '' )}"
      elsif replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file.sub('.erb', '')} ? [ ynaq ]"
        case $stdin.gets.chomp
        when 'q'
          exit
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        else
          puts "skipping ~/.#{file.sub('.erb', '' )}"
        end
      end
    else
      link_file(file)
    end
  end # of Dir[ '*' ]
end # of task :install

namespace :vim do
  IGNORE = [ /\.gitignore$/, /Rakefile$/, /LICENSE$/i, /README\.?/i ]
  basic_plugins = %w( vim-haml nerdtree vim-rails vim-cucumber)
  repo_dir = ENV['PWD']
  resources_dir = 'vim-resources'
  
  desc "Install vim basic plugins (#{basic_plugins.join(',')})"
  task :install_basic_plugins do
    basic_plugins.each do |plugin|
      Rake::Task[:install_plugin].invoke(plugin)
    end
  end

  desc "Install vim plugin specified in the arguments"
  task :install_plugin, :plugin_name do |task, arg|
    # Checks the existance
    submodule = "#{resources_dir}/#{arg[:plugin_name]}"
    if File.exist? submodule
      puts "Installing plugin: #{arg[:plugin_name]}"
      system %Q{ git submodule update "#{submodule}" } if Dir["#{submodule}/*"].size == 0
      plugin_files = `cd "#{submodule}" && git ls-files`.split("\n")
      plugin_files.reject! { |file| IGNORE.any? { |re| file.match(re) } }
      install_vim_plugin(plugin_files, submodule)
    else
      puts "#{arg[:plugin_name]} not found or has not been added as a submodule"
    end
  end

end


# FUNCTIONS
def install_vim_plugin(plugin_files, module_dir)
  replace_all = false
  plugin_files.each do |file|
    target_dir = "vim/#{File.dirname(file)}"
    system %Q{ mkdir -p "#{target_dir}" } unless File.exist? target_dir
    source = "#{module_dir}/#{file}"
    target = "vim/#{file}"
    if File.exist? target
      if File.identical? source, target
        puts "identical #{target}"
      elsif replace_all
        replace(source, target)
      else
        print "overwrite #{target} ? [ ynaq ]"
        case $stdin.gets.chomp
        when 'q'
          exit
        when 'a'
          replace_all = true
          replace(source, target)
        when 'y'
          replace(source, target)
        else
          puts "skipping #{target}"
        end
      end
    else
      internal_link(source, target)
    end
  end
end

def replace(source, target)
  system %Q{ rm "#{target}" }
  internal_link(source, target)
end

def internal_link(source, target)
  puts "linking #{source} to #{target}"
  system %Q{ ln -s "$PWD/#{source}" "#{target}" }
end


def replace_file(file)
  system %Q{ rm -rf "$HOME/.#{file.sub('.erb', '' )}" }
  link_file(file)
end

def link_file(file)
  if file =~ /.erb$/
    puts "generating ~/.#{file.sub('.erb', '' )}"
    File.open( File.join( ENV['HOME'], ".#{file.sub('.erb', '' )}"), 'w' ) do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    puts "linking ~/.#{file}"
    system %Q{ ln -s "$PWD/#{file}" "$HOME/.#{file}" }
  end
end
