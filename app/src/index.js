const express = require('express');

const app = express();

app.use('/', (req, res) => {
	return res.send('Success');
});

app.listen(3000, () => {
	console.log('Running');
});
