class PatientSerializer < ActiveModel::Serializer
  attributes :id, :name, :api_key

  # has_many :injections
end
