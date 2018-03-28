class LandmarksController < ApplicationController

  get '/landmarks/new' do
    erb :'/landmarks/new'
  end

  get '/landmarks' do
    @landmarks = landmark.all
    erb :'/landmarks/index'
  end

  post '/landmarks' do
    @landmark = landmark.create(params[:landmark])

    @landmark.titles.create(params[:title]) unless params[:title][:name].empty?
    @landmark.landmarks.create(params[:landmark]) unless params[:landmark][:name].empty?
    @landmark.save

    redirect "landmarks/#{@landmark.id}"
  end

  get '/landmarks/:id' do
    @landmark = landmark.find_by_id(params[:id])
    erb :'landmarks/show'
  end

  get '/landmarks/:id/edit' do
    @landmark = landmark.find_by_id(params[:id])
    erb :'/landmarks/edit'
  end

  patch '/landmarks/:id' do

    @landmark = landmark.find_by_id(params[:id])
    @landmark.update(params[:landmark])

    if !params[:title][:name].empty?
      @landmark.titles << Title.create(name: params[:title][:name])
    end
    if !params[:landmark][:name].empty?
      @landmark.landmarks << Landmark.create(name: params[:landmark][:name])
    end
    @landmark.save
    redirect "landmarks/#{@landmark.id}"
  end


end
