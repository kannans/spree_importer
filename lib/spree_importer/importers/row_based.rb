module SpreeImporter
  module Importers
    module RowBased
      extend ActiveSupport::Concern

      module ClassMethods
        def import_attributes(*args)
          define_method :import_attributes do
            args
          end
        end

        def target(klass)
          define_method :target do
            klass
          end
        end

        def row_based?
          true
        end
      end

      def each_instance(headers, csv)
        instances = [ ]
        csv.each do |row|
          i = target.new do |instance|
            import_attributes.each do |attr|
              instance.send "#{attr}=", val(headers, row, attr)
            end
          end
          instances << i
          yield i, row
        end
        instances
      end
    end
  end
end
