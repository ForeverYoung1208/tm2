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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_02_24_210945) do

  create_table "aautos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "autodesc"
    t.string "autonumber"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "contact"
  end

  create_table "actions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "kind"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_actions_on_user_id"
  end

  create_table "aorders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "onname"
    t.time "ftime"
    t.time "totime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "aauto_id"
    t.bigint "odate_id"
    t.string "adestination"
    t.string "ondepartment"
    t.string "contact"
    t.boolean "iscanceled"
    t.string "comment"
    t.bigint "user_id"
    t.integer "odobegin", default: 0
    t.integer "odoend", default: 0
    t.integer "outofcity", default: 0
    t.bigint "department_id"
    t.index ["aauto_id"], name: "index_aorders_on_aauto_id"
    t.index ["department_id"], name: "index_aorders_on_department_id"
    t.index ["odate_id"], name: "index_aorders_on_odate_id"
    t.index ["user_id"], name: "index_aorders_on_user_id"
  end

  create_table "companies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.boolean "istabelling"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "departments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_departments_on_company_id"
  end

  create_table "odates", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "thedate"
    t.boolean "isclosed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "was_used", default: false
  end

  create_table "onlineautos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "aauto_id"
    t.bigint "odate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "onduty"
    t.index ["aauto_id"], name: "index_onlineautos_on_aauto_id"
    t.index ["odate_id"], name: "index_onlineautos_on_odate_id"
  end

  create_table "sessions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id"
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "userlevels", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password_hash"
    t.string "password_salt"
    t.bigint "userlevel_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.boolean "is_ip_controlled", default: false
    t.string "ip_address"
    t.datetime "deleted_at"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["userlevel_id"], name: "index_users_on_userlevel_id"
  end

end
