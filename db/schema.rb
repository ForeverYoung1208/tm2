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

ActiveRecord::Schema.define(:version => 20190224210945) do

  create_table "aautos", :force => true do |t|
    t.string   "name"
    t.string   "autodesc"
    t.string   "autonumber"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "contact"
  end

  create_table "actions", :force => true do |t|
    t.string   "kind"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "aorders", :force => true do |t|
    t.string   "onname"
    t.time     "ftime"
    t.time     "totime"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "aauto_id"
    t.integer  "odate_id"
    t.string   "adestination"
    t.string   "ondepartment"
    t.string   "contact"
    t.boolean  "iscanceled"
    t.string   "comment"
    t.integer  "user_id"
    t.integer  "odobegin",      :default => 0
    t.integer  "odoend",        :default => 0
    t.integer  "outofcity",     :default => 0
    t.integer  "department_id"
  end

  create_table "callists", :force => true do |t|
    t.text     "data",        :limit => 16777215
    t.string   "filename"
    t.integer  "loadedby_id"
    t.boolean  "isparsed"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "callists", ["loadedby_id"], :name => "index_callists_on_loadedby_id"

  create_table "calls", :force => true do |t|
    t.string   "tel_number"
    t.string   "datetime"
    t.string   "calltype"
    t.string   "direction"
    t.integer  "dest_number"
    t.integer  "duration"
    t.decimal  "cost_bal",        :precision => 15, :scale => 2
    t.decimal  "cost_nodiscount", :precision => 15, :scale => 2
    t.integer  "user_id"
    t.integer  "callist_id"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  add_index "calls", ["user_id"], :name => "index_calls_on_user_id"

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.boolean  "istabelling"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.integer  "company_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "departments", ["company_id"], :name => "index_departments_on_company_id"

  create_table "odates", :force => true do |t|
    t.date     "thedate"
    t.boolean  "isclosed"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "was_used",   :default => false
  end

  create_table "onlineautos", :force => true do |t|
    t.integer  "aauto_id"
    t.integer  "odate_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "onduty"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "telnumbers", :force => true do |t|
    t.string   "tel_number"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "userlevels", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "password_hash"
    t.string   "password_salt"
    t.integer  "userlevel_id"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "company_id"
    t.boolean  "is_ip_controlled", :default => false
    t.string   "ip_address"
    t.datetime "deleted_at"
  end

end
