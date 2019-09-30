# README

Basic Information:

**Ruby Version:** 2.4.1

**Rails Version:** 5.2.3

**Database:** Postgresql

**Background:** 

This app is a Ruby on Rails API that stores projects that have an image associated with it. In order to create a project, a _name_, _description_, _creator's email_, and the associated _image_ are all required. The Project model also has a _timestamp_ attribute which represents the time the project was _created at_.

Once a project has been created, a background worker will resize the image to a maximum of 200 x 200 pixels. This thumbnail can later be accessed.

This app has not been deployed yet so all interactions will be done locally on your machine.

# DEVELOPMENT

* Clone this repo to your local machine.

* run `bundle` in your terminal.

* run `rake db:create` and `rake db:migrate` in your terminal.

* run `rails s` to start the rails server. Make sure it is running on port: 3000.

* open a seperate terminal window and run `redis-server /usr/local/etc/redis.conf` to start the redis server.

* open a third terminal window and run `sidekiq` or `bundle exec sidekiq` from inside the app directory.

You now have everything you need to interact with the app.

# INTERACTION

## _Create a Project_

For a quick UI to be able to create projects, copy and paste the below code into an html file and open it from your browser.

```
<!DOCTYPE html>
<html>
  <head>
    <title></title>
  </head>
  <body>

    <form id="my_form" enctype="multipart/form-data" accept-charset="UTF-8">
    <input name="utf8" type="hidden" value="✓">
      <input placeholder="name"
             type="text"
             name="project[name]"
             id="project_name"/>
      <br>
      <textarea placeholder="description"
                name="project[description]"
                id="project_description">
      </textarea>
      <br>
      <input placeholder="email"
             type="email"
             name="project[creator_email]"
             id="project_creator_email">
       <br>
      <input type="file"
             name="project[image]"
             id="project_image">
       <br>

      <input type="submit" name="commit" value="Create Project" data-disable-with="Create Project">
    </form>

    <div id="results" />


    <script type="text/javascript">
      const form = document.querySelector("#my_form");
      const image_upload = document.querySelector("#project_image");
      const results = document.querySelector("#results");

      form.addEventListener("submit", e => {
        /* preventDefault, so that the page doesn't refresh */
        e.preventDefault();

        const formData = new FormData(form);
        
        fetch("http://localhost:3000/api/projects", {
          method: "POST",
          body: formData
        }).then(response => { return response.json() }).then(data => {
            results.innerHTML = `
            <p><strong>id:</strong> ${data.id}</p>
            <p><strong>name:</strong> ${data.name}</p>
            <p><strong>description:</strong> ${data.description}</p>
            <p><strong>creator_email:</strong> ${data.creator_email}</p>
            <p><strong>timestamp:</strong> ${data.created_at}</p>
          `;
        });
      });
    </script>
  </body>
</html>
```

* Fill out the fields for the displayed form and click on **Create Project**. The information displayed on the screen comes from the resulting JSON provided for that POST call.

## Get All Projects

* A simple GET to `http://localhost:3000/api/projects/` will respond with a list of all the projects created in descending order by their timestamps.

## Get Resized Image

* Append the url for *get all projects* with the `project_id` followed by `thumbnail`. For example, if you would like to get the thumbnail for the first project, make a GET to `http://localhost:3000/api/projects/1/thumbnail`. 
* This endpoint responds with the url for the thumbnail.

