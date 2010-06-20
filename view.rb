require'common'

class AmidaView

	def initialize(obj)
		puts "initialize AmidaView"
		@controler = obj
	end

	def addMember(member)
		@controler.addMember(member)
	end
	
	def setAtari(num)
		@controler.setAtari(num)
	end
	
	def reset
	end

	def viewResult
		@controler.setMap
		puts "AddedNumber=" + @controler.getMemberNumber.to_s
		@controler.calc
	end

end
