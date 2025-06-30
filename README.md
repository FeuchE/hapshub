# HapsHub: Project Documentation
For groups of people with varied schedules, but shared passions. 

## 🌍 Project overview
Introducing **HapsHub!** A full-stack app that helps groups plan social events by suggesting ideas based on date, location  and category preferences, using Google Places API.
‍
- 🎯 **The goal:** Take the stress out of planning and managing events
- 🛠 **Tech-stack:** Ruby on Rails, JavaScript, HTML, CSS
- 🛠 **Tools:** Figma, Git, PostgreSQL
‍
- 📆 **Dates:** Dates: May 2025 - June 2025
- 📆 **Duration:** 2 weeks 

---
## 🧑‍🔬 💻  📐 📐✅  🖧 🖼️ 👥 🗺️ 🛠 💼 🎓 
## 📣 The pitch

**The problem:**
Have you ever been trying to organise a meetup with a group of friends, but can’t work out what activity to pick? Frustrating right! Trying to keep up with all group chats across multiple apps can feel like a full time job! Why not let us take care of the leg-work, so you can just enjoy your free-time with friends? 

**The solution:**
A new app that takes away the stress of event organisation. Struggling to decide what to do? We can help out and auto-generate ideas based on your selected date, location and category. 

**The target audience:**
- Demographic: 20-40 year old working professionals. 
- People who have busy lives but still want to make time for their friends and try new activities.
- Groups of friends with varied schedules, but shared passions. 

**The features:**
- Suggestions for adventures based on users date, location and category preferences.
- Search  through suggestions.
- Create personalised event pages.
- Invite your friends! 

---

## 🚧 Challenges

### What did we struggle with?

**1. Foreign keys and associations**
- **Challenge**: There were a lot of foreign keys and associations between the model tables.
- **Solution**: Created a DB schema to visualise the back-end structure and map out the foreign keys between the tables.

**2. Adventures and events models and foreign keys**
- **Challenge**: One of the biggest challenges was creating the models and foreign keys in the right order with the correct foreign keys.
- **Solution**: We overcame this challenge by creating events model first, then adventures model with events foreign key. Next, running a migration to add adventure id to events. And another migration to allow null adventure id on events to avoid a loop.  Lastly, under the "belongs_to" associations, we added "optional: true".

**3. API**
- **Challenge**: Our biggest challenge was seeding the suggested adventures based on the users preferences.
- **Solution**: We overcame this challenge by using Google Places API.

---

## 🏆 Accomplishments

### What did we learn?

**✅Technical Skills:**
- Ruby models, controllers and routing
- HTML for views to build structure of the webpages
- Git version control and code reviewing practices
- Accessibility implementation best practices
- Responsive design

**✅Design Skills:**
- SCSS stlying using partials, nesting and chaining
- Creating inclusive user experiences
- Balancing information density with usability
- Building trust through transparent design
- Color theory and contrast for accessibility

**✅Problem-Solving:**
- Used DB schema to visualise the back-end structure
- Breaking down large problems into actionable solutions
- Prioritizing features for maximum impact

---

## 💡 Planning

**User story:**
We mapped out the key user journeys and the purpose behind each step. We prioritised them as we were working to a tight deadline. Next we selected the path, verb, controller and action for each step to help us set up the back-end. Lastly, we assigned each step to team members, according to their interests and skillsets.

**DB schema:**
We planned the DB schema for the app, getting feedback from my team members and TA. This helped us visualise the back-end structure and ensure each model table contained the correct columns, with the corresponding data-type. This was also an invaluable step for checking foreign keys and associations, as there are quite a few! 

**UX/UI prototype:**
Before diving into coding, we created a mock-up of our final design for our key user journey in Figma, utilising their components feature. We created the homepage, groups, calendar, event generation, categories, adventures partials, adventures info, poll notification, poll selector, votes viewer, event info, notifications, and group chat pages. 

**Kanban board and slack channel:**
To collaborate in an agile work environment we created a KanBan board using Github projects. This helped us to visualise the tasks that needed to be completed and keep track of the progress of the project during our morning stand-up and make a plan for everyone for the coming day that maximised efficiency and prioritised urgent tasks. We also used a dedicated slack channel for communications throughout the project.

---

## 🔧 Building the back-end

**Models, Associations and Validations:**
Next we created the models, based off the DB schema. Worked in pair-programming with Marianna reviewing. We used Devise to setup the user model. The biggest  challenge was creating them in the right order with the correct foreign keys. Especially for the adventures and events models as they both dependent on each other. We overcame this challenge by creating events model first, then adventures model with events foreign key. Next, running a migration to add adventure id to events. And another migration to allow null adventure id on events to avoid a loop.  Lastly, under the "belongs_to" associations, we added "optional: true".

**Controllers, Actions and Views:**
We created the base controllers, actions and views. We aimed to work with tasks as features, following the feature flow from route, to controller action, to corresponding view. So we could explore the full-stack development life-cycle from back-end to front-end. However, due to dependencies this wasn't always possible.

**Partials:**
We refractored the initial HTML into partials for code that was reusable, such as index and show cards. This helped us organise our code to improve readability by seperating components into manageable elements, and enabled us to update it and apply tailored SCSS later on.

**New event form:**
To create the new event form, we split each input into a partial and rendered them in the new.html.erb file using simple_form_for. We used nav tabs and next buttons so users could easily navigate through the form. We added HTML5 for the date input to give users the option of adding the date and time on a calendar.

**Search feature:**
To allow users to search through the suggested adventures we used the pg_search gem to build named scopes that utilise PostgreSQL's full text search.

**Delete feature:**
Added delete feature to events with a notification and redirect to events index page.

**API:**
Our biggest challenge was seeding the suggested adventures based on the users preferences, we overcame this challenge by using Google Places API.

---

## 🎨 Styling the front-end

**SCSS:**
- Using the partials and classes we created in the HTML, we linked corresponding tailored SCSS stylesheets.
- For example; We added box-shadow and border-radius to cards to make them stand out from the back-ground. 
- We used flexbox to arrange and align the image and content within the cards to ensure responsive layouts.
- We changed the colour and styling of the CTA buttons so they stand out but still fit into the colour scheme.
- To ensure my code is clean, organised and easy to read we utilised SCSS partials, nesting and chaining.

---

## 🚀 Future plans

As this was a two week sprint we had to prioritse the key user journey, below is a list of features I would like to add in the future to improve the user experience:
- Poll for ideas: allow users to add multiple adventures to a poll, which the members of the group can vote on their favourite.
- Update event: enable users to edit event details such as date and time.
- Create new groups and add members: feature to add a new group and invite members to join.
