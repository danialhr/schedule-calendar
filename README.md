### Schedule Calendar - Code Review Interview Repo
Disclaimer: This is a sample submission from a junior developer. It is a partial implementation and does not represent our company's coding standards or best practices. It exists purely for interview and training purposes.

### 🎯 Interview Purpose
This repository contains a code submission for a calendar scheduling feature. Your task is not to build a feature from scratch, but to review and refactor this code as a Senior Engineer would.

We will evaluate you on:

Your ability to analyze and critique existing code.

Your skill in designing improvements for structure, clarity, and performance.

Your proficiency in implementing these changes and writing comprehensive tests.

Your communication around the rationale for your changes.

### 🎯 Your Exercise: The Senior Engineer's Review
Your goal is to make this code production-ready. Please be prepared to:

Code Review: Identify and explain the strengths and weaknesses of the current implementation.

Refactor: Improve the code structure, naming, and efficiency. Justify your design choices.

Implement Features: Complete the implementation for:

Adding a new event without time conflicts.

Write Tests: Build a robust test suite that ensures reliability, covering happy paths, edge cases, and potential failures.

Document: Add clear comments and update the README to explain your changes.

## Getting started

<!-- Project setup -->

### Project setup

1. Clone the repo
   ```bash
   git clone https://github.com/adrianojec/schedule_calendar.git
   ```
2. Update dependencies:

   ```bash
   flutter pub get
   ```

<!-- Airtable setup -->

### Airtable setup

1. Create an airtable account and [login](https://airtable.com/login)
2. Access the base [Schedule Calendar](https://airtable.com/invite/l?inviteId=invK7DI1WLSkp4oHp&inviteToken=baffa1f25880ae4640112f59e89d9638080d26305dc47d5f2e1af0c4a43a9610&utm_medium=email&utm_source=product_team&utm_content=transactional-alerts)

<!-- Create token -->

### Create token

1. Go to [Create token page](https://airtable.com/create/tokens).
2. Click `Create token`.
3. Name your token and add these scopes:

   ```
   - data.records:read
   - data.records:write
   ```

4. A modal will pop and make sure copy your `token` as this will be your `API_KEY`.

<!-- Get base id -->

### Get base ID

1. Select your base [Schedule Calendar](https://airtable.com/).
2. Click `Help` on the top-right nav.
3. Select the `API Documentation` from the sidebar.
4. On the `Introduction` tab, look for: `The ID of this base is ...`.
5. Make sure to copy as this will your `SCHEMA_ID`.

<!-- Environment variables -->

### Environment variables

1. Create a file named `.env` at the root of the project.
2. You can check `.env.example` as your guide.
3. Populate necessary keys from previous steps:

   ```
   BASE_URL=https://api.airtable.com/v0
   API_KEY=your-api-key
   SCHEMA_ID=your-schema-id
   ```

<!-- Run the project -->

### Run the project

1. Choose an simulator
2. Run:

   ```bash
   flutter run
   ```

### Assumptions

- On the first screen, UI where textfield is located is not a bottom sheet
- Adding new event is for multiple sessions only
- For multiple sessions, you can only add the same event
- You can schedule the same event in a day but with different time
- If you have multiple events to add, notes will be added on all events
- That dates are available for 1 time selection schedule

### Api implementation

- Created a base and tables with details needed in the app

  - Coaches
  - Events
  - Schedules

- Use `Api Documentation` for getting these values:

  - Base url
  - Base id
  - Model structures
  - Return structures

- Then I used the http package to have a request to API and used POSTMAN as well for testing the request and the data needed for post request
