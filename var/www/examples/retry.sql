WITH retry_request AS (
    SELECT
        request_tracker.method,
        request_tracker.url,
        request_tracker.params,
        request_tracker.body,
        request_tracker.headers,
        request_tracker.request_id
    FROM request_tracker
    INNER JOIN net._http_response ON net._http_response.id = request_tracker.request_id
    WHERE net._http_response.status_code >= 500
    LIMIT 3
),
retry AS (
    SELECT
        request_wrapper(retry_request.method, retry_request.url, retry_request.params, retry_request.body, retry_request.headers)
    FROM retry_request
),
delete_http_response AS (
    DELETE FROM net._http_response
    WHERE id IN (SELECT request_id FROM retry_request)
    RETURNING *
)
DELETE FROM request_tracker
WHERE request_id IN (SELECT request_id FROM retry_request)
RETURNING *;
