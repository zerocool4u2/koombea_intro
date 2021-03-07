# Copyright (c) 2020 Alexis Ramis.
# All Rights Reserved

module Devise
  module Models
    module Timeoutable
      # Checks whether the user session has expired based on configured time.
      def timedout?(last_access)
        return false if remember_exists_and_not_expired?
        last_access && last_access <= self.class.timeout_in.ago
      end

      private

      def remember_exists_and_not_expired?
        return false unless respond_to?(:remember_expired?)
        remember_created_at && !remember_expired?
      end
    end
  end
end
