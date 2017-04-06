Forex4you Test Assignment
=========================

Let's say, in our system we have two models "client" and "shipping address".
Let's assume that we already have some existing (registered) clients in our database.
Let's do this simple and assume that our clients have only two properties firstname and lastname.

Client can have several different shipping addresses, but max number is 3. One of them is a default address, so when client adds the first address, it becomes default. 
Client can change a default address any time.

Client can add a new address, modify an existing address or remove an existing address.
Client can not remove a default address, thus there should be at least one address (default) if it was added earlier.

Shipping address includes country, city, zipcode, street.

Implement a REST API to provide it to web/mobile clients. 
We should be able to create, update, delete and get shipping addresses. Also get user info.
It's not necessary to implement an authentication layer, but write what way you would implement it.

Backend requirements:
Use PHP 7, Symfony 3 (preferably).
Use DDD (Domain-driven design)
Use Mysql or whatever you want (e.g. in memory DB) for storing data.
Cover at least your application service layer by unit tests.

Client side:
Create a web interface where client can manage his shipping addresses.
It's preferably to use AngularJs (1 or 2).

Fork your own copy of eglobal-it/f4u-test-assignment to your account and share the result with us.

It will be great if you deploy your mini application somewhere and show it in production. But it is optional.
