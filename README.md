paperclip_database_storage
==================

Adds support for storing a paperclip attachment file contents in a database table.

Requirements
------------

paperclip_database_storage requires [Paperclip](https://github.com/thoughtbot/paperclip) version **>= 3.2.0**.

Installation
------------

paperclip_database_storage is distributed as a gem, and that is how it should be used in your app.

Include the gem in your `Gemfile`, from rubygems:

      gem 'paperclip_database_storage', '>= 3.2.0'

Or, get the master branch from the repository:

      gem 'paperclip_database_storage', :git => 'git://github.com/gokuu/paperclip_database_storage.git'

And afterwards, run the task to create the necessary migrations:

      rake paperclip_database_storage:setup
Usage
-----

All you need to do is, when defining a [Paperclip](https://github.com/thoughtbot/paperclip) attachment, set its `:storage` option as `:database`:

```ruby
class MyModel < ActiveRecord::Base
  has_attached_file :attachment,
    :storage => :database,
    :styles => {
      :medium => "300x300>",
      :thumb => "100x100>"
    },
    :url => "/:class/:attachment/:id/:style/:basename.:extension"
end
```

Remarks
-------

The migration defined by `paperclip_database_storage` contains several indexes, as every possible combination of the fields that can identify a single attachment. This should help getting an attachment as quickly as possible using any combination of parameters.
As of version 3.0.7, the attachments are stored encoded in base64, to prevent loss of information. All previous stored attachments will still be usable as the table has a new field to indicate whether the attachment is stored base64-encoded.

Limitations
-----------

* Paperclip-database currently only supports one database attachment per model.
* Although you can define a custom :url option for getting the attachment, make sure you define one that uniquelly identifies each attachment, otherwise the plugin will raise an Exception.

TO-DO
-----

* Add tests!
* Add support for more than one database attachment per model
* Enable defining a separate table for each different attachment

Copyright (c) 2012 [Pedro Rodrigues](mailto:pedro@bbde.org), released under the MIT license