SET max_parallel_maintenance_workers = 7;
SET maintenance_work_mem = '2GB';

CREATE INDEX idx_jsonb_hashtags ON tweets_jsonb
USING gin((data->'entities'->'hashtags') jsonb_path_ops);

CREATE INDEX idx_jsonb_extended_hashtags ON tweets_jsonb
USING gin((data->'extended_tweet'->'entities'->'hashtags') jsonb_path_ops);

CREATE INDEX idx_jsonb_lang ON tweets_jsonb((data->>'lang'));

CREATE INDEX idx_jsonb_text_gin ON tweets_jsonb
USING gin(to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text', data->>'text')));

CREATE INDEX idx_jsonb_id ON tweets_jsonb((data->>'id'));
