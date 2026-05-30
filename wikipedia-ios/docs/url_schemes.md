# URL schemes

The URL scheme is `wikipedia://`. The following URLs are currently handled:

| Feature            | Format                                   | Example                                  |
| ------------------ | ---------------------------------------- | ---------------------------------------- |
| Article            | wikipedia://[site]/wiki/[page_id]        | wikipedia://en.wikipedia.org/wiki/Red    |
|                    | https://[[site]/wiki/[page_id]           | https://en.wikipedia.org/wiki/Red        |
| Content            | wikipedia://content                      | wikipedia://content/on-this-day/wikipedia.org/en/2024/08/15                                         |
| Explore            | wikipedia://explore                      |                                          |
| History            | wikipedia://history                      |                                          |
| Places             | wikipedia://places[?WMFArticleURL=] or [?latitude=&longitude=] | wikipedia://places?latitude=51.5074&longitude=-0.1278 (London) or wikipedia://places?latitude=52.3676&longitude=4.9041 (Amsterdam) |
| Saved pages        | wikipedia://saved                        |                                          |

For Places, `WMFArticleURL` takes precedence when both article and coordinate query parameters are present.
