class InjectionSerializer < ActiveModel::Serializer
  attributes :id, :drug_name, :dose, :lot_number, :injected_at
end
