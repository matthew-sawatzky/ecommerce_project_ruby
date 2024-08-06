# Use an official Ruby runtime as a parent image
FROM ruby:3.3.0-bullseye

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs yarn git libvips pkg-config

# Set the working directory in the container
WORKDIR /ecommerce_project

# Install gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 4 --retry 5

# Copy the main application
COPY . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

# Precompile assets for production
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# Add a non-root user for running the application
RUN useradd -m rails
USER rails

# Expose port 3000 to the outside world
EXPOSE 3000

# The entry point script to run migrations and start the server
COPY ./entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Start the Rails server
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
