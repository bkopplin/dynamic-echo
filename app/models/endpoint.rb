class Endpoint < ApplicationRecord

  validates :endpoint_type, presence: true
  validates :verb, presence: true, inclusion: { in: %w(GET POST PUT PATCH HEAD DELETE CONNECT OPTIONS TRACE), message: "must be a valid http method"}
  validates :path, presence: true
  validates :res_code, presence: true, inclusion: { in: [100, 101, 200, 201, 202, 203, 204, 205, 206, 300, 301, 302, 303, 304, 307, 308, 400, 401, 402, 403, 404, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 422, 426, 428, 429, 431, 451, 500, 501, 502, 503, 504, 505, 506, 507, 508, 510, 511],
              message: "is not included in the list or the code is invalid"}
  validates :res_headers, presence: false
  validates :res_body, presence: true


  def to_hash
    {
      "type" => endpoint_type,
      "id" => id,
      "attributes" => {
        "verb" => verb,
        "path" => path,
        "response" => {
          "code" => res_code,
          "headers" => res_headers,
          "body" => res_body
        }
      }
    }
  end
end
