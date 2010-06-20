#AmidaMap

class AmidaCell
	attr_accessor :attr,:x,:y,:mark,:result
	def initialize(attr,x,y)
		#┃ down/  ━┫　left/  ┣━ right/  * end
		@attr = attr 
 		@x = x
		@y = y
		@mark=0
		@result=""
	end
	
	def getSign
		case @attr
		when :down
			return "┃"
		when :left
			return "┫"
		when :right
			return "┣"
		end
		return "?"
	end
end
	

class AmidaMaps
	
	def initialize(height,width)
		@height=height
		@width=width
		
		@map = Array.new
		for x in 1..@width
			for y in 1..@height
				@map.push(AmidaCell.new(:down,x,y))
			end
		end
		randmize
	end
	
	def setAtari(num)
		line = Array.new
		for n in 1..num.to_i
			line.push(n.to_s)
		end
		(@width-num.to_i).times{|n|
			line.push("x")
		}
		p line
		line = line.sort_by{rand}
		p line
		for x in 1..@width
			cell = AmidaCell.new(:end,x,@height+1)
			cell.result = line[x-1]
			p cell
			@map.push(cell)
		end
	end
	
	def calc(targetx,name)
		cell = getCell(targetx,1)
		cell.mark=1
		puts "======="+name+"さん抽選中！========="
		viewAll
		while cell.attr!=:end
			cell = getNextStep(cell)
			puts "======="+name+"さん抽選中！========="
			viewAll
		end
#		puts"*** X="+cell.x.to_s+" ***"
#		puts"*** result="+cell.result+" ***"		
#		sleep(1)
		return cell.result
	end


	def viewBody
		for x in 1..@width
			printf("%02d ",x)
		end
		puts""
		for y in 1..@height
			for x in 1..@width
				cell = getCell(x,y)
				if cell
					if(cell.mark==1)
						printf("■")
					else
						printf("%s",cell.getSign) 
					end
				end
				if(cell!=nil && cell.attr==:right)
					printf("━━")
				else
					printf("  ")
				end
			end
			printf("\n")
		end
	end
	
	def viewAll
		viewBody
		for x in 1..@width
			cell = getCell(x,@height+1)
			printf("%s ",cell.result.ljust(2))
		end
		puts""
		puts""
		
		sleep(0.2)
	end
	
	def view
		viewBody
		sleep(0.2) #***************************
	end

private
	#阿弥陀生成
	def randmize
		puts "randmize"
		for x in 1..@width
			num = rand(4)+3
			puts "x:"+x.to_s+" num:"+num.to_s
			for n in 1..num
				y = rand(@height)
				puts "add line:x:"+x.to_s+" y:"+y.to_s
				direction = rand(2)
				cell       = getCell(x,y)
				left_cell  = getCell(x-1,y)
				right_cell = getCell(x+1,y)
				#p left_cell
				#p right_cell
				direction = 1 if(x==1)
				
				if(direction==0) #left
					if(left_cell!=nil && cell.attr==:down && left_cell.attr==:down)
						#puts "  set left"
						cell.attr=:left
						left_cell.attr=:right
					else
					
					end
				else #right
					if(right_cell!=nil && cell.attr==:down && right_cell.attr==:down)
						puts "  set right"
						cell.attr=:right				
						right_cell.attr=:left
					else
						if(right_cell!=nil && cell.attr==:left)
							puts "  cancel left"
							cell.attr=:right				
							right_cell.attr=:left
							left_cell.attr=:down
						end

					end
				end
			end
		end
		view		
		
	end

	#セルを座標から選択
	def getCell(x,y)
#		puts "getCell x:"+x.to_s+" y:"+y.to_s
		@map.each{|cell|
			return cell if(cell.x == x && cell.y==y)
		}
		nil
	end
	
	#次のセルを選択
	def getNextStep(cell)
		case cell.attr
		when :down
			x = cell.x
			y = cell.y+1
		when :right
			x = cell.x+1
			y = cell.y+1
		when :left
			x = cell.x-1
			y = cell.y+1
		end
		cell.mark = 0
		retcell = getCell(x,y)
		return AmidaCell.new(:end,x,y) if(retcell==nil)

		retcell.mark = 1
		return retcell
	end
	
end

