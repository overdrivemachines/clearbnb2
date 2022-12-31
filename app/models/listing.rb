# == Schema Information
#
# Table name: listings
#
#  id                :bigint           not null, primary key
#  title             :string           not null
#  about             :text
#  max_guests        :integer          default(2)
#  host_id           :bigint           not null
#  latitude          :string
#  longitude         :string
#  address_line1     :string
#  address_line2     :string
#  city              :string
#  state             :string
#  postal_code       :string
#  country           :string
#  status            :integer          default("draft")
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  price             :integer
#  nightly_price     :integer
#  cleaning_fee      :integer
#  stripe_product_id :string
#
class Listing < ApplicationRecord
  belongs_to :host, class_name: "User"
  has_many :rooms
  has_many :photos
  has_many :reservations

  after_commit :create_stripe_product, on: %i[create update]

  scope :published, -> { where(status: :published) }
  default_scope { order(title: :asc) }

  validates :title, presence: true
  validates :max_guests, numericality: { greater_than: 0, less_than_or_equal_to: 100 }
  validates :nightly_price, numericality: { greater_than: 0 }
  validates :cleaning_fee, numericality: { greater_than: 0 }
  enum status: { draft: 0, published: 1, archived: 2 }

  # Returns the full address in one line
  def address
    address_line2.blank? ? "#{address_line1} #{city}, #{state}" : "#{address_line1} #{address_line2} #{city}, #{state}"
  end

  def create_stripe_product
    # If the listing already has a stripe product id, update the Stripe Product's Name and Description
    if !stripe_product_id.blank?
      begin
        product = Stripe::Product.retrieve(stripe_product_id)
      rescue Stripe::InvalidRequestError => e
        # puts e.message
        # we will create a new stripe product below
      end

      # If the Stripe product exists, update the product's name and description
      if !product.blank?
        # https://stripe.com/docs/api/products/update?lang=ruby
        Stripe::Product.update(stripe_product_id, { name: title, description: about })
        # terminate method
        return
      end
    end

    # Create a new Stripe Product
    # https://stripe.com/docs/api/products/create

    product =
      Stripe::Product.create(
        {
          name: title, # required
          description: about,
          images: [],
          metadata: {
            clearbnb_id: id,
          },
          url: Rails.application.routes.url_helpers.full_url_for(self),
        },
      )

    # Save the Stripe Product ID to the DB
    self.update(stripe_product_id: product.id)
  end
end
