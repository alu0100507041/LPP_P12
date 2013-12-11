filename = ARGV.shift

calculo = File.open(filename).read
calculo = <<"CALCULO"
	require './lib/matrizds'
	MatrizDSL.new() do
        	#{calculo}
	end
CALCULO
matrizDSL = eval calculo

matrizDSL.run

