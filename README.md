# WeLift ![CI](https://github.com/nskins/we_lift/actions/workflows/ci.yml/badge.svg)

Say hello to the groundbreaking new technology that empowers athletes to achieve greatness.

Imagine the following scenario: you're at the gym on a lovely Sunday morning. It's chest day, and you definitely want to start your workout with the bench press. You know the importance of progressive overload, so you're thinking it'd be a good idea to increase the weight from your last workout. The only problem is... you can't remember what you did last week!

Introducing... WeLift! This powerful and innovative system enables you to track your workouts in as much detail as you need. You'll never again have to rely on memory and guess a suitable weight for today's lift. A sleek and fluid user interface helps you to input data quickly so you can focus on what really matters.

Here's a few of our favorite features:
- Track the weight and reps of each set in your workout.
- An exercise database with plenty of favorites to get you started.
- Don't see your favorite exercise? Easily add a custom exercise!
- Analyze your performance over a long period of time with progress graphs.

Get started today! Check out our [homepage](https://welift.fly.dev) to learn more!

## How to Build

In order to build the application, you'll need to install the following software (if you haven't already):

- Elixir: https://elixir-lang.org/install.html
- PostgreSQL: https://www.postgresql.org/download/

Clone the repository and then navigate your terminal to the `we_lift` directory.

You'll need to install application dependencies:

```
mix deps.get
```

Then you can setup a development database:

```
mix ecto.setup
```

Finally, you can fire up the server:

```
mix phx.server
```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser!!

## Testing

Our test suite consists of unit tests and integration tests. A unit test verifies the correctness of a function (without side effects). This means that, given some input, a function should always produce the same output. In contrast, integration tests allow us to test how our code interacts with its environment. This enables us to verify that our code behaves correctly given, say, the state of the database or the state of the browser.

In order to run the test suite, just run the following command:

```
mix test
```

## Continuous Delivery

There is a GitHub Actions workflow that builds and tests the code on any pull request to the `main` branch. This helps us to prevent bugs from reaching `main` because the code must compile and pass test cases before a merge is allowed. We also have a separate workflow that deploys the application on any push to `main`.

## Database

WeLift utilizes [Ecto](https://github.com/elixir-ecto/ecto) to interact with PostgreSQL. To learn more about Ecto, please visit the [official documentation](https://hexdocs.pm/ecto/Ecto.html).

You can configure database connection parameters in the `/config` directory. Specifically, you can update [dev.exs](config/dev.exs) for local development and [test.exs](config/test.exs) for the test environment. For the production environment, it is recommended to set the value `DATABASE_URL` in [runtime.exs](config/runtime.exs) as a system environment variable to protect the security of your credentials.

## Deployment

To learn how to deploy the app, please visit the [official documentation](https://hexdocs.pm/phoenix/deployment.html).

## Architecture

WeLift uses the standard MVC architecture common to most Phoenix LiveView applications. There is a very particular directory structure that indicates precisely where each different piece goes; [here](https://hexdocs.pm/phoenix/directory_structure.html) is more information if you'd like to learn more. In fact, I'd recommend reading through most of the [official Phoenix guides](https://hexdocs.pm/phoenix/overview.html) if you haven't already. WeLift follows the recommended best practices given by that documentation... and honestly, the documentation is so good that it's going to be the best reference for any questions you have.
