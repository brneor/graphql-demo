namespace graphql_web
{
    public class Query
    {
        public Greetings GetGreetings() => new Greetings();
    }

    public class Greetings
    {
        public string Hello() => "World";
        public string Test() => "My graphql test!";
    }
}
