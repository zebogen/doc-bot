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

ActiveRecord::Schema.define(version: 20170513203124) do

  create_table "answers", force: :cascade do |t|
    t.integer "consultation_id"
    t.integer "question_id"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["consultation_id", "question_id"], name: "index_answers_on_consultation_id_and_question_id", unique: true
  end

  create_table "consultations", force: :cascade do |t|
    t.string "facebook_id", null: false
    t.integer "current_sequence_number", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "insurers", force: :cascade do |t|
    t.string "uid", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plans", force: :cascade do |t|
    t.integer "insurer_id", null: false
    t.string "uid", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["insurer_id"], name: "index_plans_on_insurer_id"
    t.index ["uid"], name: "index_plans_on_uid"
  end

  create_table "questions", force: :cascade do |t|
    t.string "slug", null: false
    t.string "text", null: false
    t.integer "sequence_number", null: false
    t.string "answer_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
