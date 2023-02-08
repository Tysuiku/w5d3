require "sqlite3"
require "singleton"

class QuestionsDatabase < SQLite3::Database
  include Singleton

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

  def self.find_by_name(fname, lname)
    user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
    SELECT
        *
    FROM
        users
    WHERE
        fname = ? AND lname = ?;
    SQL
  end

  def self.find_by_id(id)
    user = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT 
        *
    FROM
        users
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
  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
    data.map { |datum| Questions.new(datum) }
  end

  def self.find_by_id(id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT 
        *
    FROM
        questions
    WHERE
        id = ?;
    SQL
  end

  def self.find_by_author_id(author_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, author_id)
    SELECT 
        title, body
    FROM
        questions
    WHERE
        author_id = ?;
    SQL
  end

  def initialize(option)
    @id = option["id"]
    @title = option["title"]
    @body = option["body"]
    @author_id = option["author_id"]
  end
end

class QuestionFollows
  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM QuestionFollows")
    data.map { |datum| QuestionFollows.new(datum) }
  end

  def self.find_by_id(id)
    question_follows = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT 
        *
    FROM
        question_follows
    WHERE
        id = ?;
    SQL
  end

  def initialize(option)
    @id = option["id"]
    @user_id = option["user_id"]
    @question_id = option["question_id"]
  end
end

class Replies
  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
    data.map { |datum| Replies.new(datum) }
  end

  def self.find_by_id(id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT 
        *
    FROM
        replies
    WHERE
        id = ?;
    SQL
  end

  def self.find_by_user_id(user_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT 
        body
    FROM
        replies
    WHERE
        user_id = ?;
    SQL
  end

  def self.find_by_question_id(question_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT 
        body
    FROM
        replies
    WHERE
        question_id = ?;
    SQL
  end

  def initialize(option)
    @id = option["id"]
    @question_id = option["question_id"]
    @parent_id = option["parent_id"]
    @user_id = option["user_id"]
    @body = option["body"]
  end
end

class QuestionLikes
  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
    data.map { |datum| QuestionLikes.new(datum) }
  end

  def self.find_by_id(id)
    user = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT 
        *
    FROM
        question_likes
    WHERE
        id = ?;
    SQL
  end

  def initialize(option)
    @id = option["id"]
    @user_id = option["user_id"]
    @question_id = option["question_id"]
  end
end
