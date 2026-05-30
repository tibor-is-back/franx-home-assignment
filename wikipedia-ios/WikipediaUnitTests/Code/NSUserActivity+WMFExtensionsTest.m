#import <XCTest/XCTest.h>
#import "NSUserActivity+WMFExtensions.h"

@interface NSUserActivity_WMFExtensions_wmf_activityForWikipediaScheme_Test : XCTestCase
@end

@implementation NSUserActivity_WMFExtensions_wmf_activityForWikipediaScheme_Test

- (void)testURLWithoutWikipediaSchemeReturnsNil {
    NSURL *url = [NSURL URLWithString:@"http://www.foo.com"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertNil(activity);
}

- (void)testInvalidArticleURLReturnsNil {
    NSURL *url = [NSURL URLWithString:@"wikipedia://en.wikipedia.org/Foo"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertNil(activity);
}

- (void)testArticleURL {
    NSURL *url = [NSURL URLWithString:@"wikipedia://en.wikipedia.org/wiki/Foo"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypeLink);
    XCTAssertEqualObjects(activity.webpageURL.absoluteString, @"https://en.wikipedia.org/wiki/Foo");
}

- (void)testExploreURL {
    NSURL *url = [NSURL URLWithString:@"wikipedia://explore"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypeExplore);
}

- (void)testSavedURL {
    NSURL *url = [NSURL URLWithString:@"wikipedia://saved"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypeSavedPages);
}

- (void)testSearchURL {
    NSURL *url = [NSURL URLWithString:@"wikipedia://en.wikipedia.org/w/index.php?search=dog"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypeLink);
    XCTAssertEqualObjects(activity.webpageURL.absoluteString,
                          @"https://en.wikipedia.org/w/index.php?search=dog&title=Special:Search&fulltext=1");
}

#pragma mark - Places

- (void)testPlacesURL {
    // Given
    NSURL *url = [NSURL URLWithString:@"wikipedia://places"];

    // When
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];

    // Then
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypePlaces);
    XCTAssertEqualObjects(activity.userInfo[@"WMFPage"], @"Places");
    XCTAssertNil(activity.webpageURL);
    XCTAssertNil(activity.wmf_latitude);
    XCTAssertNil(activity.wmf_longitude);
}

- (void)testPlacesURLWithArticleURL {
    // Given
    NSURL *url = [NSURL URLWithString:@"wikipedia://places/?WMFArticleURL=https://en.wikipedia.org/wiki/Dallas"];

    // When
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];

    // Then
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypePlaces);
    XCTAssertEqualObjects(activity.webpageURL.absoluteString, @"https://en.wikipedia.org/wiki/Dallas");
    XCTAssertNil(activity.wmf_latitude);
    XCTAssertNil(activity.wmf_longitude);
}

- (void)testPlacesURLWithCoordinates {
    // Given
    NSURL *url = [NSURL URLWithString:@"wikipedia://places?latitude=48.8584&longitude=2.2945"];

    // When
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];

    // Then
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypePlaces);
    XCTAssertNil(activity.webpageURL);
    XCTAssertEqualObjects(activity.wmf_latitude, @48.8584);
    XCTAssertEqualObjects(activity.wmf_longitude, @2.2945);
}

- (void)testPlacesURLWithCoordinatesMissingLongitude {
    // Given
    NSURL *url = [NSURL URLWithString:@"wikipedia://places?latitude=48.8584"];

    // When
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];

    // Then
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypePlaces);
    XCTAssertNil(activity.webpageURL);
    XCTAssertNil(activity.wmf_latitude);
    XCTAssertNil(activity.wmf_longitude);
}

- (void)testPlacesURLWithCoordinatesMissingLatitude {
    // Given
    NSURL *url = [NSURL URLWithString:@"wikipedia://places?longitude=2.2945"];

    // When
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];

    // Then
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypePlaces);
    XCTAssertNil(activity.webpageURL);
    XCTAssertNil(activity.wmf_latitude);
    XCTAssertNil(activity.wmf_longitude);
}

- (void)testPlacesURLArticleURLTakesPrecedenceOverCoordinates {
    // Given
    NSURL *url = [NSURL URLWithString:@"wikipedia://places/?WMFArticleURL=https://en.wikipedia.org/wiki/Dallas&latitude=48.8584&longitude=2.2945"];

    // When
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];

    // Then
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypePlaces);
    XCTAssertEqualObjects(activity.webpageURL.absoluteString, @"https://en.wikipedia.org/wiki/Dallas");
    XCTAssertNil(activity.wmf_latitude);
    XCTAssertNil(activity.wmf_longitude);
}

#pragma mark - Places coordinate helpers

- (void)testWmfLatitudeAndLongitudeReturnNilForNonPlacesActivity {
    // Given
    NSURL *url = [NSURL URLWithString:@"wikipedia://explore"];

    // When
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];

    // Then
    XCTAssertNil(activity.wmf_latitude);
    XCTAssertNil(activity.wmf_longitude);
}

- (void)testWmfLatitudeAndLongitudeReturnNilWhenUserInfoHasNoCoordinates {
    // Given
    NSURL *url = [NSURL URLWithString:@"wikipedia://places"];

    // When
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];

    // Then
    XCTAssertNil(activity.wmf_latitude);
    XCTAssertNil(activity.wmf_longitude);
}

- (void)testWmfLatitudeAndLongitudeReadNSNumberValuesFromUserInfo {
    // Given
    NSUserActivity *activity = [[NSUserActivity alloc] initWithActivityType:@"org.wikimedia.wikipedia.test"];
    activity.userInfo = @{@"latitude": @51.5074, @"longitude": @(-0.1278)};

    // When
    NSNumber *latitude = activity.wmf_latitude;
    NSNumber *longitude = activity.wmf_longitude;

    // Then
    XCTAssertEqualObjects(latitude, @51.5074);
    XCTAssertEqualObjects(longitude, @(-0.1278));
}

@end
