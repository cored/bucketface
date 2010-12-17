# bucketface

Simple Ruby wrapper for the Bitbucket API. (This code is based on octopussy)

## Installation

    sudo gem install bucketface

## Some examples

### Show a user

    Bucketface.user('cored')
    <#Hashie::Mash first_name="Rafael" last_name="George" resource_uri="/1.0/users/cored/" username="cored">

### Show followers for a giving user

    Bucketface.followers('cored')
    [<#Hashie::Mash _state="<django.db.models.base.ModelState object at 0x66d8590>" avatar_id=nil cname=nil differ="udiff" digest="b0634325ca1a1bb69bd227f521b9b20c" email_notifications=false feature_per_user_pricing=true id=1600 location="Denver, CO" plan_id=7 user_id=1602 website="http://www.percious.com/">, <#Hashie::Mash _state="<django.db.models.base.ModelState object at 0x66d8f90>" avatar_id=nil cname=nil differ="udiff" digest="861e1c2f15e3fc5f55b32a1e10f6ec78" email_notifications=true feature_per_user_pricing=true id=7010 location=nil plan_id=7 user_id=7012 website=nil>, <#Hashie::Mash _state="<django.db.models.base.ModelState object at 0x66d88d0>" avatar_id=nil cname=nil differ="udiff" digest="24c19e325a62a293c26c2f38ee62f6ef" email_notifications=true feature_per_user_pricing=true id=1906 location="Detroit, Michigan, USA" plan_id=7 user_id=1908 website="http://lost-theory.org/">]

### Working with repositories

Methods that require a repo argument may be passed in any of the following forms

* "cored/test-repo"
* {:username => 'cored', :name => 'test-repo'}
* {:username => 'cored', :repo => 'test-repo'}
* instance of Repo

### Show a repo

    Bucketface.repo("cored/test-repo")
    <#Hashie::Mash description="Testing ticketmaster with this repo" followers_count=1 name="test-repo" slug="test-repo" website="">

## Authenticated requests

Some methods require authentication so you'll need to pass a login and a password.

    client = Bucketface::Client.new(:login => 'cored', :password => 'hithere')
    client.open_issue('cored/test-repo', 'testing', 'testing')

## TODO

* Add documentation to all classes
* Functionality for the following API resources
  * Privileges
  * Wiki
  * Source
* Create examples
* Refactor code to abstract functionality from client class
* Add bad response handling

## Note on Patches/Pull requests

* Fork the project
* Make your feature addition or bug fix
* Add tests for it. This is important so I don't break it in a future version unintentionally
* Commit, do not mess with rakefile, version, or history
  (if you want to have your own version, that is fine but bump version in a commit by itself 
  I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Credits

Bucketface is based and inspired by [Octopussy](http://github.com/pengwynn/octopussy)

## Copyright

Copyright (c) 2010 [Rafael George](http://bandw.tumblr.com)
