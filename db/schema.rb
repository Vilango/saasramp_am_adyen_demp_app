# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100914143040) do

  create_table "subscription_plans", :force => true do |t|
    t.string   "name",                      :null => false
    t.integer  "rate_cents", :default => 0
    t.integer  "interval",   :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscription_profiles", :force => true do |t|
    t.integer  "subscription_id"
    t.string   "state"
    t.string   "profile_key"
    t.string   "card_first_name"
    t.string   "card_last_name"
    t.string   "card_type"
    t.string   "card_display_number"
    t.date     "card_expires_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscription_transactions", :force => true do |t|
    t.integer  "subscription_id", :null => false
    t.integer  "amount_cents"
    t.boolean  "success"
    t.string   "reference"
    t.string   "message"
    t.string   "action"
    t.text     "params"
    t.boolean  "test"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "subscriber_id",                  :null => false
    t.string   "subscriber_type",                :null => false
    t.integer  "plan_id"
    t.string   "state"
    t.date     "next_renewal_on"
    t.integer  "warning_level"
    t.integer  "balance_cents",   :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscriptions", ["next_renewal_on"], :name => "index_subscriptions_on_next_renewal_on"
  add_index "subscriptions", ["state"], :name => "index_subscriptions_on_state"
  add_index "subscriptions", ["subscriber_id"], :name => "index_subscriptions_on_subscriber_id"
  add_index "subscriptions", ["subscriber_type"], :name => "index_subscriptions_on_subscriber_type"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
