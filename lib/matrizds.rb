

# =begin
#
# Modulo que contiene las clases de las matrices con sus respectivas funciones
#
# =end
module Matrizds

	# ==begin
	#
	# Clase Matriz: Contiene todas las funciones necesarias para las matrices
	#
	# ==end

	class Matriz
		# ===begin
		#
		# Metodos Getters y Settes
		#
		# ===end
  
		attr_accessor :n,:m,:A,:min,:max

		# ===begin
		#
		# Metodo constructor de la clase Matriz
		#
		# ===end
		def initialize(*args)
			@n=args[0]
			@m=args[1]
			@A=args[2]
      			@min, @max= min_max()
		end

		# ===begin
		#
		# Comprobar si una matriz tiene el mismo numero de filas que de columnas
		#
		# ===end
		def cuadrada
			@n==@m
		end

		# ===begin
		#
		# Metodo que calcula el minimo y el máximo de una matriz
		#
		# ===end
		def min_max
			min,max =@A[0][0],@A[0][0]
			if nil==min 
				return 0,0
			end 
			for i in  0...@n do
				for j in 0...@m do
					if max< @A[i][j] 
						max=@A[i][j]
					end
					if @A[i][j]<min 
						min=@A[i][j]
					end

				end
			end
			return min, max
		end

		# ===begin
		#
		# Metodo para imprimir la matriz
		#
		# ===end
		def to_s
			salida=""
			for i in 0...@n do
				salida+="["
				for j in 0..@m do	
					if @A[i][j].instance_of? Fixnum
						salida+="#{@A[i][j]}"					
					else
						salida+="#{@A[i][j].to_s}"
					end
					if j < @m-1
						salida+=", "
					end
				end
					salida+="]"
			end
			return salida
		end

		# ===begin
		#
		# Metodo para restar dos matrices
		#
		# ===end
		def -(other)
			c=Matriz.new(@n,@m,Array.new(@n){Array.new(@m)})
			for i in 0...@n do
				for j in 0...@m do
					c.A[i][j] =@A[i][j] - other.A[i][j]
				end
			end
			return c
		end

		# ===begin
		#
		# Metodo para sumar dos matrices
		#
		# ===end
		def +(other) 
			c=Matriz.new(@n,@m,Array.new(@n){Array.new(@m)})
      			@n.times {|i|@m.times{|j|  c.A[i][j] =@A[i][j] + other.A[i][j]}}
			return c
		end

		# ===begin
		#
		# Metodo para multiplicar dos matrices
		#
		# ===end
		def *(other)
			c=Matriz.new(@n,@m,Array.new(@n,0){Array.new(@m,0)})
		 @n.times {|i|@m.times{|j|@n.times{|k| c.A[i][j] += @A[i][k] * other.A[k][j]}}}	
		c 
		end

		# ===begin
		#
		# Metodo para dividir una matriz por un escalar
		#
		# ===end
		def /(other)
			c=Matriz.new(@n,@m,Array.new(@n){Array.new(@m)})
			for i in 0...@n do
				for j in 0...@m do
					c.A[i][j] =@A[i][j] / other.to_f
				end
			end
			return c
		end

		# ===begin
		#
		# Metodo para multiplicar una matriz por un escalar
		#
		# ===end
		def mult(a)
			c=Matriz.new(@n,@m,Array.new(@n){Array.new(@m)})
			for i in 0...@n do
				for j in 0...@m do
					c.A[i][j]=@A[i][j]*a
				end
			end
			c
		end
	end

	# ==begin
	#
	# Clase Fraccion: Contiene todas las funciones necesarias para las fracciones
	#
	# ==end
	class Fraccion
		include Comparable

		# ===begin
		#
		# Metodo contructor de fracciones
		#
		# ===end
		def  initialize (a,b)
			c = gcd(a,b)
			@a = (a/c)
			@b = (b/c)
		end
 		# ===begin
		#
		# Metodos Getters y Setters
		#
		# ===end
		attr_accessor :a,:b

		# ===begin
		#
		# Metodo para imprimir fracciones
		#
		# ===end
		def to_s
			"#{@a}/#{@b}"
		end

		# ===begin
		#
		# Metodo para devolver el valor de la fraccion en punto flotante
		#
		# ===end
		def to_f 
			c = @a.to_f/@b.to_f
			c
		end

		# ===begin
		#
		# Metodo para obtener el valor absoluto de las fracciones
		#
		# ===end
		def abs
			c = @a.to_f/@b.to_f
			return c.abs
		end

		# ===begin
		#
		# Metodo para calcular reciproco de fracciones
		#
		# ===end
		def reciprocal
			f=Fraccion.new(1,1)
			f.a=@b
			f.b=@a
			f
		end

		# ===begin
		#
		# Metodo para calcular el opuesto de una fraccion
		#
		# ===end
		def -@
			Fraccion.new(-@a,@b)
		end

		# ===begin
		#
		# Metodo para calcular el minimo de una fraccion
		#
		# ===end
		def minimiza(x,y)
			d = gcd(x,y)
			x = x/d
			y = y/d
			return x,y
		end

		# ===begin
		#
		# Metodo para calcular la suma de fracciones
		#
		# ===end
		def +(other)
			f =Fraccion.new(1,1)
			if other.instance_of? Fixnum
				f.a=(other*@b)+@a
				f.b=@b
			else 
				f.a=@a*other.b+other.a*@b
				f.b=@b*other.b
			end
			#minimizamos el resultado
			f.a,f.b = minimiza(f.a,f.b)
			return f
		end

		# ===begin
		#
		# Metodo para restar dos fracciones
		#
		# ===end
		def -(other)
			f =Fraccion.new(1,1)
			if other.instance_of? Fixnum
				f.a=@a-(other*@b)
				f.b=@b
			else
				f.a=@a*other.b-other.a*@b
				f.b=@b*other.b
			end
			#minimizamos el resultado
			f.a,f.b = minimiza(f.a,f.b)
			return f
		end

		# ===begin
		#
		# Metodo para multiplicar dos fracciones
		#
		# ===end
		def *(other)
			f =Fraccion.new(1,1)
			if other.instance_of? Fixnum
				f.b = @b
				f.a = @a*other
			else
				f.a=@a * other.a
				f.b=@b * other.b 
			end
			#minimizamos el resultado
			f.a,f.b = minimiza(f.a,f.b)
			return f
		end

		# ===begin
		#
		# Metodo para calcular el maximo comun divisor de una fraccion
		#
		# ===end
		def gcd(u, v)
			u, v = u.abs, v.abs
			while v != 0
				u, v = v, u % v
			end
			u
		end

		# ===begin
		#
		# Metodo para calcular la division de fracciones
		#
		# ===end
		def /(other)
			f =Fraccion.new(1,1)
			if other.instance_of? Fixnum
				f.a=@a
				f.b=@b*other
			else
				f.a=@a*other.b
				f.b=@b*other.a
			end
			#minimizamos el resultado
			f.a,f.b = minimiza(f.a,f.b)
			return f
		end

		# ===begin
		#
		# Metodo Guerra de las Galaxias para la comparacion de fracciones
		#
		# ===end
		def <=>(other)
			self.to_f <=> other.to_f
		end

		def coerce(other)
		    [self,other]
		end

	end #class

	# ==begin
	#
	# Clase Fraccion: Contiene todas las funciones necesarias para obtener elementos
	#
	# ==end
	class Elemento

		# ===begin
		#
		# Metodo constructor de elementos dentro de un vector
		#
		# ===end
		def initialize(i,j,valor) 
			@i,@j,@value= i,j,valor
		end

		# ===begin
		#
		# Metodos Getters y Setters
		#
		# ===end
		attr_accessor :i,:j,:value
	end
	# == 
	# 	Clase Matriz dispersa la cual se encargara de almacenar solo los elementos no nulos
	# == 
	class Sparse < Matriz
		def initialize(*args)
			@n,@m=args[0],args[1]
			datos = args[2] 
			@A = Array.new()
			for i in 0...@n
				for j in 0...@m
					if 0!=datos[i][j]
						#puts datos[i][j]
						@A[i]=Elemento.new(i,j,datos[i][j])
						
					end	
				end
			end
      @min,@max=min_max()
		end
		# === begin
		# Funcion para imprimir matrices dispersas
		# === end
		def to_s
		salida=""
			for i in 0...@n
				salida+="["
					for j in 0...@m
						salida+=self.get(i,j).to_s    
					
					if j < @m-1
						salida+=", "
					end
					end
				salida+="]"
				end
			return salida	
		end
		# === begin
		# Funcion que devuelve el valor de la posicion dentro de la matriz dispersa
		# === end
		def get(k,l)
			devuelve=0
			for i in 0...@A.size
				##puts @A[i].valor
				if (@A[i].i==k) && (@A[i].j==l)
					return @A[i].value           
				end
			end
			devuelve
		end
		# === begin
		# Funcion para la suma de matrices dispersas
		# === end
	
		def  +(other)
			if other.instance_of? Sparse
				c= Matriz.new(@n,@m,Array.new(@n){Array.new(@m)})
        @n.times {|i|@m.times{|j|  c.A[i][j] = self.get(i,j)+other.get(i,j)}}
  			return Sparse.new(@n,@m,c)
			else
				c= Matriz.new(@n,@m,Array.new(@n){Array.new(@m)})
			   @n.times {|i|@m.times{|j|  c.A[i][j]=self.get(i,j)+other.A[i][j]}}			
			
				return c
			end
		end
		# === begin
		# Funcion para la resta de matrices densas
		# === end
		def -(other)
			if other.instance_of? Sparse
				c= Matriz.new(@n,@m,Array.new(@n){Array.new(@m)})
				for i in 0...@n
					for j in 0...@m
						c.A[i][j]=self.get(i,j)-other.get(i,j)   
					end
				end
				return Sparse.new(@n,@m,c)
			else
				c= Matriz.new(@n,@m,Array.new(@n){Array.new(@m)})
				for i in 0...@n
					for j in 0...@m
						c.A[i][j]=self.get(i,j)-other.A[i][j]
					end
				end
				return c
			end
		end

		# === begin
		# Funcion para la multiplicacion de matrices
		# === end

		def *(other)
			if other.instance_of? Sparse
			c= Matriz.new(@n,@m,Array.new(@n){Array.new(@m)})
			@n.times {|i|@m.times{|j|@n.times{|k| c.A[i][j] += self.get(i,k)*other.get(k,j) }  }}	
			
		else
			c= Matriz.new(@n,@m,Array.new(@n,0){Array.new(@m,0)})
			@n.times {|i|@m.times{|j|@n.times{|k| c.A[i][j] += self.get(i,k)*(other.A[k][j]) }  }}
			
		end
		return c
		end
		# === begin
		# Funcion para el calculo del minimo y maximo de un numero
		# === end
		def min_max
			min,max =@A[0].value,@A[0].value
			if nil==min
				return 0,0
      end
     if min >0 
		min=0
		end
      for i in  0...@A.size do
          if max< @A[i].value
               max=@A[i].value
            end
            if @A[i].value<min
                  min=@A[i].value

            end

       
      end
        return min, max


    end
	end#class
end #module	
	class MatrizDSL
        #Initialize, inicializa los valores a los que se les pase por parametro
        def initialize(operation = "", &block)
                @name= operation
                @MatrizClass = ""
                @salida = 0 
                @Matriz = []
                instance_eval &block
       end
       
       def operacion(opt)
             @name = opt
       end
       
       def opcion(opt)
               case opt
               when "densa"  
                       @MatrizClass = "densa"
               when "dispersa" 
                       @MatrizClass = "dispersa"
               when "consola"
                       @salida = 1
               when "matrix"
                       @salida = 0
               end               
       end
       
       def operando(fil1,fil2)
                   n = fil1.size
                   m = fil2.size
                   case @MatrizClass
                   when "densa" 
                            @Matriz << Matrizds::Matriz.new(n,m,[fil1,fil2])
                   when "dispersa" 
                        @Matriz << Matrizds::Sparse.new(n,m,[fil1,fil2])
                   end 
       end
       
       def run
                case @name
                   when "suma"
                               resultado = (@Matriz[0]+@Matriz[1]).to_s
                   when "multiplicacion"
                               resultado = (@Matriz[0]*@Matriz[1]).to_s
                    when "resta"
                    
                                resultado = (@Matriz[0]-@Matriz[1]).to_s
                   end

                if @salida == 1
                               mostrar(resultado)
                   else
                               return resultado
                   end                  
       end
       
       def mostrar(res)
                case @name
                   when "suma"
                               printf "A:\t%s\ + t%s == t%s", @Matriz[0].to_s, @Matriz[1].to_s, res
                   when "resta"
                              printf "A:\t%s\ - t%s == t%s", @Matriz[0].to_s, @Matriz[1].to_s, res
                              
                                         
                   when "multiplicacion"                
                               printf "A:\t%s\ *s t%s == t%s", @Matriz[0].to_s, @Matriz[1].to_s, res
                   end
        end
       
end #classs DSL

