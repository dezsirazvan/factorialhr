# frozen_string_literal: true

class Metric::ObjectSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :value,
             :created_at
end
