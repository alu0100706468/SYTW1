# -*- coding: utf-8 -*-
require 'twitter'
require 'sinatra'
require './configure'

	get '/' do
		@n_amigos = 0 
		@name = '' 
		@pic = ''
		@usuarios = Hash.new
		erb :twitter
	end

	post '/' do
		@n_amigos = 0
		@usuarios = Hash.new
		@name = params[:firstname] || ''
		client = my_twitter_client()


		#Si el usuario introducido es de Twitter:
		if client.user? @name

			#usr = usuario introducido por pantalla
			usr = client.user(@name) 

			#pic = url de la imagen de perfil
			@pic = usr.profile_image_url
			
			#n_amigos = numero de amigos de usr
			@n_amigos = usr.friends_count 
			
			#Almacena en "amigos" los últimos 10 amigos del usuario
			amigos = client.friend_ids(@name).attrs[:ids].take(10) 

			#Si tiene  menos de 10 amigos, el bucle será de n_amigos
			if (@n_amigos < 10)
				@n_amigos.times do |i|
						user_n = client.user(amigos[i])
						@usuarios[user_n.screen_name.to_s] = user_n.followers_count.to_i
				end
			end


			#Si tiene  más de o 10 amigos, el bucle será 10
			if (@n_amigos >= 10)
				10.times do |i|
						user_n = client.user(amigos[i])
						@usuarios[user_n.screen_name.to_s] = user_n.followers_count.to_i
				end
			end

			@usuarios = @usuarios.sort_by {|user,followers| -followers} #ordena los amigos de mayor a menor segun sus seguidores
		end
		erb :twitter
	end	


