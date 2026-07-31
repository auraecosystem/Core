CREATE OR REPLACE FUNCTION request_wrapper(
    method TEXT,
    url TEXT,
    params JSONB DEFAULT '{}'::JSONB,
    body JSONB DEFAULT '{}'::JSONB,
    headers JSONB DEFAULT '{}'::JSONB
)
RETURNS BIGINT
AS $$
DECLARE
    request_id BIGINT;
BEGIN

    IF method = 'DELETE' THEN
        SELECT net.http_delete(
            url:=url,
            params:=params,
            headers:=headers
        ) INTO request_id;
    ELSIF method = 'POST' THEN
        SELECT net.http_post(
            url:=url,
            body:=body,
            params:=params,
            headers:=headers
        ) INTO request_id;
    ELSIF method = 'GET' THEN
        SELECT net.http_get(
            url:=url,
            params:=params,
            headers:=headers
        ) INTO request_id;
    ELSE
        RAISE EXCEPTION 'Method must be DELETE, POST, or GET';
    END IF;

    INSERT INTO request_tracker (method, url, params, body, headers, request_id)
    VALUES (method, url, params, body, headers, request_id);

    RETURN request_id;
END;
$$
LANGUAGE plpgsql;
