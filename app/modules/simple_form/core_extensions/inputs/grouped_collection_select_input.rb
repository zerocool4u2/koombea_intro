# Copyright (c) 2020 Alexis Ramis.
# All Rights Reserved

module SimpleForm
  module CoreExtensions
    module Inputs
      # # Alternative grouped_select
      # #### A more readable and pleasant definition of grouped_selects on simple_form
      # Allows to pass a group_by symbol to be use in a grouped_collection
      #
      #   = f.association :instrument, as: :grouped_select, collection: Instruments.all, group_by: :type
      #   # instead of
      #   = f.association :instrument, as: :grouped_select, collection: Instruments.all.group_by(&:type), group_method: :last, group_label_method: :first
      module GroupedCollectionSelectInput
        def input(wrapper_options)
          group_by = options.delete(:group_by)

          if group_by
            grouped_collection = options[:collection].group_by(&group_by)

            options[:collection] = grouped_collection
            options[:group_method] = :last
            options[:group_label_method] = :first
          end
          super
        end
      end
    end
  end
end
SimpleForm::Inputs::GroupedCollectionSelectInput.prepend SimpleForm::CoreExtensions::Inputs::GroupedCollectionSelectInput
