# frozen_string_literal: true

class GroupMetricsService
  attr_reader :metrics, :average_type

  def initialize(metrics, average_type)
    @metrics = metrics
    @average_type = average_type
  end

  def group
    @metrics = case @average_type
               when 'minute'
                 group_by_minute
               when 'second'
                 group_by_second
               else
                 group_by_day
               end

    @metrics
  rescue StandardError => error
    Rails.logger(error)
    nil
  end

  private

    def group_by_day
      @metrics.group_by_day(&:created_at)
    end

    def group_by_minute
      @metrics.group_by_minute(&:created_at)
    end

    def group_by_second
      @metrics.group_by_second(&:created_at)
    end
end
