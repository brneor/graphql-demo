fetch('http://localhost:5000', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(
        { query: '{ greetings { hello } }' }
    ),
})
    .then(res => res.json())
    .then(res => console.log(res.data));