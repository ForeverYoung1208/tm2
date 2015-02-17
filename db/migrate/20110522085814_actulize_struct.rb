class ActulizeStruct < ActiveRecord::Migration
  def self.up

    #убираем лишнее
    change_table :aorders do |t|
      t.remove :ondate
      t.remove :auto_id
    end
    #добавляем недостающее
    change_table :aorders do |t|
      t.string :adestination
      t.string :ondepartment
      t.string :contact
      t.boolean :iscanceled
      t.string :comment
    end

  end

  def self.down
    #восстанавливаем убранное
    change_table :aorders do |t|
      t.date :ondate
      t.integer :auto_id
    end

    #откатываем назад добавление
    change_table :aorders do |t|
      t.remove :adestination
      t.remove :ondepartment
      t.remove :contact
      t.remove :iscanceled
      t.remove :comment
    end
  end
end
