class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :wins
end

#serializers define how your model should be returned from the server
#we want to send back user_id and name from this network request
