module Api
  module V1
    module Patients
      class AnalyticsController < ApplicationController
        include FindSchedule

        def adherence
          render json: @schedule.adherence_stats
        end

        def injections_schedule
          render json: @schedule, serializer: InjectionsScheduleSerializer
        end
      end
    end
  end
end
