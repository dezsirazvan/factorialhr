# frozen_string_literal: true

class Metric::ListSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :value,
             :created_at
end
