# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120319184359) do

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "user_id"
    t.string   "EDRPOY"
    t.float    "state_share"
    t.integer  "state_share_count"
    t.string   "SF"
    t.integer  "region"
    t.integer  "management"
    t.string   "governing_body"
    t.string   "in_the_management"
    t.string   "type_of_business_entity"
    t.boolean  "bankruptcy"
    t.string   "form_of_shares"
    t.string   "strategist"
    t.string   "address"
    t.float    "nominal_value_of_shares"
    t.float    "nominal_value_of_all_shares"
    t.string   "EDRPOY2"
    t.string   "KVED"
    t.string   "mailbox_index"
  end

  create_table "lines", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.integer  "parent_id"
    t.string   "type"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "total",      :default => false
    t.string   "sign",       :default => "plus"
  end

  create_table "reports", :force => true do |t|
    t.integer  "company_id"
    t.date     "period"
    t.string   "type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "name",                   :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "values", :force => true do |t|
    t.integer  "report_id"
    t.integer  "line_id"
    t.float    "value1",     :default => 0.0
    t.float    "value2",     :default => 0.0
    t.float    "value3",     :default => 0.0
    t.float    "value4",     :default => 0.0
    t.float    "value5",     :default => 0.0
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

end
