# WeLift ![CI](https://github.com/nskins/we_lift/actions/workflows/ci.yml/badge.svg)

WeLift is a workout tracking app built with Phoenix LiveView.

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
