require "matrizds/version"

# =begin
#
# Modulo que contiene las clases de las matrices con sus respectivas funciones
#
# =end
module Matrizds
# Your code goes here...

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

	class Fraccion

	include Comparable
	def  initialize (a,b)
	c = gcd(a,b)
	@a = (a/c)
	@b = (b/c)

	end 
	attr_accessor :a,:b

	def to_s
	"#{@a}/#{@b}"
	end

	def to_f 
	c = @a.to_f/@b.to_f
	c
	end

	
	def abs
	c = @a.to_f/@b.to_f
	return c.abs
	end

	def reciprocal
	f=Fraccion.new(1,1)
	f.a=@b
	f.b = @a
	f
	end
	def -@
	Fraccion.new(-@a,@b)
	end
	def minimiza(x,y)
	d = gcd(x,y)
	x = x/d
	y = y/d
	return x,y
	end

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
	def gcd(u, v)
	u, v = u.abs, v.abs
	while v != 0
	u, v = v, u % v
	end
	u
	end
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
	def <=>(other)
	self.to_f <=> other.to_f
	end 
	 def coerce(other)
            [self,other]
        end

	end #class

	class Elemento
		def initialize(i,j,valor) 
			@i,@j,@value= i,j,valor
		end
		attr_accessor :i,:j,:value
	end

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
	end
end #module
