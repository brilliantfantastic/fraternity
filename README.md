Fraternity
==========

[ ![Codeship Status for brilliantfantastic/fraternity](https://codeship.com/projects/3fe0d950-80a4-0132-9038-321707412590/status?branch=master)](https://codeship.com/projects/57522)
[![Coverage Status](https://coveralls.io/repos/brilliantfantastic/fraternity/badge.svg)](https://coveralls.io/r/brilliantfantastic/fraternity)
[![Code Climate](https://codeclimate.com/github/brilliantfantastic/fraternity/badges/gpa.svg)](https://codeclimate.com/github/brilliantfantastic/fraternity)

## DESCRIPTION

An easier way to rush for a beta.

A gem allows you to collect and store (using only [the Lotus framework](http://lotusrb.com) as of now) a list of pledges who would like access to your beta. You can send out bids to those pledges and allow them to gain access to your beta.

## INSTALLATION

Add this line to your Gemfile:

```
gem 'fraternity'
```

And then execute:

```
bundle install
```

Or install it yourself:

```
gem install fraternity
```

Create the database table needed:

```
bundle exec rake fraternity:install
```

The above will create the following table.

```
create_table :pledges do |t|
  t.primary_key   :id
  String          :token
  String          :email
  String          :first_name
  String          :last_name
  Integer         :initiation_number
  DateTime        :invited_at
  DateTime        :accepted_at
  DateTime        :created_at
  DateTime        :updated_at
end
```

## USAGE

If you are unfamiliar with the terminology, you can read up at [http://www.unlv.edu/getinvolved/greek-definitions](http://www.unlv.edu/getinvolved/greek-definitions).

### Configuring

In order to use your Fraternity, you have to configure it before you use it.

```
Fraternity.configure do |config|
  configure.database_url = ENV["DATABASE_URL"]
  configure.send_invite = lambda do |pledge|
    BetaMailer.invite_email(pledge).deliver
  end
end
```

### Pledging

To sign up pledges, you first need to rush. Collect email addresses (and any additional information) to get in line for membership at the frat house.

```
params = { email: "jeremy.piven@example.com" } # Optional attributes you want to save such as first_name, last_name, etc.
pledge = Fraternity.rush! params
```

The above saves the information to the pledges database and creates a token for a `Pledge`

### Moving up the initiation line

**Coming soon**

### Inviting a new pledge

Send out email invitations to the next set of pledges based on their initiation number. A quota is specified for the number you want to invite.

```
invited = Fraternity.bid! quota
```

The above saves the date/time of the invite to all the invited pledges and returns an array of the invited.

The above will also call the `send_invite` proc that you have set up in the configuration. You are responsible for sending the invite to the pledge any way you like.

Find out if a pledge has been invited

```
Fraternity::Pledge.find(123).invited?
Fraternity.invited? "steven.speilburg@example.com"
```

Resend an invite

```
Fraternity::Pledge.find(123).bid!
```

### Accepting a pledge

Check to see if a pledge is ready to be crossed into a full member

```
Fraternity::Pledge.find(token).ready?
Fraternity.ready? token
```

Convert the pledge into a full member (accept the invitation).

```
Fraternity::Pledge.cross! token
```

## CONTRIBUTING

1. Clone the repository `git clone https://github.com/brilliantfantastic/fraternity`
1. Create a feature branch `git checkout -b my-awesome-feature`
1. Codez!
1. Commit your changes (small commits please)
1. Push your new branch `git push origin my-awesome-feature`
1. Create a pull request `hub pull-request -b brilliantfantastic:master -h brilliantfantastic:my-awesome-feature`

## RELEASING A NEW GEM

1. Bump the VERSION in `lib/fraternity/version.rb`
1. Commit changes and push to GitHub
1. run `bundle exec rake build`
1. run `bundle exec rake release`
