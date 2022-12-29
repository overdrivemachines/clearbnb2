# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  full_name              :string
#  uid                    :string
#  provider               :string
#  avatar_url             :string
#  stripe_customer_id     :string
#
class User < ApplicationRecord
  has_many :listings, foreign_key: :host_id
  has_many :reservations, foreign_key: :guest_id

  after_commit :create_stripe_customer, on: %i[create update]

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :confirmable,
         :lockable,
         :timeoutable,
         :trackable,
         :omniauthable,
         omniauth_providers: [:google_oauth2]

  # Find or create a user based on data from 'auth'
  # This method is called from omniauth_callbacks_controller.rb
  # 'auth' is set to request.env['omniauth.auth']
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.full_name = auth.info.name # assuming user model has a name
      user.avatar_url = auth.info.image # assuming user model has an image
      user.skip_confirmation!
    end
  end

  private

  def create_stripe_customer
    # if the user already has a stripe customer id, return
    return unless stripe_customer_id.blank?

    # Verify that the customer doesn’t already exist
    # Stripe::Customer.list({email: '{EMAIL_ADDRESS}'})

    # Create a new strip customer
    # https://stripe.com/docs/api/customers/create?lang=ruby
    customer =
      Stripe::Customer.create(
        {
          email: email,
          name: full_name,
          curency: "usd",
          livemode: false, # object exists in test mode only
          metadata: {
            clearbnb_id: self.id,
          },
        },
      )

    self.update(stripe_customer_id: customer.id)
  end
end
