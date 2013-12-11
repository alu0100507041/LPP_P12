$:.unshift File.dirname(__FILE__) + 'lib'

require "bundler/gem_tasks"
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

task :default => :spec
desc "Ejecucion de pruebas rspec"
task :spec do
  sh "rspec --color --format documentation -Ilib -Ispec spec/matriz_spec.rb"
end

desc "Ejecucion de test con formato html"
task :thtml do
  sh "rspec --format html -Ilib -Ispec spec/matriz_spec.rb"
end

desc "Ejecucion de la Suma"
task :suma do
     sh "clear"
     sh "ruby lib/dsl.rb lib/suma.rb"
end

desc "Ejecucion de la Multiplicacion"
task :multiplicacion do
     sh "clear"
     sh "ruby lib/dsl.rb lib/multiplicacion.rb"
end

desc "Ejecucion de la Resta"
task :resta do
     sh "clear"
     sh "ruby lib/dsl.rb lib/resta.rb"
end

desc "Ejecucion de la Suma,Multiplicacion y Resta"
task :todas do
     sh "clear"
     sh "ruby lib/dsl.rb lib/suma.rb"
     sh "ruby lib/dsl.rb lib/resta.rb"
     sh "ruby lib/dsl.rb lib/multiplicacion.rb"

end
