CREATE TABLE Admins (
  id INT IDENTITY(1,1) PRIMARY KEY,
  username NVARCHAR(100) NOT NULL,
  password NVARCHAR(255) NOT NULL
);
-- Insert a sample admin (password: admin123, hash with bcryptjs)
-- INSERT INTO Admins (username, password) VALUES ('admin', '$2a$10$7QwQwQwQwQwQwQwQwQwQwOeQwQwQwQwQwQwQwQwQwQwQwQwQwQwQwQwQwQwQwQwQw');
