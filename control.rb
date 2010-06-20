require 'common'
require 'map'


class AmidaControl
	
	def initialize
		@members = AmidaMemberList.new
		puts "initialize AmidaControl"
		
		@map
	end
	
	def addMember(person)
		@members.add(person)
	end
	
	def setAtari(num)
		@atari=num
	end
	
	def getMemberNumber
		@members.number
	end
	
	def getMember(n)
		@members.getFromNo(n)
	end
	
	def setMap
		@map = AmidaMaps.new(15,getMemberNumber)
		@map.setAtari(@atari)
	end
	
	def calc
		
		file = open("result_log.txt","w")

		for n in 1..getMemberNumber
			result = @map.calc(n,getMember(n).name)
			if(result=="x")
				puts "*** "+getMember(n).name+"さん：はずれ ***"
				file.puts "*** "+getMember(n).name+"さん：はずれ "
			else
				puts "*** "+getMember(n).name+"さん：あたり "+result.to_s+"番目の発表です ***"
				file.puts "*** "+getMember(n).name+"さん：あたり "+result.to_s+"番目の発表です"
			end
			sleep(5)
			#$stdin.gets
		end
		file.close

		@map.viewAll
	end
	
end
