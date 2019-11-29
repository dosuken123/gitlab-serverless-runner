Jets.application.routes.draw do
  resources :runners
  get "runners/:id/job_request", to: "runners#job_request", as: 'job_request_runner'
  root "runners#index"

  # The jets/public#show controller can serve static utf8 content out of the public folder.
  # Note, as part of the deploy process Jets uploads files in the public folder to s3
  # and serves them out of s3 directly. S3 is well suited to serve static assets.
  # More info here: https://rubyonjets.com/docs/extras/assets-serving/
  any "*catchall", to: "jets/public#show"
end
