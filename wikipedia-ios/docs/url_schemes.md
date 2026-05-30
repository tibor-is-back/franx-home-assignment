# URL schemes

The URL scheme is `wikipedia://`. The following URLs are currently handled:

| Feature            | Format                                   | Example                                  |
| ------------------ | ---------------------------------------- | ---------------------------------------- |
| Article            | wikipedia://[site]/wiki/[page_id]        | wikipedia://en.wikipedia.org/wiki/Red    |
|                    | https://[[site]/wiki/[page_id]           | https://en.wikipedia.org/wiki/Red        |
| Content            | wikipedia://content                      | wikipedia://content/on-this-day/wikipedia.org/en/2024/08/15                                         |
| Explore            | wikipedia://explore                      |                                          |
| History            | wikipedia://history                      |                                          |
| Places             | wikipedia://places[?WMFArticleURL=] or [?latitude=&longitude=] | wikipedia://places/?WMFArticleURL=https://en.wikipedia.org/wiki/Dallas or wikipedia://places?latitude=37.7879&longitude=-122.4075 |
| Saved pages        | wikipedia://saved                        |                                          |

For Places, `WMFArticleURL` takes precedence when both article and coordinate query parameters are present.
