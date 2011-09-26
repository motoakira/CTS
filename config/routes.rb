ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.photo 'CTS/photo/:id',
	:controller => "article",
	:action => "photo"

  map.article 'CTS/article',
	:controller => "article",
	:action => "article_out"
#"./article.cgi?cueto=#{node.id}"
  map.cueto 'CTS/article/:cueto',
	:controller => "article",
	:action => "article_out"

  map.buttons 'CTS/buttons',
	:controller => "button",
	:action => "buttons_out"
	
  map.post_form 'CTS/post_form',
	:controller => "post_form",
	:action => "post_form"
		
  map.threads 'CTS/threads',
	:conditions => { :method => :get },
	:controller => "thread",
	:action => "threads_out"

  map.rcv_post 'CTS/threads',
	:conditions => { :method => :post },
	:controller => "thread",
	:action => "rcv_post"
  
  map.del_post 'CTS/del_post',
	:conditions => { :method => :post },
	:controller => "cts",
	:action => "del_post"

  map.help_browse 'CTS/help_browse',
	:controller => "cts",
	:action => "help_browse"
  map.help_post 'CTS/help_post',
	:controller => "cts",
	:action => "help_post"
  map.rules 'CTS/rules',
	:controller => "cts",
	:action => "rules"

  map.admin_change_passwd 'CTS/admin/delete_posting',
	:controller => 'admin',
	:action => 'delete_posting'
  map.admin_change_passwd 'CTS/admin/change_passwd',
	:controller => 'admin',
	:action => 'change_passwd'
  map.admin_list_postings 'CTS/admin/list_postings',
	:controller => 'admin',
	:action => 'list_postings'
  map.admin_logout 'CTS/admin/logout',
	:controller => 'admin',
	:action => 'logout'
  map.admin_login 'CTS/admin/login',
	:controller => 'admin',
	:action => 'login'
  map.admin_index 'CTS/admin/index',
	:controller => 'admin',
	:action => 'index'
  map.admin_else 'CTS/admin/*any',
	:controller => 'admin',
	:action => 'index'


  map.cts 'CTS',
	:conditions => { :method => :get },
	:controller => "cts",
	:action => "cts"
  map.no_support 'CTS/*any',
	:conditions => { :method => :get },
	:controller => "cts",
	:action => "index"

#  map.catch_all '*any', :controller => "cts"
end
