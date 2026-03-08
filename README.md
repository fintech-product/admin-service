# simple-sql-rest-api-ts

## Available Scripts

### `npm start`

Runs the app in the development mode.

### `npm run build`

Builds the app for production to the `dist` folder.

### `npm run prod`

Runs the app for production in the `dist` folder.

## Architecture

### Architecture

![User Role Service](https://cdn-images-1.medium.com/max/800/1*Gm0dypLuYaPwGM8UzrzV7w.png)

### Search users: Support both GET and POST

#### POST /users/search

##### _Request:_ POST /users/search

In the below sample, search users with these criteria:

- get users of page "1", with page size "20"
- email="tony": get users with email starting with "tony"
- dateOfBirth between "min" and "max" (between 1953-11-16 and 1976-11-16)
- sort by phone ascending, id descending

```json
{
  "page": 1,
  "limit": 20,
  "sort": "phone,-id",
  "email": "tony",
  "dateOfBirth": {
    "min": "1953-11-16T00:00:00+07:00",
    "max": "1976-11-16T00:00:00+07:00"
  }
}
```

##### GET /users/search?page=1&limit=2&email=tony&dateOfBirth.min=1953-11-16T00:00:00+07:00&dateOfBirth.max=1976-11-16T00:00:00+07:00&sort=phone,-id

In this sample, search users with these criteria:

- get users of page "1", with page size "20"
- email="tony": get users with email starting with "tony"
- dateOfBirth between "min" and "max" (between 1953-11-16 and 1976-11-16)
- sort by phone ascending, id descending

#### _Response:_

- total: total of users, which is used to calculate numbers of pages at client
- list: list of users

```json
{
  "list": [
    {
      "id": "ironman",
      "username": "tony.stark",
      "email": "tony.stark@gmail.com",
      "phone": "0987654321",
      "dateOfBirth": "1963-03-24T17:00:00Z"
    }
  ],
  "total": 1
}
```

## API Design

### Common HTTP methods

- GET: retrieve a representation of the resource
- POST: create a new resource
- PUT: update the resource
- PATCH: perform a partial update of a resource, refer to [service](https://github.com/core-go/service) and [mongo](https://github.com/core-go/mongo)
- DELETE: delete a resource

## API design for health check

To check if the service is available.

#### _Request:_ GET /health

#### _Response:_

```json
{
  "status": "UP",
  "details": {
    "mongo": {
      "status": "UP"
    }
  }
}
```

## API design for users

#### _Resource:_ users

### Get all users

#### _Request:_ GET /users

#### _Response:_

```json
[
  {
    "id": "spiderman",
    "username": "peter.parker",
    "email": "peter.parker@gmail.com",
    "phone": "0987654321",
    "dateOfBirth": "1962-08-25T16:59:59.999Z"
  },
  {
    "id": "wolverine",
    "username": "james.howlett",
    "email": "james.howlett@gmail.com",
    "phone": "0987654321",
    "dateOfBirth": "1974-11-16T16:59:59.999Z"
  }
]
```

### Get one user by id

#### _Request:_ GET /users/:id

```shell
GET /users/wolverine
```

#### _Response:_

```json
{
  "id": "wolverine",
  "username": "james.howlett",
  "email": "james.howlett@gmail.com",
  "phone": "0987654321",
  "dateOfBirth": "1974-11-16T16:59:59.999Z"
}
```

### Create a new user

#### _Request:_ POST /users

```json
{
  "id": "wolverine",
  "username": "james.howlett",
  "email": "james.howlett@gmail.com",
  "phone": "0987654321",
  "dateOfBirth": "1974-11-16T16:59:59.999Z"
}
```

#### _Response:_

- status: configurable; 1: success, 0: duplicate key, 4: error

```json
{
  "status": 1,
  "value": {
    "id": "wolverine",
    "username": "james.howlett",
    "email": "james.howlett@gmail.com",
    "phone": "0987654321",
    "dateOfBirth": "1974-11-16T00:00:00+07:00"
  }
}
```

#### _Fail case sample:_

- Request:

```json
{
  "id": "wolverine",
  "username": "james.howlett",
  "email": "james.howlett",
  "phone": "0987654321a",
  "dateOfBirth": "1974-11-16T16:59:59.999Z"
}
```

- Response: in this below sample, email and phone are not valid

```json
{
  "status": 4,
  "errors": [
    {
      "field": "email",
      "code": "email"
    },
    {
      "field": "phone",
      "code": "phone"
    }
  ]
}
```

### Update one user by id

#### _Request:_ PUT /users/:id

```shell
PUT /users/wolverine
```

```json
{
  "username": "james.howlett",
  "email": "james.howlett@gmail.com",
  "phone": "0987654321",
  "dateOfBirth": "1974-11-16T16:59:59.999Z"
}
```

#### _Response:_

- status: configurable; 1: success, 0: duplicate key, 2: version error, 4: error

```json
{
  "status": 1,
  "value": {
    "id": "wolverine",
    "username": "james.howlett",
    "email": "james.howlett@gmail.com",
    "phone": "0987654321",
    "dateOfBirth": "1974-11-16T00:00:00+07:00"
  }
}
```

### Patch one user by id

Perform a partial update of user. For example, if you want to update 2 fields: email and phone, you can send the request body of below.

#### _Request:_ PATCH /users/:id

```shell
PATCH /users/wolverine
```

```json
{
  "email": "james.howlett@gmail.com",
  "phone": "0987654321"
}
```

#### _Response:_

- status: configurable; 1: success, 0: duplicate key, 2: version error, 4: error

```json
{
  "status": 1,
  "value": {
    "email": "james.howlett@gmail.com",
    "phone": "0987654321"
  }
}
```

### Delete a new user by id

#### _Request:_ DELETE /users/:id

```shell
DELETE /users/wolverine
```

#### _Response:_ 1: success, 0: not found, -1: error

```json
1
```

### health check

To check if the service is available

#### _Request:_ GET /health

#### _Response:_

```json
{
  "status": "UP",
  "details": {
    "sql": {
      "status": "UP"
    }
  }
}
```
