fetch('http://brenoperes.centralx.org:5000/graphql', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(
        { query: "{ quoteOfTheDay }" }
    ),
})
    .then(res => res.json())
    .then(res => console.log(res.data));

fetch('http://brenoperes.centralx.org:5000/echo', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({data: {nome: "Breno", idade: "27"}}),
})
    .then(res => res.json())
    .then(res => console.log(res.data));