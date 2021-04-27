
        # creating objects 
        # persisting objects to the database(record)
        # create a table specifically for this class
        # return all records of a table 
        # find a record the table 
class Tweet 
        attr_accessor :user, :content, :id

     def initialize(attr_hash = {})
        attr_hash.each do |key, value|
                self.send("#{key}=", value) if respond_to?("#{key}=")
        end
     end
        
        def self.create_table 
        sql = <<-SQL
        CREATE TABLE IF NOT EXISTS tweets (
                id INTEGER PRIMARY KEY,
                user TEXT,
                content TEXT
        )
        SQL
        DB[:conn].execute(sql)
     end

     def save 
        if self.id 
                self.update
        else
        sql = <<-SQL 
        INSERT INTO tweets (user, content) VALUES (?, ?);
        SQL
        DB[:conn].execute(sql, self.user, self.content)
        @id = DB[:conn].execute("SELECT last_insert_rowid() FROM tweets")[0][0]
        # binding.pry
        end
        self
     end

     def self.create(record)
        Tweet.new(record).save
     end

     def self.all 
        sql = <<-SQL 
        SELECT * FROM tweets;
        SQL
       records = DB[:conn].execute(sql)
       records.map do |record| 
        Tweet.new(record)
       end
     end

     def self.find(id)
        sql = <<-SQL 
         SELECT * FROM tweets WHERE id < ?
        SQL
      records = DB[:conn].execute(sql, id)
        #  binding.pry 
         records.map do |record|
        Tweet.new(record)
         end
     end

     def update
        sql = <<-SQL
        UPDATE tweets SET user = ?, content = ? WHERE id = ?;
        SQL
        DB[:conn].execute(sql, self.user, self.content, self.id )
        self 
     end
     
     def self.delete_table 
        sql = <<-SQL 
        DROP TABLE tweets;
        SQL
        DB[:conn].execute(sql)
     end

     def delete 
        sql = <<-SQL
         DELETE FROM tweets WHERE id = ? 
        SQL
        DB[:conn].execute(sql, self.id)
     end
end