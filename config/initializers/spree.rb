Rails.application.config.after_initialize do
  Spree.config do |config|
    config[:max_level_in_taxons_menu] = 2
  end
end