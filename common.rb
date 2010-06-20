class AmidaMember
	attr_accessor :name, :description 
	
	def initialize
		@name = nil
		@description = nil
	end

end

class AmidaMemberList
	attr_reader :number

	def initialize
		@list = Array.new
		@number = 0
	end
	
	def add(person)
		@list.push(person)
		@number += 1
	end
	
	def getFromNo(n)
		@list[n-1]
	end
	
end
