class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # == Class helpers
  # plural names
  def self.pluralize
    model_name.human count: 2
  end

  def pluralize
    self.class.pluralize
  end

  # singular names
  def self.singularize
    model_name.human
  end

  def singularize
    self.class.singularize
  end

  # get attribute name from any instance
  def self.attribute_name(attribute, options = {})
    human_attribute_name attribute, options
  end

  def attribute_name(attribute, options = {})
    self.class.attribute_name attribute, options
  end

  def next
    if self.respond_to? :faena_id
      self.class.where(faena_id: self.faena_id)
    else
      self.class
    end
    .where('id > ?', id).order(:id).first
  end

  def prev
    if self.respond_to? :faena_id
      self.class.where(faena_id: self.faena_id)
    else
      self.class
    end
    .where('id < ?', id).order(:id).last
  end
end
