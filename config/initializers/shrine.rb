require "shrine"
#require "shrine/storage/file_system"
require "shrine/storage/s3"

s3_options = {
  bucket: "instagro-bucket", # required
  region: "eu-central-1", # required
  access_key_id: "AKIA2ONSB2OAYGTKSLNS",
  secret_access_key: "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",
}

Shrine.storages = {
  cache: Shrine::Storage::S3.new(prefix: "cache", **s3_options), # temporary
  store: Shrine::Storage::S3.new(**s3_options),                  # permanent
}

Shrine.plugin :activerecord           # loads Active Record integration
Shrine.plugin :cached_attachment_data # enables retaining cached file across form redisplays
Shrine.plugin :restore_cached_data    # extracts metadata for assigned cached files
Shrine.plugin :derivatives, create_on_promote: true
Shrine.plugin :validation_helpers
