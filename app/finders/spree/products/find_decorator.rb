module Spree
  module Products
    module FindDecorator
      def initialize(scope:, params:, current_currency: nil)
        @params = params
        super
      end

      # override by_id to inject by_product_type
      def by_ids(products)
        products = super(products)
        by_product_type(products)
      end

      def by_product_type(products)
        product_type = @params.dig(:filter, :product_type)
        return products if product_type.blank?

        # assume it is a number
        if product_type.to_i != 0
          products.where(product_type_id: product_type)
        else
          type = Spree::ProductType.find_by!(name: product_type)
          products.where(product_type_id: type.id)
        end
      end
    end
  end
end

Spree::Products::Find.prepend(Spree::Products::FindDecorator)
