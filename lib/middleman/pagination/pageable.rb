module Middleman
  module Pagination
    class Pageable

      attr_reader :name, :template_path, :per_page, :symbolic_path_replacement

      def initialize(name, template_path, per_page, symbolic_path_replacement, &block)
        @name = name
        @template_path = template_path
        @per_page = per_page
        @symbolic_path_replacement = symbolic_path_replacement
        @set = block
      end

      def new_resources(extension_context, resources)
        pagination_indexes(extension_context, resources).map do |resource|
          new_pages_for_index(extension_context, resource, resources)
        end.compact
      end

      private

      def set(extension_context, resources)
        OpenStruct.new(resources: resources, data: extension_context.data).instance_eval(&@set)
      end

      def pagination_indexes(extension_context, resources)
        resource = extension_context.sitemap.find_resource_by_path(template_path)
        if resource
          return [resource]
        else
          return []
        end
      end

      def new_pages_for_index(extension_context, index, resources)
        pageable_context = PageableContext.new(
          per_page: per_page,
          set: set(extension_context, resources),
          index_resources: [index]
        )

        add_pagination_to(index, pageable_context: pageable_context, page_num: 1)

        (2..pageable_context.total_page_num).map do |page_num|
          new_index = IndexPage.new(extension_context,
                                    index,
                                    pageable_context,
                                    page_num,
                                    symbolic_path_replacement,
                                    index.metadata[:locals]).resource

          pageable_context.index_resources << new_index

          new_index
        end
      end

      def add_pagination_to(resource, attributes = {})
        in_page_context = InPageContext.new(attributes)
        resource.add_metadata(locals: { 'pagination' => in_page_context })
      end
    end
  end
end
