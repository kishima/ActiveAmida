require 'control'
require 'view'
require 'common'
require 'yaml'
require 'pp'

#control
control = AmidaControl.new

#view
viewer = AmidaView.new(control)

#set data
puts"set data"
str  = ARGF.read()      # 入力をすべて読み込む
data = YAML.load(str)   # パースする
data.each{|d|
	puts d
	member = AmidaMember.new
	member.name = d
	viewer.addMember(member)
}

#get
puts"当たり数は？"
atari = $stdin.gets
viewer.setAtari(atari)

#start
puts"start"
viewer.viewResult

puts"end"