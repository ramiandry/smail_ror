# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_11_28_065246) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "emails", force: :cascade do |t|
    t.string "objet"
    t.text "corps"
    t.datetime "date_envoi", default: -> { "CURRENT_TIMESTAMP" }
    t.boolean "est_lu", default: false
    t.boolean "est_archiver", default: false
    t.boolean "est_spam", default: false
    t.integer "expediteur_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "est_favoris", default: false
    t.date "date_suppr"
    t.index ["expediteur_id"], name: "index_emails_on_expediteur_id"
  end

  create_table "piece_jointes", force: :cascade do |t|
    t.string "nom_fichier"
    t.integer "taille_fichier"
    t.string "type_fichier"
    t.integer "email_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_id"], name: "index_piece_jointes_on_email_id"
  end

  create_table "receptions", force: :cascade do |t|
    t.integer "utilisateur_id", null: false
    t.integer "email_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date_suppr"
    t.integer "transfert_id"
    t.index ["email_id"], name: "index_receptions_on_email_id"
    t.index ["transfert_id"], name: "index_receptions_on_transfert_id"
    t.index ["utilisateur_id"], name: "index_receptions_on_utilisateur_id"
  end

  create_table "utilisateurs", force: :cascade do |t|
    t.string "nom"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "prenom"
    t.string "avatar"
    t.string "tel"
    t.boolean "sexe"
    t.date "date_naissance"
    t.string "adresse"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "emails", "utilisateurs", column: "expediteur_id"
  add_foreign_key "piece_jointes", "emails"
  add_foreign_key "receptions", "emails"
  add_foreign_key "receptions", "utilisateurs"
  add_foreign_key "receptions", "utilisateurs", column: "transfert_id"
end
