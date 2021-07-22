# frozen_string_literal: true

class Api::V1::MetricsController < ApplicationController
  include Api::V1::MetricsControllerDoc

  before_action :find_metric, except: [:index, :create, :timeline]

  def index
    @metrics = Metric.all

    render json: @metrics, each_serializer: Metric::ObjectSerializer, status: :ok
  end

  def create
    @metric = Metric.new(metric_params)

    @metric.save!

    render json: @metric, serializer: Metric::ObjectSerializer, status: :created
  end

  def show
    render json: @metric, serializer: Metric::ObjectSerializer, status: :ok
  end

  def update
    @metric.update!(metric_params)

    render json: @metric, serializer: Metric::ObjectSerializer, status: :ok
  end

  def destroy
    @metric.destroy!

    render json: { message: 'Metric was successfully deleted.' }, status: :ok
  end

  def timeline
    @metrics = Metric.all

    result = TimelineCalculatorService.new.calculate(@metrics, params[:average_type])

    render json: result, status: :ok
  end

  private

    def metric_params
      params.require(:metric).permit(:id, :name, :value)
    end

    def find_metric
      @metric = Metric.find(params[:id])
    end
end
