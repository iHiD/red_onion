Dummy::Application.routes.draw do
  
  get 'caching/basic' => 'caching#basic'  
  get 'caching/with_instance_variables' => 'caching#with_instance_variables'
  
end
