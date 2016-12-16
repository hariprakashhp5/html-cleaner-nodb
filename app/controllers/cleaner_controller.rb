class CleanerController < ApplicationController

def testcod
 @current_url=request.original_url
end

def test
end


def htmraw

end

def posttestcod

puts "vvvv=====#{params[:accept]}"


#######################----BB-FILTERS----######################
if params[:accept] == "1"
  filterone={"<li>\n<p>" =>'<li>',"</p>\n</li>" => '</li>','<br>' => ''}
else
  filterone={"<li>\n<p>" =>'<li>', "</p>\n</li>" => '</li>', "<td>\n<p>" => '<td>', "</p>\n</td>" => '</td>', '<br>' => ''}
end
      
  filtertwo={'<p> </p>' => '','<p> </p>' => '','<p></p>' => '','<ul>' => "\n<ul>",'</ul>' => "</ul>\n", '</ol>' => "</ol>\n",
           '<table>' => "\n"'<table class="table table-curved">', '<u><a href='=>'<a href=', '</a></u>'=>'</a>',
           '<br>' => '','<p></p>' => '', ' rel="nofollow"' => '', "https://www.bankbazaar.com"=>"", "http://www.bankbazaar.com"=>"", 
           '<h2><strong>'=>'<h2>','</strong></h2>'=>'</h2>','<h1><strong>'=>'<h1>', '</strong></h1>'=>'</h1>',
           '<h3><strong>'=>'<h3>','</strong></h3>'=>'</h3>', '<h4><strong>'=>'<h4>', '</strong></h4>'=>'</h4>'}
#############################################################

    #####################----MAIN HTML CONVERSION CODE----######################  
      # c=params[:content]
      #  bundle_out=Sanitize.fragment(c,Sanitize::Config.merge(Sanitize::Config::BASIC,
      #  :elements=> Sanitize::Config::BASIC[:elements]+['table', 'tbody', 'tr', 'td', 'h1', 'h2', 'h3', 'h4'],
      #  :attributes=>{'td' => ['colspan', 'rowspan']}))

      c=params[:content]
       bundle_out=Sanitize.fragment(c,Sanitize::Config.merge(Sanitize::Config::BASIC,
       :elements=> ['a','blockquote','p','em','u','ul','ol','li','pre','strong', 'table', 'tbody', 'tr', 'td', 'h1', 'h2', 'h3', 'h4'],
       :attributes=>{'td' => ['colspan', 'rowspan']}))
    ############################################################################


####################----BB FORMATING IS HAPPENING THROUGH BELOW CODES----#########################
      re = Regexp.new(filterone.keys.map { |x| Regexp.escape(x) }.join('|')) 
      inter=bundle_out.gsub(re, filterone) #bb format is being done here
      doc=Nokogiri::HTML.fragment(inter) #to take care of mismatched open and close tags
      fltrd1=doc.inner_html
      fltrd2=fltrd1.gsub(/<(\w+)(?:\s+\w+="[^"]+(?:"\$[^"]+"[^"]+)?")*>\s*<\/\1>/,"")#to remove empty HTML tags
      rex= Regexp.new(filtertwo.keys.map { |x| Regexp.escape(x) }.join('|')) 
      fltrd3=fltrd2.gsub(rex, filtertwo) #FINAL OUTPUT
        @final=Nokogiri::HTML.parse(fltrd3)
        # if params[:accept] !="1"
        #   # final=Nokogiri::HTML.parse(fltrd3)
        #     @final.xpath("//table/tbody/tr/td/p").each do |content|
        #       content.replace(content.inner_html)
        #     end
        #     lastfilter={'<html>'=>'','</html>'=>'','<body>'=>'', '</body>'=>''}
        #     rexy= Regexp.new(lastfilter.keys.map { |x| Regexp.escape(x) }.join('|')) 
        #     htmlcontent=@final.inner_html.gsub(rexy,lastfilter)
        #   @bundle_out=htmlcontent
        # else
        #   #@bundle_out=fltrd3
        #   @bundle_out=@final
        # end

        if params[:accept] !="1"
          # final=Nokogiri::HTML.parse(fltrd3)
            @final.xpath("//table/tbody/tr/td/p").each do |content|
              content.replace(content.inner_html)
            end
        end

        lastfilter={'<html>'=>'','</html>'=>'','<body>'=>'', '</body>'=>'','&amp;'=>'&','&lt;'=>'<','&gt;'=>'>', '₹' => '&#8377;'}
            rexy= Regexp.new(lastfilter.keys.map { |x| Regexp.escape(x) }.join('|')) 
            htmlcontent=@final.inner_html.gsub(rexy,lastfilter)


          @bundle_out=htmlcontent
      
##################################################################################################

####################----TAG COUNT----#####################
      open_tags= @bundle_out.scan(/<\w/).count
      puts "biui====#{open_tags}"
      close_tags= @bundle_out.scan(/<\/\w/).count

      if open_tags.to_f == close_tags.to_f
        @tags=["Open and close tags are equal"]
        @class="alert-success-cleaner"
      else
        @p=@bundle_out.scan(/<p/).count
        @cp=@bundle_out.scan(/<\/p/).count
        @li=@bundle_out.scan(/<li/).count
        @cli=@bundle_out.scan(/<\/li/).count
        @ul=@bundle_out.scan(/<ul/).count
        @cul=@bundle_out.scan(/<\/ul/).count
        @ol=@bundle_out.scan(/<ol/).count
        @col=@bundle_out.scan(/<\/ol/).count
        @tab=@bundle_out.scan(/<table/).count
        @ctab=@bundle_out.scan(/<\/table/).count
        @tr=@bundle_out.scan(/<tr/).count
        @ctr=@bundle_out.scan(/<\/tr/).count
        @td=@bundle_out.scan(/<td/).count
        @ctd=@bundle_out.scan(/<\/td/).count

        arr=[[@li,@cli,'li'],[@ul,@cul,'ul'],[@ol,@col,'ol'],[@p,@cp,'p'],[@tab,@ctab,'table'],[@tr,@ctr,'tr'],[@td,@ctd,'td']]
        bar=[] #initializing empty array to appand the results
        for i in 0..arr.count-1
        if arr[i][0] != arr[i][1]
        var=arr[i][2]+"="+arr[i][0].to_s+"|"+arr[i][1].to_s
        @error=bar<<var
      else
        @error=["** Open and close tags are not equal **"]
        end
        end
        @tags=@error #FINAL O/P FOR TAG COUNT
        @class="alert-danger-cleaner"
        end
###########################################################
end


end
