module Api::V1::MetricsControllerDoc
  extend Apipie::DSL::Concern

  api :GET, '/metrics', 'Get all the metrics'
  def index
  end

  api :GET, '/metrics/:id', 'Get metric by id'
  param 'id', Integer, required: true
  def show
  end

  api :POST, '/metrics/', 'Create a new metric'
  param :metric, Hash, required: true do
    param :name, String, required: true
    param :value, String, required: true
  end
  def create
  end

  api :PUT, '/metrics/:id', 'Update a metric'
  param 'id', Integer, required: true
  param :metric, Hash, required: true do
    param :name, String, required: true
    param :value, String, required: true
  end
  def update
  end

  api :DELETE, '/metrics/:id', 'Delete a metric'
  param 'id', Integer, required: true
  def destroy
  end

  api :GET, '/metrics/timeline', 'Get metrics timeline and average values'
  param :average_type, String, optional: true
  def timeline
  end
end
