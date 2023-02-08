require "sqlite3"
require "singleton"

class QuestionsDatabase < SQLite3::Database
  include singleton

  def initialize
    super("questions.db")
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Users
  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM users")
    data.map { |datum| Users.new(datum) }
  end

  def self.find_by_id(id)
    user = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT 
        *
    FROM
        Users
    WHERE
        id = ?;
    SQL
  end

  def initialize(option)
    @id = option["id"]
    @fname = option["fname"]
    @lname = option["lname"]
  end
end

class Questions
  def initialize(option)
    @id = option["id"]
    @title = option["title"]
    @body = option["body"]
    @author_id = option["author_id"]
  end
end

class QuestionFollows
  def initialize(option)
    @id = option["id"]
    @user_id = option["user_id"]
    @question_id = option["question_id"]
  end
end

class Replies
  def initialize(option)
    @id = option["id"]
    @question_id = option["question_id"]
    @parent_id = option["parent_id"]
    @user_id = option["user_id"]
    @body = option["body"]
  end
end

class QuestionLikes
  def initialize(option)
    @id = option["id"]
    @user_id = option["user_id"]
    @question_id = option["question_id"]
  end
end
