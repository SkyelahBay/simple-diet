Rails.application.routes.draw do
  
  #logging in and out                                                                       #done
  post '/login',                to: 'sessions#create'                                       #done 
  delete '/logout',             to: 'sessions#destroy'                                      #done

  #registering a new user & dealing with their account
  post '/users',                to: 'users#create'                                           #done
  get '/edit_profile',          to: 'users#edit'                                             #done
  put '/edit_profile',          to: 'users#update'                                           #done
  patch '/edit_profile',        to: 'users#update'                                           #done
  delete '/delete_profile',     to: 'users#destroy'                                          #done

  #creating a new fitness goal & editing it. destroy functionaliy purposefully left off      #done
  post '/fitness_goal/create',  to: 'fitness_goals#create'                                   #done
  get '/fitness_goal/edit',     to: 'fitness_goals#edit'                                     #done
  put '/fitness_goal/edit',     to: 'fitness_goals#update'                                   #done
  patch '/fitness_goal/edit',   to: 'fitness_goals#update'                                   #done


  # See the current user's fitness_goal data and add new fitness events
  get '/dash',                  to: 'dash#index'                                             #done

  post '/fitness_events',       to: 'fitness_events#create'                                  #done                                     
  get'/fitness_events',         to: 'fitness_events#index'                                   #done
  put '/fitness_events/:id',    to: 'fitness_events#update'                                  #done                                                
  patch '/fitness_events/:id',  to: 'fitness_events#update'                                  #done              
end
