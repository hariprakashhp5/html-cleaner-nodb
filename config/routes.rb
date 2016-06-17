Rails.application.routes.draw do

  root :to => 'cleaner#testcod'
  post 'cleaner/done' => 'cleaner#posttestcod'#, via:[:get, :post]
  post 'cleaner/raw'=>'cleaner#htmlraw'


  get '/collaps' => 'collapsible#getcollaps'
  post '/collaps' => 'collapsible#postcollaps'

  get '/trend-collaps' => 'collapsible#getcollapsv2'
  post '/trend-collaps' => 'collapsible#postcollapsv2'



   get 'news'=>'news#new'
   post '/news/generated'=>'news#news_gen'
  


end
