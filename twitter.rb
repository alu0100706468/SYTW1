# -*- coding: utf-8 -*-
require 'twitter'
require 'sinatra'
require './configure'

	get '/' do
		@n_amigos = 0 # numero de amigos
		@name = '' #nombre de usuario twitter
		@pic = ''
		@usuarios = Hash.new	#almacenara los amigos y el numero de seguidores
		erb :twitter
	end

	post '/' do
		@n_amigos = 0
		@usuarios = Hash.new
		@name = params[:firstname] || '' #recoge del parametro firstname el nombre de usuario
		client = my_twitter_client() #establece conexion twitter


		#Si el usuario introducido es de Twitter:
		if client.user? @name

			usr = client.user(@name) #usr = usuario introducido por pantalla
			@pic = usr.profile_image_url()
			@n_amigos = usr.friends_count #n_amigos = numero de amigos de usr
			amigos = client.friend_ids(@name).attrs[:ids].take(10) #Almacena en "amigos" los últimos 10 amigos del usuario

			if (@n_amigos < 10)
				@n_amigos.times do |i|
						user_n = client.user(amigos[i])
						@usuarios[user_n.screen_name.to_s] = user_n.followers_count.to_i
				end
			end

			if (@n_amigos >= 10)
				10.times do |i|
						user_n = client.user(amigos[i])
						@usuarios[user_n.screen_name.to_s] = user_n.followers_count.to_i
				end
			end

			@usuarios = @usuarios.sort_by {|k,v| -v} #ordena los amigos de mayor a menor segun sus seguidores
		end

		erb :twitter
	end	


