# TODO 

`=cache` creates a CacheContext object that the view is rendered in.
`=cache` stores any locales that are called in the template.
`=cache` stores any assigns that are called in the template.
`=cache` stores any current_user methods that are called in the template?
`=cache` stores a list of any partials that are called.

## Database Tables

    create_table :cached_view do |t|
  
      t.string :name, null: false
  
    end

    create_table :cached_view_dependancies do |t|
  
      t.integer :cached_view_id, null: false
  
      t.string :object_type, null: false
      t.integer :object_id, null: false
  
    end

    create_table :cached_view_current_user_methods do |t|
  
      t.integer :cached_view_id, null: false
  
      t.string :user_method, null: false
      t.string :user_value, null: false
  
    end

## Examples

### Store instance variables
Should create:
CachedView {
    id: 1
    name: user_profile
    dependancies: [
        {object_type 'User', object_id:1}
    ]
}

Should store cache key as "user_profile"

    =cache "user_profile" do
      %h2= @user.name
  
### Store nested instance variables
Should create:
CachedView {
    id: 1
    name: user_profile
    dependancies: [
        {object_type 'User', object_id:1}
        {object_type 'Contribution', object_id:1}
        {object_type 'Contribution', object_id:2}
        {object_type 'Contribution', object_id:3}
        {object_type 'Contribution', object_id:4}
    ]
}

Should store cache key as "user_profile"

    =cache "user_profile" do
      %h2= @user.name
      =cache "user_contributions" do
          =render 'users/contributions', collection: @user.contributions
  
### Store nested views
Should create:
CachedView {
    id: 1
    name: user_contribution
    dependancies: [
        {object_type 'Contribution', object_id:1}
    ]
}
CachedView {
    id: 2
    name: user_contribution
    dependancies: [
        {object_type 'Contribution', object_id:2}
    ]
}
CachedView {
    id: 3
    name: user_contributions
    dependancies: [
        {object_type 'CachedView', object_id:1}
        {object_type 'CachedView', object_id:2}
        {object_type 'Contribution', object_id:1}
        {object_type 'Contribution', object_id:2}
    ]
}
CachedView {
    id: 4
    name: user_profile
    dependancies: [
        {object_type 'User', object_id:1}
        {object_type 'CachedView', object_id:4}
    ]
}

Should store cache key as "user_profile"

    / users/show.html.haml
    =cache "user_profile" do
      %h2= @user.name
      =cache "user_contributions" do
          =render 'users/contributions', collection: @user.contributions
      
    / users/_contribution.html.haml
    =cache "user_contribution" do
      %h3= contribtion.name
      %p= contribtion.description
      %p link_to= "View", contribtion

### Store current_user methods
Should create:
CachedView {
    id: 1
    name: user_profile
    dependancies: [
        {object_type 'User', object_id:1}
    ]
   current_user_methods: [
       {user_method: "is_admin?", user_value: true}
   ]
}

Should store cache key as "user_profile"

    =cache "user_profile" do
        -if current_user.is_admin?
            %h2= @user.name
        -else
            %h2= @user.first_name