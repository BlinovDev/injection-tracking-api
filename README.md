# injection-tracking-api

## Description

This project is a RESTful API for tracking medication injections for patients, built with Ruby on Rails. It is designed for healthcare or research settings where monitoring patient adherence to injection schedules is critical.

### Key Features
- **Patient Management:** Register and manage patients, each with a unique API key for secure access.
- **Injection Tracking:** Record and retrieve injection events, including dose, lot number, and timestamp.
- **Schedules:** Assign medication schedules to patients, specifying drug name and injection interval.
- **Adherence Analytics:** Calculate adherence statistics, such as expected vs. actual injections and on-time rates, to monitor patient compliance.
- **OpenAPI Documentation:** Interactive API documentation available at `/api-docs` for easy exploration and testing.

The API is suitable for integration with mobile apps, research dashboards, or clinical systems that require robust injection tracking and adherence analytics.

For manual testing feel free to import `injection-tracking-api.postman_collection.json` into your postman and use it. All main application functions are present there.

## Run with Docker
```bash
  docker-compose build
  docker-compose up
```

Try to access `http://localhost:3000/api-docs/index.html` and press 'Run pending migrations'

Congrats!

To run specs open another terminal window and run:
```bash
  docker-compose run web bundle exec rspec
```
