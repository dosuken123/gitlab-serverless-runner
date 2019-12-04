# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_04_000239) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "runner_jobs", force: :cascade do |t|
    t.bigint "runner_id"
    t.bigint "job_id"
    t.string "token"
    t.integer "status", limit: 2, null: false
    t.jsonb "specification", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["runner_id"], name: "index_runner_jobs_on_runner_id"
  end

  create_table "runners", force: :cascade do |t|
    t.string "token", null: false
    t.string "description"
    t.string "tags"
    t.integer "runtime", limit: 2, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "url"
  end

  add_foreign_key "runner_jobs", "runners", on_delete: :cascade
end
