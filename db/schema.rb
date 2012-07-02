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

ActiveRecord::Schema.define(:version => 20120625224712) do

  create_table "friendships", :force => true do |t|
    t.integer  "user_id",                       :null => false
    t.integer  "friend_id",                     :null => false
    t.boolean  "confirmed",  :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "locations", :force => true do |t|
    t.string  "title",                                       :null => false
    t.integer "user_id",                                     :null => false
    t.string  "description",                                 :null => false
    t.string  "status",                                      :null => false
    t.decimal "lat",         :precision => 15, :scale => 10, :null => false
    t.decimal "long",        :precision => 15, :scale => 10, :null => false
  end

  create_table "posts", :force => true do |t|
    t.string   "title",       :null => false
    t.string   "description", :null => false
    t.integer  "thred_id",    :null => false
    t.integer  "user_id",     :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "storages", :force => true do |t|
    t.integer  "user_id",           :null => false
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.string   "title",             :null => false
    t.string   "description",       :null => false
  end

  create_table "threds", :force => true do |t|
    t.string   "title",       :null => false
    t.string   "description", :null => false
    t.integer  "topic_id",    :null => false
    t.integer  "user_id",     :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "timelines", :force => true do |t|
    t.string   "title",             :null => false
    t.string   "description",       :null => false
    t.date     "date",              :null => false
    t.integer  "user_id",           :null => false
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "topics", :force => true do |t|
    t.string   "title",       :null => false
    t.string   "description", :null => false
    t.integer  "user_id",     :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "user_sessions", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name",                                               :null => false
    t.integer  "rank",                :default => 0,                 :null => false
    t.string   "persistence_token",                                  :null => false
    t.string   "crypted_password",                                   :null => false
    t.string   "password_salt",                                      :null => false
    t.string   "single_access_token",                                :null => false
    t.string   "perishable_token",                                   :null => false
    t.integer  "login_count",         :default => 0,                 :null => false
    t.integer  "failed_login_count",  :default => 0,                 :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
    t.string   "email",                                              :null => false
    t.string   "status",              :default => "Inactive"
    t.string   "surname",                                            :null => false
    t.string   "alias"
    t.string   "aboutme"
    t.time     "birthday"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "font",                :default => "Times New Roman"
    t.string   "color",               :default => "White"
    t.integer  "size",                :default => 16
  end

end
