# QB Shop System

A flexible shop system supporting multiple inventory systems, targeting systems, and notification methods.

## Features

- Support for multiple inventory systems (QB/OX)
- Support for multiple targeting systems (QB/OX)
- Support for multiple notification systems (QB/OX)
- Configurable shop types with unique items
- Multiple locations per shop type
- Custom ped models per shop type
- Custom blip settings per shop type
- Discord webhook logging
- Blur effect on shop open

## Dependencies

- QBCore Framework
- One of:
  - qb-inventory
  - ox_inventory
- One of:
  - qb-target
  - ox_target

## Installation

1. Place the resource in your resources folder
2. Add to server.cfg: `ensure qb-shoping`
3. Configure config.lua to your needs

## Configuration

### Inventory Systems
```lua
Config.Inventory = "ox" -- "qb" or "ox"
```

### Target Systems
```lua
Config.Target = "qb" -- "qb" or "ox"
```

### Notification Systems
```lua
Config.Notify = "ox" -- "qb" or "ox"
```

### Adding New Shops
```lua
Config.ShopTypes["newshop"] = {
    items = {
        { name = 'item1', price = 100 },
        { name = 'item2', price = 200 }
    },
    label = "Shop Name",
    ped = `ped_model_name`,
    blip = {
        sprite = 59,
        color = 2,
        scale = 0.7
    }
}
```

### Adding Shop Locations
```lua
Config.Shops["shopid"] = {
    name = "shop_name",
    type = "shoptype",
    label = "Shop Label",
    locations = {
        vector4(x, y, z, heading),
        vector4(x, y, z, heading)
    }
}
```

## Discord Logging

Set up Discord webhook in config:
```lua
Config.Webhooks = {
    enabled = true,
    url = "YOUR_WEBHOOK_URL",
    color = 3447003,
    logTitle = "Shop System Logs"
}
```
## Support
For any issues or suggestions, feel free to open an issue or contact support!
