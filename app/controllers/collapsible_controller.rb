class CollapsibleController < ApplicationController


######## Grid Collaps ##############
def getcollaps
	detectURL
end

def postcollaps
detectURL
@column1=[]		
@column2=[]
@column3=[]


collapsarray=[params[:collaps1],params[:collaps2],params[:collaps3],params[:collaps4],params[:collaps5],
				params[:collaps6],params[:collaps7],params[:collaps8],params[:collaps9],params[:collaps10],
				params[:collaps11],params[:collaps12],params[:collaps13],params[:collaps14],params[:collaps15]]

collapsarray.each_with_index do |links,index|

	if links != ""

		hc=links.split(";")
		heading=hc.first.scan(/head:(?:\s*)(\w.+)/).first.first.split(" ").join(" ")
		cname=heading.split(" ").join("")

		@structure='<div class="panel panel-default">
					<div class="panel-heading">
					<strong class="panel-title"> <a href="#'+cname+'" data-parent="#accordion" data-toggle="collapse" class="accordion-toggle collapsed"> 
					<span class="fui-plus"></span>'+heading+'</a> </strong>
					</div><div class="panel-collapse collapse" id="'+cname+'" style="height: 0px;"><div class="panel-body">
					<ul>'+
					hc.last+
					'</ul></div></div></div>'

		if [0,3,6,9,12].any?{|i| index == i} then @column1 << @structure end
		if [1,4,7,10,13].any?{|i| index == i} then @column2 << @structure end
		if [2,5,8,11,14].any?{|i| index == i} then @column3 << @structure end
	end
end
end

########## Trend Collaps #########
def getcollapsv2
	detectURL
end

def postcollapsv2
	detectURL
	time=Time.now
	@href='"#'+time.strftime("%d%h%y%H%M%S")+'"'
	@id='"'+time.strftime("%d%h%y%H%M%S")+'"'
		
	if params[:strong] == "1" && params[:h3] == nil
		@tag = "strong"
	elsif params[:h3] == "1" && params[:strong] == nil
		@tag = "h3" 
	elsif params[:strong] == nil &&  params[:h3] == nil
		@tag = "h2"
	elsif params[:strong] == "1" &&  params[:h3] == "1"
		@tag = "h2"
	end
	@newcollaps = params[:newcollaps]
	@heading = params[:trend_head]
	@content = params[:trend]
end




end
