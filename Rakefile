require 'rake'
require 'erb'

MiscPlugins = %w( snipmate.vim Command-T )
ResourcesDir = 'vim-resources'
IGNORE = [ /\.gitignore$/, /Rakefile$/, /LICENSE$/i, /README\.?/i, /plugin-info\.?/i ]

desc "Install the config files into user's home directory"
task :install do
  replace_all = false
  Dir[ '*' ].each do |file|
    next if %w[ Rakefile README.md zshrc_with_omz LICENSE ].include? file

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


# FUNCTIONS

def replace_file(file)
  system %Q{ rm -rf "$HOME/.#{file.sub('.erb', '' )}" }
  link_file(file)
end

def link_file(file, target_file = nil)
  target_file ||= "$HOME/.#{file}"
  if file =~ /.erb$/
    puts "generating ~/.#{file.sub('.erb', '' )}"
    File.open( File.join( ENV['HOME'], ".#{file.sub('.erb', '' )}"), 'w' ) do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    puts "linking ~/.#{file}"
    system %Q{ ln -s "$PWD/#{file}" #{target_file} }
  end
end
