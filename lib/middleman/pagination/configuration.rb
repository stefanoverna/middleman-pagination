module Middleman
  module Pagination
    class Configuration
      include Enumerable

      def initialize
        @pageable = {}
      end

      def pageable_set(name, template_path, per_page = 15, symbolic_path_replacement = nil, &block)
        @pageable[name] = Pageable.new(
          name,
          template_path,
          per_page,
          symbolic_path_replacement,
          &block
        )
      end

      def each(&block)
        @pageable.each do |name, pageable_obj|
          yield pageable_obj
        end
      end

    end
  end
end
