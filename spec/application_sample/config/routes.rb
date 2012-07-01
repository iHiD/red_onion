Dummy::Application.routes.draw do
  
  get 'caching/basic' => 'caching#basic'  
  get 'caching/with_instance_variables' => 'caching#with_instance_variables'
  get 'caching/with_nested_view' => 'caching#with_nested_view'
  
  
end
