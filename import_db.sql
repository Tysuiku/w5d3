PRAGMA foreign_keys = ON;
CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);
CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    author_id INTEGER NOT NULL,
    FOREIGN KEY(author_id) REFERENCES users(id)
);
CREATE TABLE question_follows(
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(question_id) REFERENCES questions(id)
);
CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    parent_id INTEGER,
    user_id INTEGER NOT NULL,
    body TEXT NOT NULL,
    FOREIGN KEY(question_id) REFERENCES questions(id),
    FOREIGN KEY(parent_id) REFERENCES replies(id),
    FOREIGN KEY(user_id) REFERENCES users(id)
);
CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(question_id) REFERENCES questions(id)
);


INSERT INTO users(fname, lname)
VALUES ('TIM', 'DONG'),
       ('ZAHIN', 'BH');

INSERT INTO questions(title, body, author_id)
VALUES ('coding','we are having fun',(SELECT id FROM users WHERE fname = 'TIM')), 
('computers','need help with troubleshoot',(SELECT id FROM users WHERE lname = 'BH'));