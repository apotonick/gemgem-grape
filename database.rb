require "active_record"

class Post::Persistence < ActiveRecord::Base
end

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => ":memory:"
)

ActiveRecord::Schema.define do
  create_table :artists do |table|
    table.column :title,    :text
    table.column :content,  :text
    table.column :url_slug, :string
    table.timestamps
  end

end
