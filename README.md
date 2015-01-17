Fraternity
==========

[ ![Codeship Status for brilliantfantastic/fraternity](https://codeship.com/projects/3fe0d950-80a4-0132-9038-321707412590/status?branch=master)](https://codeship.com/projects/57522)
[![Coverage Status](https://coveralls.io/repos/brilliantfantastic/fraternity/badge.svg)](https://coveralls.io/r/brilliantfantastic/fraternity)

## DESCRIPTION

An easier way to rush for a beta.

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

## USAGE

If you are unfamiliar with the terminology, you can read up at [http://www.unlv.edu/getinvolved/greek-definitions](http://www.unlv.edu/getinvolved/greek-definitions).

### Pledging

To sign up pledges, you first need to rush. Collect email addresses (and any additional information) to get in line for membership at the frat house.

```
params = { email: "jeremy.piven@example.com" } # Optional attributes you want to save such as first_name, last_name, etc.
pledge = Fraternity.rush! params
```

The above saves the information to the pledges database and creates a token for a `Pledge`

```
create_table :pledges do |t|
  t.string    :token
  t.string    :email
  t.datetime  :sent_at
  t.datetime  :invited_at
  t.datetime  :accepted_at
  t.integer   :initiation_number

  t.timestamps
end
```

### Moving up the initiation line

**Coming soon**

### Inviting a new pledge

Send out email invitations to the next set of pledges based on their initiation number. A quota is specified for the number you want to invite.

```
invited = Fraternity.bid! quota
```

The above saves the date/time of the invite to all the invited pledges and returns an array of the invited.

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
