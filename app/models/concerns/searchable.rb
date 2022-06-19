module Searchable
  extend ActiveSupport::Concern

  class_methods do
    def filter_by_dates(start_date_s, end_date_s)
      return all if start_date_s.nil? && end_date_s.nil?

      start_date = DateTime.parse(start_date_s)
      end_date = DateTime.parse(end_date_s)

      return all if start_date > end_date

      where(created_at: start_date..end_date)
    end
  end

end