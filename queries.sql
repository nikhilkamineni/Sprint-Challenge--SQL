/* CREATES TABLES */
CREATE TABLE organization (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL
);

CREATE TABLE channel (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL,
  org_id INTEGER REFERENCES organization(id)
);

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL
);

CREATE TABLE message (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  content VARCHAR(1024) NOT NULL,
  chan_id INTEGER REFERENCES channel(id),
  user_id INTEGER REFERENCES user(id),
  post_time DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE channel_user (
  channel_id INTEGER REFERENCES channel(id),
  user_id INTEGER REFERENCES user(id)
);


/* INSERT DATA */
INSERT INTO organization (name) VALUES ("Lambda School");

INSERT INTO user (name) VALUES ("Alice");
INSERT INTO user (name) VALUES ("Bob");
INSERT INTO user (name) VALUES ("Chris");

INSERT INTO channel (name, org_id) VALUES ("general", 1);
INSERT INTO channel (name, org_id) VALUES ("random", 1);

INSERT INTO message (content, chan_id, user_id) VALUES ("Test message 1 by Alice", 1, 1);
INSERT INTO message (content, chan_id, user_id) VALUES ("Test message 2 by Alice", 2, 1);
INSERT INTO message (content, chan_id, user_id) VALUES ("Test message 3 by Bob", 1, 2);
INSERT INTO message (content, chan_id, user_id) VALUES ("Test message 4 by Bob", 2, 2);
INSERT INTO message (content, chan_id, user_id) VALUES ("Test message 5 by Chris", 1, 3);
INSERT INTO message (content, chan_id, user_id) VALUES ("Test message 6 by Chris", 2, 3);
INSERT INTO message (content, chan_id, user_id) VALUES ("Test message 7 by Alice", 1, 1);
INSERT INTO message (content, chan_id, user_id) VALUES ("Test message 8 by Bob", 1, 2);
INSERT INTO message (content, chan_id, user_id) VALUES ("Test message 9 by Chris", 1, 3);
INSERT INTO message (content, chan_id, user_id) VALUES ("Test message 10 by Alice", 2, 1);

-- Alice subscribes to #general and #random
INSERT INTO channel_user (channel_id, user_id) VALUES (1, 1);
INSERT INTO channel_user (channel_id, user_id) VALUES (2, 1);

-- Bob subscribes to #general
INSERT INTO channel_user (channel_id, user_id) VALUES (1, 2);

-- Chris subscribes to #random
INSERT INTO channel_user (channel_id, user_id) VALUES (2, 3);


/* SELECT QUERIES */

-- 1. List all organization `name`s.
SELECT name FROM organization;

-- 2. List all channel `name`s.
SELECT name FROM channel;

-- 3. List all channels in a specific organization by organization `name`. */
SELECT channel.name FROM channel, organization 
WHERE channel.org_id = organization.id;

-- 4. List all messages in a specific channel by channel `name` `#general` in */
--    order of `post_time`, descending.
SELECT DISTINCT message.content, message.chan_id FROM message, channel
WHERE message.chan_id = (SELECT id FROM channel WHERE channel.name = 'general')
ORDER BY message.post_time;

-- 5. List all channels to which user `Alice` belongs. */
SELECT channel.name FROM channel, channel_user 
WHERE channel.id = channel_user.channel_id 
AND channel_user.user_id = (SELECT id FROM user WHERE user.name = 'Alice');

-- 6. List all users that belong to channel `#general`. */
-- 7. List all messages in all channels by user `Alice`. */
-- 8. List all messages in `#random` by user `Bob`. */
-- 9. List the count of messages across all channels per user. (Hint: */
