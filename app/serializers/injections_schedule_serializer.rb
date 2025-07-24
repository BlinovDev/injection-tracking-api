class InjectionsScheduleSerializer < ActiveModel::Serializer
  attributes :drug_name, :interval_in_days, :starts_on, :injections

  def injections
    ActiveModelSerializers::SerializableResource.new(object.injections, each_serializer: InjectionSerializer)
  end
end
