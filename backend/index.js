// --------------------------------------------------------
// Pull in the libraries
// --------------------------------------------------------

const app = require('express')()
const bodyParser = require('body-parser')
const pusher = require('pusher')(require('./config.js'))


// --------------------------------------------------------
// In-memory
// --------------------------------------------------------

var orders = []

let inventory = [
    {
        name: "Pizza Margherita",
        description: "Features tomatoes, sliced mozzarella, basil, and extra virgin olive oil.",
        amount: 39.99,
        image: 'pizza1'
    },
    {
        name: "Bacon cheese fry",
        description: "Features tomatoes, bacon, cheese, basil and oil",
        amount: 29.99,
        image: 'pizza2'
    }
]


// --------------------------------------------------------
// Express Middlewares
// --------------------------------------------------------

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended: false}))


// --------------------------------------------------------
// Routes
// --------------------------------------------------------

app.get('/orders', (req, res) => res.json(orders))
app.get('/inventory', (req, res) => res.json(inventory))
app.get('/', (req, res) => res.json({status: "success"}))


// --------------------------------------------------------
// Serve application
// --------------------------------------------------------

app.listen(4000, _ => console.log('App listening on port 4000!'))
