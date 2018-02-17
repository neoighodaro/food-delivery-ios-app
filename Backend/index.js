// --------------------------------------------------------
// Pull in the libraries
// --------------------------------------------------------

const app = require('express')()
const bodyParser = require('body-parser')
const Pusher = require('pusher')
const PushNotifications = require('pusher-push-notifications-node');

let pusher = new Pusher(require('./config.js')['pusher'])
let pushNotifications = new PushNotifications(require('./config.js')['pusher_notifications']);

// --------------------------------------------------------
// Helpers
// --------------------------------------------------------

function randomString(amount) {
    var text = "";
    let possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

    for (var i = 0; i < amount; i++) {
        text += possible.charAt(Math.floor(Math.random() * possible.length))
    }

    return text;
}

function getStatusNotificationForOrder(order) {
    let pizza = order['pizza']

    switch (order['status']) {
        case "Pending":
            return false;
        case "Accepted":
            return `Your order "${pizza['name']}" is being processed.`
        case "Dispatched":
            return `Your order "${pizza['name']}" has been dispatched.`
        case "Delivered":
            return `Your order "${pizza['name']}" has been delivered.`
        default:
            return false;
    }
}

// --------------------------------------------------------
// In-memory database
// --------------------------------------------------------

var orders = []

let inventory = [
    {
        id: randomString(16),
        name: "Pizza Margherita",
        description: "Features tomatoes, sliced mozzarella, basil, and extra virgin olive oil.",
        amount: 39.99,
        image: 'pizza1'
    },
    {
        id: randomString(16),
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

app.post('/orders', (req, res) => {
    let id = randomString(16)
    let pizza = inventory.find(item => item["id"] === req.body.pizza_id)

    if (!pizza) {
        return res.json({status: false})
    }

    pushNotifications.publish(['orders'], {
        apns: {
            aps: {
                alert: {
                    title: "New Order Arrived",
                    body: `An order for ${pizza['name']} has been made.`,
                },
                sound: 'default'
            }
        }
    })
    .then(response => console.log('Just published:', response.publishId))
    .catch(error => console.log('Error:', error));

    orders.unshift({id, pizza, status: "Pending"})
    res.json({status: true})
})

app.put('/orders/:id', (req, res) => {
    let order = orders.find(order => order["id"] === req.params.id)

    if ( ! order) {
        return res.json({status: false})
    }

    orders[orders.indexOf(order)]["status"] = req.body.status

    let alertMessage = getStatusNotificationForOrder(order)

    if (alertMessage !== false) {
        pushNotifications.publish(['orders_clientID'], {
            apns: {
                aps: {
                    alert: {
                        title: "Order Information",
                        body: alertMessage,
                    },
                    sound: 'default'
                }
            }
        })
        .then(response => console.log('Just published:', response.publishId))
        .catch(error => console.log('Error:', error));
    }

    return res.json({status: true})
})

app.get('/inventory', (req, res) => res.json(inventory))

app.get('/', (req, res) => res.json({status: "success"}))


// --------------------------------------------------------
// Serve application
// --------------------------------------------------------

app.listen(4000, _ => console.log('App listening on port 4000!'))
