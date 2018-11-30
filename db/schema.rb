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

ActiveRecord::Schema.define(version: 2018_11_30_120121) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "carousels", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "texto1fto1"
    t.string "texto2fto1"
    t.string "texto1fto2"
    t.string "texto2fto2"
    t.string "texto1fto3"
    t.string "texto2fto3"
  end

  create_table "hot_sales", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "precio"
    t.date "fecha_hotsale"
    t.date "fecha_reserva"
    t.bigint "prop_id"
    t.index ["prop_id"], name: "index_hot_sales_on_prop_id"
  end

  create_table "props", force: :cascade do |t|
    t.string "nombre"
    t.string "ubicacion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "oculto"
    t.integer "precio"
  end

  create_table "pujas", force: :cascade do |t|
    t.integer "valor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "usuario_id"
    t.bigint "sub_id"
    t.index ["sub_id"], name: "index_pujas_on_sub_id"
    t.index ["usuario_id"], name: "index_pujas_on_usuario_id"
  end

  create_table "reservas", force: :cascade do |t|
    t.date "fecha"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "usuario_id"
    t.bigint "prop_id"
    t.boolean "normal"
    t.index ["prop_id"], name: "index_reservas_on_prop_id"
    t.index ["usuario_id"], name: "index_reservas_on_usuario_id"
  end

  create_table "solicitud_vips", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "usuario_id"
    t.string "estado"
    t.index ["usuario_id"], name: "index_solicitud_vips_on_usuario_id"
  end

  create_table "solivips", force: :cascade do |t|
    t.string "estado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "usuario_id"
    t.index ["usuario_id"], name: "index_solivips_on_usuario_id"
  end

  create_table "sub_fins", force: :cascade do |t|
    t.integer "valor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "usuario_id"
    t.bigint "reserva_id"
    t.index ["reserva_id"], name: "index_sub_fins_on_reserva_id"
    t.index ["usuario_id"], name: "index_sub_fins_on_usuario_id"
  end

  create_table "subs", force: :cascade do |t|
    t.date "fecha_inicio"
    t.date "fecha_fin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "prop_id"
    t.date "fecha_reserva"
    t.integer "precio_min"
    t.index ["prop_id"], name: "index_subs_on_prop_id"
  end

  create_table "usuarios", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "vip"
    t.string "tarjeta_numero"
    t.string "tarjeta_cvv"
    t.integer "tarjeta_mes"
    t.integer "tarjeta_ano"
    t.date "fecha_nac"
    t.string "nombre"
    t.string "apellido"
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
  end

  add_foreign_key "hot_sales", "props"
  add_foreign_key "pujas", "subs"
  add_foreign_key "pujas", "usuarios"
  add_foreign_key "reservas", "props"
  add_foreign_key "reservas", "usuarios"
  add_foreign_key "solicitud_vips", "usuarios"
  add_foreign_key "solivips", "usuarios"
  add_foreign_key "sub_fins", "reservas"
  add_foreign_key "sub_fins", "usuarios"
  add_foreign_key "subs", "props"
end
