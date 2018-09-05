<p align="center">

<img src="http://liveshopapp.com.s3.amazonaws.com/github/liveshop-for-developers.png" alt="LiveShop iOS SDK" title="LiveShop iOS SDK" width="557"/>

</p>

LiveShop iOS SDK is a simple SDK to provide apps a live streaming application as a service. Here we manage all the streaming servers and hosts to sell goods. To start using, get your license key at hello@liveshopapp.com

## Features

- [x] Simple api to listen rooms
- [x] Play with custom screen
- [x] Listen buy events

The simplest use-case is getting all live rooms `getRooms` from `LiveShop` instance and start the first one:

```swift
liveShop = LiveShop(appKey: "<YOUR_API_KEY_HERE>")
liveShop.getRooms { (rooms, error) in
    self.room = rooms?[0]
    guard let room = self.room else { return print(error!) }
    
    liveShop.start(room: room, navigationController: self.navigationController!, shopButtonPressed: {
        
    }, dismissButtonPressed: {
        self.navigationController?.dismiss(animated: true, completion: nil)
    })
}
```

### Contact

Follow and contact me on [Twitter](http://twitter.com/mmarqueti). 

### Issues

If you find an issue, just [open a ticket](https://github.com/liveshopapp/sdk-ios/issues/new)


### License

LiveShop iOS SDK is released under the MIT license. See LICENSE for details.

