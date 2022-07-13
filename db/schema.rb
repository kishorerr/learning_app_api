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

ActiveRecord::Schema[7.0].define(version: 27) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_enum :content_type, [
    "video",
    "pdf",
  ], force: :cascade

  create_enum :opt_type, [
    "correct",
    "wrong",
  ], force: :cascade

  create_enum :status_type, [
    "not_started",
    "started",
    "completed",
  ], force: :cascade

  create_table "attempts", force: :cascade do |t|
    t.integer "score"
    t.datetime "attempted_at"
    t.datetime "finished_at"
    t.bigint "exercise_id", null: false
    t.bigint "student_enroll_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_attempts_on_exercise_id"
    t.index ["student_enroll_id"], name: "index_attempts_on_student_enroll_id"
  end

  create_table "boards", force: :cascade do |t|
    t.string "b_name"
    t.string "b_desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chapters", force: :cascade do |t|
    t.string "c_name"
    t.integer "pdf_no"
    t.integer "video_no"
    t.bigint "subject_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_chapters_on_subject_id"
  end

  create_table "contents", force: :cascade do |t|
    t.enum "content", enum_type: "content_type"
    t.string "link"
    t.bigint "chapter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chapter_id"], name: "index_contents_on_chapter_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.string "title"
    t.integer "duration"
    t.integer "qn_no"
    t.integer "attempts_no", default: 0
    t.integer "high_score"
    t.string "instructions"
    t.bigint "chapter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chapter_id"], name: "index_exercises_on_chapter_id"
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer "resource_owner_id"
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "options", force: :cascade do |t|
    t.string "option_name"
    t.string "option"
    t.enum "opt_status", enum_type: "opt_type"
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_options_on_question_id"
  end

  create_table "qn_responses", force: :cascade do |t|
    t.string "selected_option"
    t.boolean "marked_for_review", default: false
    t.integer "score", default: 0
    t.bigint "question_id", null: false
    t.bigint "attempt_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attempt_id"], name: "index_qn_responses_on_attempt_id"
    t.index ["question_id"], name: "index_qn_responses_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.integer "qn_no"
    t.string "question"
    t.datetime "duration"
    t.string "solution"
    t.bigint "exercise_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_questions_on_exercise_id"
  end

  create_table "s_classes", force: :cascade do |t|
    t.integer "class_no"
    t.bigint "board_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_s_classes_on_board_id"
  end

  create_table "student_enrolls", force: :cascade do |t|
    t.integer "otp"
    t.datetime "otp_generated_at", precision: nil
    t.bigint "student_id"
    t.bigint "board_id"
    t.bigint "s_class_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_student_enrolls_on_board_id"
    t.index ["s_class_id"], name: "index_student_enrolls_on_s_class_id"
    t.index ["student_id"], name: "index_student_enrolls_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "auth_token"
    t.string "ph_no"
    t.date "dob"
    t.index ["email"], name: "index_students_on_email", unique: true
    t.index ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true
  end

  create_table "subjects", force: :cascade do |t|
    t.string "s_name"
    t.binary "s_logo"
    t.bigint "s_class_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["s_class_id"], name: "index_subjects_on_s_class_id"
  end

  create_table "user_contents", force: :cascade do |t|
    t.boolean "upvote"
    t.boolean "downvote"
    t.string "notes"
    t.bigint "content_id", null: false
    t.bigint "student_enroll_id", null: false
    t.enum "status", enum_type: "status_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_id"], name: "index_user_contents_on_content_id"
    t.index ["student_enroll_id"], name: "index_user_contents_on_student_enroll_id"
  end

  add_foreign_key "attempts", "exercises"
  add_foreign_key "attempts", "student_enrolls"
  add_foreign_key "chapters", "subjects"
  add_foreign_key "contents", "chapters"
  add_foreign_key "exercises", "chapters"
  add_foreign_key "options", "questions"
  add_foreign_key "qn_responses", "attempts"
  add_foreign_key "qn_responses", "questions"
  add_foreign_key "questions", "exercises"
  add_foreign_key "s_classes", "boards"
  add_foreign_key "student_enrolls", "boards"
  add_foreign_key "student_enrolls", "s_classes"
  add_foreign_key "student_enrolls", "students"
  add_foreign_key "subjects", "s_classes"
  add_foreign_key "user_contents", "contents"
  add_foreign_key "user_contents", "student_enrolls"
end
