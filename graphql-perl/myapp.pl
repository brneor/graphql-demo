#!/usr/bin/env perl

# Run thir script with:
# perl myapp.pl daemon -l http://*:5000

use Mojolicious::Lite;
use GraphQL::Schema;

my $schema = GraphQL::Schema->from_doc(<<'EOF');
type Query {
  quoteOfTheDay: String
  random: Float!
  rollThreeDice: [Int]
  user: Person
}
type Person {
  nome: String
  idade: Int
}
EOF
my $root_value = {
  quoteOfTheDay => sub {rand() < 0.5 ? 'Take it easy' : 'Salvation lies within'},
  random => sub {rand()},
  rollThreeDice => sub {[map 1+int(rand()*6), (1..3)]},
  user => {
    nome => "Breno",
    idade => 27,
  }
};
plugin GraphQL => {
  schema => $schema,
  root_value => $root_value,
  graphiql => 1,
};

get '/' => sub {
  my $c = shift;
  $c->render(template => 'index');
};

get '/wow' => sub {
  my $c = shift;
  $c->render(template => 'wow');
};

get '/hello' => sub {
  my $c = shift;
  my $user = $c->param('user');
  $user =~ s/</&lt;/ig;
  $user =~ s/>/&gt;/ig;

  $c->stash(user => $user);
  $c->render(template=> 'hello');
};

get '/http' => sub {
  my $c    = shift;
  my $host = $c->req->url->to_abs->host;
  my $ua   = $c->req->headers->user_agent;
  $c->render(text => "Request by $ua reached $host.");
};

post '/echo' => sub {
  my $c = shift;
  $c->res->headers->header('X-Bender' => 'Bite my shiny metal ass!');
  $c->render(data => $c->req->body);
};

put '/reverse' => sub {
  my $c    = shift;
  my $hash = $c->req->json;
  $hash->{message} = reverse $hash->{message};
  $c->render(json => $hash);
};

app->start;
__DATA__

@@ index.html.ep
% layout 'default';
% title 'Welcome';
<h3>GraphQL Test</h3>
<button onclick="getData()">Get data</button>

<p>A query executada pelo botão é <pre>{ query: { user { nome, idade } } }</pre></p>

<script>
  function getData(){
    fetch('http://brenoperes.centralx.org:5000/graphql', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(
          { query: "{ user { nome, idade } }" }
      ),
    })
      .then(res => res.json())
      //.then(res => console.log(res.data))
      .then(res => alert(JSON.stringify(res.data)));
  }
</script>

@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
  <head><title><%= title %></title></head>
  <body><%= content %></body>
</html>

@@ wow.html.ep
<h2>wow</h2>

@@ hello.html.ep
<p>olar usuário <%= $user %></p>
