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

ActiveRecord::Schema.define(version: 2020_04_03_102910) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "contentful_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contentful_id"], name: "index_categories_on_contentful_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "contentful_id"
    t.string "title"
    t.string "slug"
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contentful_id"], name: "index_pages_on_contentful_id", unique: true
    t.index ["slug"], name: "index_pages_on_slug", unique: true
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.text "description"
    t.string "contentful_id"
    t.string "thumb_image"
    t.bigint "category_id", null: false
    t.index ["category_id"], name: "index_posts_on_category_id"
    t.index ["contentful_id"], name: "index_posts_on_contentful_id", unique: true
    t.index ["slug"], name: "index_posts_on_slug", unique: true
  end

  create_table "posts_tags", id: false, force: :cascade do |t|
    t.bigint "post_id", null: false
    t.bigint "tag_id", null: false
    t.index ["post_id"], name: "index_posts_tags_on_post_id"
    t.index ["tag_id"], name: "index_posts_tags_on_tag_id"
  end

  create_table "syncs", force: :cascade do |t|
    t.string "content_type"
    t.string "sync_type"
    t.string "sync_token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "contentful_id"
    t.string "tag_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contentful_id"], name: "index_tags_on_contentful_id"
  end

  add_foreign_key "posts", "categories"
  add_foreign_key "posts_tags", "posts"
  add_foreign_key "posts_tags", "tags"
end
