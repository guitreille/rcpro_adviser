# RCPRO Insurance adviser

This back-end Ruby program advises a potential future client intereseted in a professional liability insurance ('RC Professionelle' in french). Based on his/her company's profile and insurances of interest, a quote from a well-defined API is sent in reponse. The user can the easily view its older simulations, and his contact is saved for the company.

## Features ##
* Implementation using Ruby on Rails, following its typical MVC patterns.
* SQLITE3 relational database containing a few tables
* Bootstrapped, for very basic and quick css.
* easy local running on localhost:3000 using rails' server.
* API call with HTTPARTY library to a specific insurance API (not publicly provided) to get the quote.

### Requirements: ### 
* Ruby 3.1.2 (not tested on older versions)
* Rails 7.0.4 (not tested on older versions)
* SQLITE3 1.4 (not tested on older versions)

## Quick start: ##
1. If not installed already, install ruby, rails and sqlite3
2. run `bundle install` in the project folder to install the required gems
3. Add your API_KEY and the API_URI in `config/local_env.yml` (not publicly shared)
4. start the rails server with `bundle install`
5. Visit the webpages on `http://localhost:3000/`

WARNING: don't drop/reset the existing database, as it already contains a table with nacebel codes that shouldn't be emptied.
Use rails code instead (MODEL.delete_all) would you want to erase the content of some tables.

## About the database: ##
* the 'lead' table contains every new (new = based on e-mail and phone number) lead with the required cibtact information.
* the 'request' table stores all requests and its parameters, no matter of the success of the API call. This table is linked to the 'lead' table by lead_id.
* the 'quotes' table contains all successfully fetched quotes, linked to the respective 'request' table with 'request_id'
* the 'nacebels' table contains all level-5 nacebel codes (2008) with labels in French and Dutch.

Based on the sector (that you can change in the local_env.yml file, here: 'medical' or 'informatics'), specific nacebel codes are loaded and specific advise is given. Note that you will have to restart the rails server if you change the sector.


## Further work: ##
* Internationalize the program (french, dutch, english) with locales.
* Store the sectors in a separate table in de the db, each sector linked to specific nacebel codes. The idea would then be to update the proposed insurances on the form based on the selected sector (it would require to save the selected sector in the quotes table) using jquery for example.
* Session log-in for users.
* Automatically sending an e-mail to the user after a simulation.
* Front-end...

