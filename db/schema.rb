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

ActiveRecord::Schema.define(:version => 20120113202221) do

  create_table "posts", :force => true do |t|
    t.string   "title",       :null => false
    t.string   "description", :null => false
    t.integer  "thred_id",    :null => false
    t.integer  "owner_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "storages", :force => true do |t|
    t.integer  "user_id",           :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.integer  "owner_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", :force => true do |t|
    t.string   "title",       :null => false
    t.string   "description", :null => false
    t.integer  "owner_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name",                              :null => false
    t.string   "digest",                            :null => false
    t.string   "salt",                              :null => false
    t.integer  "rank",               :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                             :null => false
    t.string   "status",                            :null => false
    t.string   "surname",                           :null => false
    t.string   "alias"
    t.string   "aboutme"
    t.time     "birthday"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

end
