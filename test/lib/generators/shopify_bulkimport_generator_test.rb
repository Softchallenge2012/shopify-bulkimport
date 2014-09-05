require 'test_helper'
require 'generators/shopify_bulkimport/shopify_bulkimport_generator'

class ShopifyBulkimportGeneratorTest < Rails::Generators::TestCase
  tests ShopifyBulkimportGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
