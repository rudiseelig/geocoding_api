# Geocoding API

This is a small API-only Rails application that geocodes a location string of
your liking into latitude and longitude coordinates.

### Ruby version
`2.5.1`

### Rails version
`5.2.0`

### System dependencies
To run this application locally, you need to have:
 * PostgreSQL database
 * Redis (on port 6379)

### Configuration
First of all, run `bundle install` to install all dependencies

Before you can setup your database, you need to have a postgres role with the name `geocoding_api`
(Information on how to set that up: https://www.digitalocean.com/community/tutorials/how-to-setup-ruby-on-rails-with-postgres)

Then, to create and initialize the database, run `bundle exec rails db:setup'

Finally, this application the rails credentials "feature" that came with Rails 5.2.0.

To have access to the credentials, include a `master.key` file under the
`config/` folder or set an ENV variable `RAILS_MASTER_KEY` to
`8d1310cf81aca77cbb0fae9c7ad975aa`
(NOTE: I normally wouldn't expose the master key in source control. For simplicity sake, I included it here now.)

### How to run the test suite
After you have created your database, run `bundle exec rails db:test:prepare`
`bundle exec rspec`

### How to use this API
This API is user protected from outside access, so before you can access any resource create a new User locally:

`bundle exec rails console`
`User.create(email: 'TEST@EXAMPLE.COM', password: 'YOUR_SECRET_PASSWORD')`

After that, make a `POST` request with your user credentials to `/api/v1/auth` to get your access token.
All following requests have to be made with the following Request Headers:

`{ 'Authorization' : 'Bearer TOKEN' }`

### Design Choices

#### User Authentication and Commands

After reading up on how to secure your Rails API, I stumbled upon this article:
https://paweljw.github.io/2017/07/rails-5.1-api-app-part-4-authentication-and-authorization/

All of my User Authentication is based on this "tutorial", with only small changes.

I went for this approach for several reasons:

1. I didn't want to use a full blown authentication gem, like devise or
   doorkeeper for this app, because it felt too overkill for this use case.
2. I wanted to know, what happens under the hood of the User authentication.
   Instead of having a black box (if I would have gone for the gem approach) I
   want to be in control of what happens exactly. It also helped me to learn a
   great deal about commonly used user authentication flows.
3. I really like the Command Pattern, that the author used in his article. It
   avoids hard-wired requests to other Services (internal or external) and
   decouples the classes/modules from the invoker.

#### Location Domain Objects

I chose not to persist Location objects in the database. Instead, I modeled
them into Domain Objects, that only know about their values and nothing else. I
could have persisted them in the database, to cache some responses from the
Geocoding API, but the improvements in speed and performance you would get from
this seemed too insignificant to me.
