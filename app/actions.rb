helpers do

  def show_user_id
      "<p>Posted by <b>#{@song.user.username}</b> at:</p>" if @song.user
  end

  def show_play_link
    if @song.url.length > 1
    "<a target = '_blank' href='#{@song.url}'><span class='glyphicon glyphicon-play'></span></a>" 
    end
  end

  def show_user_status
    if session[:user_id]
      "<a href=#{uri('/user/logout')}>Logout</a>"
    else
      "<a href=#{uri('/user/login')}>Login</a>"
    end
  end

  def show_upvote_button(song_id)
    if session[:user_id]
      "<a href='/songs/#{song_id}/upvote' class='btn btn-upvote'><span class='glyphicon glyphicon-arrow-up'></span></a>"
    end
  end

end

# Homepage (Root path)
get '/' do
  erb :index
end

get '/songs' do
  @songs = Song.all
  erb :'songs/index'
end

get '/songs/new' do
  @song = Song.new
  erb :'songs/new'
end

get '/songs/:id' do
  @song = Song.find params[:id]
  erb :'songs/show'
end

get '/user/signup' do
  @user = User.new
  erb :'user/signup'
end

get '/user/logout' do
  session[:user_id] = nil
  redirect '/'
end

get '/user/login' do
  erb :'user/login'
end

post '/songs' do
  @song = Song.new(
    title: params[:title],
    author: params[:author],
    url:  params[:url],
    user_id: session[:user_id]
  )
  if @song.save
    redirect '/songs'
  else
    erb :'songs/new'
  end
end

post '/user/signup' do
  @user = User.new(
    username: params[:username],
    email: params[:email],
    password:  params[:password]
  )
  if @user.save
    session[:user_id] = @user.id
    redirect '/songs'
  else
    erb :'user/signup'
  end
end

post '/user/login' do
  @users = User.where("username IN (?) AND password IN (?)", params[:username], params[:password])
  unless @users.nil?
    @users.each do |user|
      session[:user_id] = user.id 
      redirect '/songs'
    end
  else
    redirect '/'
  end
  
end

get '/songs/:id/upvote' do
  
  @user = User.find session[:user_id]
  @song = Song.find params[:id]

  @song.upvotes += 1
  
  @song.save
  
  redirect '/songs'
end





