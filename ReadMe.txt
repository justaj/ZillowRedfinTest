The features folder contains the Redfin test.

The spec folder contains the Zillow test.


Please open each respective YML file to configure each test.

Once configured you can kick off the Redfin test using:
cucumber -t @login
Please note: The test occasionally fails as the search results also include neighboring cities which
causes the city assertion to fail.  You may add bypass=true if you want to skip that validation.
i.e. cucumber -t @login bypass=true

The Zillow test can be executed using:
rspec get_property_details.rb
