# json.array! @user, partial: 'user', as: :user

json.uid @user.uid
json.first_name @user.first_name
json.last_name @user.last_name
json.email @user.email
json.token @user.token
json.refresh_token @user.refresh_token
json.image_url @user.image_url