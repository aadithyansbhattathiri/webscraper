


### 
Node Version 18.0.0

## Step 1
Install rvm. After Install,
install ruby 
``` rvm install 3.2.2 ```
then
``` rvm use 3.2.2 ```

## Step 2:
  a. clone the directory
  b. cd webscraper/web_scraper
  c. ``` bundle install  ```

## Step 3
 Configure Database
 Open .env file

 ```
DATABASE_HOST='127.0.0.1'
DATABASE_USER='<Enter username>'
DATABASE_PASSWORD='<Enter password>'
DATABASE_NAME='web_scraper_development'
TEST_DATABASE_NAME='web_scraper_test'

 ```

 After the above run
 ```
 rails db:create
 ```


 Run the rails application in port 3001
 ```
 rails s -p 3001
 ```


