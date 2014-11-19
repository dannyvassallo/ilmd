module Csvable

  def self.included(base)
    base.send(:extend, ClassMethods)
  end

  module ClassMethods
    def as_csv(array_of_instances)
      CSV.generate do |csv|
        csv << csv_column_names.map { |name| name.split("__").last }
        array_of_instances.each do |item|
          csv << item.as_csv
        end
      end
    end

    def csv_column_names
      self::CSV_COLUMN_NAMES
    end
  end

  def as_csv
    self.class.csv_column_names.map do |column_name|
      split = column_name.split("__")
      column = split.pop
      assoc = split.first

      record = assoc.nil? ? self : send(assoc)

      record.send(column)
    end
  end

end
