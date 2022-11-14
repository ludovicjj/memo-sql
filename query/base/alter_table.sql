-- Remove column
ALTER TABLE post DROP category;

-- Add column
ALTER TABLE post ADD category VARCHAR(50);

-- Rename column
ALTER TABLE post RENAME category to tag;

-- Rename table
Alter TABLE post RENAME TO posts;