class FiguresController < ApplicationController

  get '/figures/new' do
    @figures = Figure.all
    erb :'/figures/new'
  end


end
