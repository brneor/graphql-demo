using System;

using HotChocolate;
using HotChocolate.Execution;

namespace graphql_console
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var schema = SchemaBuilder.New()
            .AddQueryType<Query>()
            .Create();
            var executor = schema.MakeExecutable();

            Console.WriteLine(executor.Execute("{ hello }").ToJson());

            Console.WriteLine(executor.Execute("{ foo }").ToJson());
        }
    }

    public class Query
    {
        public string Hello() => "world";
    }
}
