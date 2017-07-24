class NewsController < ApplicationController

	def index
		detectURL
	end

	def new
	detectURL
	end
	# 
	def news_gen
		tag=params[:h3]
		if tag == "1"
			@tag = "h3"
		else
			@tag = "h2"
		end
		imgUrl = params[:imgurl]
		puts "**********************************"
		puts imgUrl
		if imgUrl == "1"
			@imageUrl = "/images/bb-insurance-v1.png"
		else
			@imageUrl ="/images/common/bb-logo-180-40.png"
		end
		puts @imageUrl
		@page=params[:page]
		puts @page
		@newsad=params[:newsad]
		puts @newsad
		@newsT=params[:newsT]
		puts @newsT
		@newsH=params[:newsH]
		puts @newsH
		@newsD=params[:newsD]
		puts @newsD
		c=params[:content]
       bundle_out=Sanitize.fragment(c,Sanitize::Config.merge(Sanitize::Config::BASIC,
       :elements=> ['a','blockquote','p','em','ul','ol','li','pre','strong', 'table', 'tbody', 'tr', 'td', 'h1', 'h2', 'h3', 'h4'],
       :attributes=>{'td' => ['colspan', 'rowspan']}))
     	  filter={'<p> </p>'=>'',' rel="nofollow"' => '', "https://www.bankbazaar.com"=>"", "http://www.bankbazaar.com"=>"", '<br>'=>''}
     	  re = Regexp.new(filter.keys.map { |x| Regexp.escape(x) }.join('|')) 
      fill=bundle_out.gsub(re, filter)
      puts "fill====#{fill}"
        @newsC=fill.gsub(/<(\w+)>\s*<\/\1>/,"")
       puts @newsC
	end

end
